#include "bartender_interface.h"
#include "fuzzy_bartender.h"

#include <QDebug>

namespace virtualBartender
{
BartenderInterface::BartenderInterface(QObject *parent)
    : QObject{ parent }
    , impl_{ new FuzzyBartender{ 1 } }
{

}

BartenderInterface::~BartenderInterface()
{

}

void BartenderInterface::setHours( const qreal hours )
{
    qDebug() << "Asked to update hours to " << hours;
    if (impl_) {
        impl_->setHours( hours );
    }
}

qreal BartenderInterface::hours() const
{
    qDebug() << "asked for hours...";
    if (impl_) {
        return impl_->hours();
    } else {
        return 1.0;
    }
}

void BartenderInterface::setProfile( const quint8 level )
{
    qDebug() << "Asked to update profile to " << (int)level;
    const qreal hours = this->hours();

    impl_.reset( new FuzzyBartender( level ) );
    setHours( hours );
}

quint32 BartenderInterface::maximumDrunkness() const
{
    qDebug() << "Asked for maximum drunkness.";
    if (impl_) {
        return impl_->drunknessMaximum();
    } else {
        return 0;
    }
}

quint32 BartenderInterface::order()
{
    qDebug() << "Ordered...";
    if (impl_) {
        return impl_->calculateBeverage();
    } else {
        return 0;
    }
}

void BartenderInterface::sip( const quint32 volume )
{
    qDebug() << "Sipping...";
    if (impl_) {
        impl_->sip( volume );
    }
}

void BartenderInterface::setGroupSize( const quint32 groupSize)
{
    qDebug() << "Asked to set groupSize to " << (int)groupSize;
    if (impl_) {
        impl_->setGroupSize( groupSize );
    }
}
} // namespace virtualBartender

