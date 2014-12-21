#include "fuzzy_bartender.h"

#include <fl/Headers.h>

#include <chrono>
#include <random>

namespace virtualBartender
{
namespace
{
constexpr uint32_t levels[] = { 3000
                              , 5000
                              , 6000
                              };
constexpr uint32_t getDrunknessMaximum( const int level )
{
    return levels[ level ];
}
}

FuzzyBartender::FuzzyBartender( const uint8_t level )
    : drunknessMaximum_{ getDrunknessMaximum( level ) }
    , hoursForMl_{ 0 }
    , engine_{ "Virtual bartender" }
    , time_{ "Time" }
    , groupSize_{ "Group" }
    , drunkness_{ "Drunkness" }
    , beverage_{ "Beverage" }
    , rules_{ "Rules" }
{
    p_configureTime();
    p_configureGroupSize();
    p_configureDrunkness( level );

    p_configureBeverage();

    p_configureRules();

    p_configureEngine();
}

void FuzzyBartender::p_configureEngine()
{
    engine_.addInputVariable( &time_ );
    engine_.addInputVariable( &groupSize_ );
    engine_.addInputVariable( &drunkness_ );
    engine_.addOutputVariable( &beverage_ );

    engine_.addRuleBlock( &rules_ );


    engine_.configure( "Minimum", "Maximum", "AlgebraicProduct", "AlgebraicSum", "Centroid" );

    std::string status;
    if (!engine_.isReady(&status)) {
        throw fl::Exception("Engine is not ready. "
                            "The following errors were encountered:\n" + status, FL_AT);
    }
}

uint32_t FuzzyBartender::calculateBeverage()
{
    engine_.process();

    uint32_t result = beverage_.defuzzify();

    if (50 > result) {
        result = 0;
    } else {
        static constexpr double TimeForDrink = 0.5;

        hoursForMl_ = TimeForDrink / static_cast< const double >( result );
    }

    return result;
}

void FuzzyBartender::p_configureTime()
{
    //inputTime
    time_.setRange(0.000, 6.000);
    time_.addTerm( new fl::Sigmoid{ "LITTLEBIT", 0.500, -3.333 } );

    time_.addTerm( new fl::Gaussian{ "NOTMUCH", 1.500, 0.500 } );
    time_.addTerm( new fl::Bell{ "MEDIUM", 3.500, 1.000, 4.000 } );
    time_.addTerm( new fl::Sigmoid{ "ALOT", 4.000, 3.500 } );

}

void FuzzyBartender::p_configureGroupSize()
{
    groupSize_.setRange(0.000, 8.000);

    groupSize_.addTerm( new fl::Ramp{ "FEW", 4.000, 0.000 } );
    groupSize_.addTerm( new fl::Gaussian{ "GROUP", 4.000, 1.000 } );
    groupSize_.addTerm( new fl::Ramp{ "BUNCH", 4.000, 8.000 } );

}

void FuzzyBartender::p_configureDrunkness( const uint8_t level )
{
    drunkness_.setRange(0.000, 6000.000);
    switch( level ) {
    case 0:
        drunkness_.addTerm( new fl::Triangle{ "SOBER", 0.000, 500.000, 1000.000 } );
        drunkness_.addTerm( new fl::Triangle{ "TIPSY", 500.000, 1750.000, 3000.000 } );
        drunkness_.addTerm( new fl::Sigmoid{ "DRUNK", 3000.000, 0.002 } );
        break;
    case 1:
        drunkness_.addTerm( new fl::Trapezoid{ "SOBER", 0.0, 900.0, 1700.0, 2000.0 } );
        drunkness_.addTerm( new fl::Gaussian{ "TIPSY", 2400.0, 420.0 } );
        drunkness_.addTerm( new fl::Sigmoid{ "DRUNK", 2500.0, 0.001 } );
        break;
    case 2:
    default:
        drunkness_.addTerm( new fl::Trapezoid{ "SOBER", 0.0, 900.0, 1700.0, 2960.0 } );
        drunkness_.addTerm( new fl::Gaussian{ "TIPSY", 3120.0, 1020.0 } );
        drunkness_.addTerm( new fl::Sigmoid{ "DRUNK", 5020.0, 0.009 } );
        break;
    }

}

void FuzzyBartender::p_configureBeverage()
{
    beverage_.setRange(250.000, 1500.000);
    beverage_.setLockOutputRange(false);
    beverage_.setDefaultValue(0.000);
    beverage_.setLockValidOutput(false);
    beverage_.setDefuzzifier(new fl::Centroid( 9000 ));
    beverage_.output()->setAccumulation(new fl::Maximum);

    beverage_.addTerm( new fl::Sigmoid{ "SMALL", 330.000, -0.014 } );
    beverage_.addTerm( new fl::Gaussian{ "MEDIUM", 600.000, 100.000 } );
    beverage_.addTerm( new fl::Gaussian{ "BIG", 900.000, 150.000 } );
    beverage_.addTerm( new fl::Sigmoid{ "HUGE", 1100.000, 0.020 } );

}

void FuzzyBartender::p_configureRules()
{
    rules_.setTnorm(new fl::Minimum);
    rules_.setSnorm(new fl::Maximum);
    rules_.setActivation(new fl::Minimum);
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is SOBER and Time is ALOT then Beverage is BIG", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is SOBER and Time is MEDIUM and Group is FEW then Beverage is BIG", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is SOBER and Time is MEDIUM and Group is GROUP then Beverage is HUGE", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is SOBER and Time is MEDIUM and Group is BUNCH then Beverage is HUGE", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is SOBER and Time is NOTMUCH and Group is FEW then Beverage is MEDIUM", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is SOBER and Time is NOTMUCH and Group is GROUP then Beverage is MEDIUM", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is SOBER and Time is NOTMUCH and Group is BUNCH then Beverage is BIG", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is SOBER and Time is LITTLEBIT and Group is FEW then Beverage is MEDIUM", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is SOBER and Time is LITTLEBIT and Group is GROUP then Beverage is BIG", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is SOBER and Time is LITTLEBIT and Group is BUNCH then Beverage is BIG", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is TIPSY and Time is LITTLEBIT then Beverage is MEDIUM", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is TIPSY and Time is NOTMUCH and Group is FEW then Beverage is MEDIUM", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is TIPSY and Time is NOTMUCH and Group is GROUP then Beverage is BIG", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is TIPSY and Time is NOTMUCH and Group is BUNCH then Beverage is HUGE", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is TIPSY and Time is MEDIUM and Group is FEW then Beverage is MEDIUM", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is TIPSY and Time is MEDIUM and Group is GROUP then Beverage is BIG", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is TIPSY and Time is MEDIUM and Group is BUNCH then Beverage is BIG", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is TIPSY and Time is ALOT and Group is FEW then Beverage is SMALL", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is TIPSY and Time is ALOT and Group is GROUP then Beverage is MEDIUM", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is TIPSY and Time is ALOT and Group is BUNCH then Beverage is BIG", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is DRUNK and Time is LITTLEBIT then Beverage is SMALL", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is DRUNK and Time is NOTMUCH and Group is FEW then Beverage is SMALL", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is DRUNK and Time is NOTMUCH and Group is GROUP then Beverage is SMALL", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is DRUNK and Time is NOTMUCH and Group is BUNCH then Beverage is MEDIUM", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is DRUNK and Time is MEDIUM and Group is FEW then Beverage is SMALL", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is DRUNK and Time is MEDIUM and Group is GROUP then Beverage is MEDIUM", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is DRUNK and Time is MEDIUM and Group is BUNCH then Beverage is MEDIUM", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is DRUNK and Time is ALOT and Group is FEW then Beverage is SMALL", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is DRUNK and Time is ALOT and Group is GROUP then Beverage is BIG", &engine_));
    rules_.addRule(fl::FuzzyRule::parse("if Drunkness is DRUNK and Time is ALOT and Group is BUNCH then Beverage is BIG ", &engine_));
}

void FuzzyBartender::setHours( const double hours )
{
    time_.setInput( hours );
}

double FuzzyBartender::hours() const
{
    return time_.getInput();
}

void FuzzyBartender::setGroupSize( const uint32_t groupSize )
{
    groupSize_.setInput( groupSize );
}

uint32_t FuzzyBartender::groupSize() const
{
    return groupSize_.getInput();
}

void FuzzyBartender::setDrunkness( const uint32_t drunkness )
{
    drunkness_.setInput( drunkness );
}

uint32_t FuzzyBartender::drunkness() const
{
    return drunkness_.getInput();
}

uint32_t FuzzyBartender::drunknessMaximum() const
{
    return drunkness_.getMaximum();
}

void FuzzyBartender::sip( const uint32_t ml )
{
    setHours( hours() - hoursForMl_ * ml );
    setDrunkness( drunkness() + ml );
}
} // namespace virtualBartender
