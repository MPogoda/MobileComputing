#pragma once

#include <memory>

#include <fl/Engine.h>
#include <fl/variable/InputVariable.h>
#include <fl/variable/OutputVariable.h>
#include <fl/rule/RuleBlock.h>

namespace virtualBartender
{
class FuzzyBartender
{
public:
    explicit FuzzyBartender( uint8_t level);

    double hours() const;
    uint32_t groupSize() const;
    uint32_t drunknessMaximum() const;
    uint32_t drunkness() const;

    uint32_t calculateBeverage( );

    void setHours( double hours );
    void setGroupSize( uint32_t groupSize );
    void setDrunkness( uint32_t drunkness );

    void sip( uint32_t ml );
private:
    double              hoursForMl_;
    fl::Engine          engine_;
    fl::InputVariable*  time_;
    fl::InputVariable*  groupSize_;
    fl::InputVariable*  drunkness_;
    fl::OutputVariable* beverage_;
    fl::RuleBlock*      rules_;


    void p_configureTime();
    void p_configureGroupSize();
    void p_configureDrunkness( uint8_t level );
    void p_configureBeverage();
    void p_configureRules();
    void p_configureEngine();
}; // class FuzzyBartender
} // namespace virtualBartender
