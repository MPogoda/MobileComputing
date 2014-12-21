#pragma once

#include <QObject>
#include <QScopedPointer>

namespace virtualBartender
{
class FuzzyBartender;

class BartenderInterface : public QObject
{
    Q_OBJECT
public:
    explicit BartenderInterface( QObject *parent = nullptr );
    ~BartenderInterface();

    Q_INVOKABLE void setHours( qreal hours );
    Q_INVOKABLE qreal hours( ) const;
    Q_INVOKABLE void setProfile( quint8 profile );
    Q_INVOKABLE quint32 maximumDrunkness() const;
    Q_INVOKABLE quint32 order();
    Q_INVOKABLE void sip( quint32 volume );
    Q_INVOKABLE void setGroupSize( quint32 groupSize );
private:
    QScopedPointer< FuzzyBartender > impl_;
}; // class BartenderInterface
} // namespace virtualBartender
