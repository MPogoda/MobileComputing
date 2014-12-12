TEMPLATE = app

QT += qml quick widgets

CONFIG += c++11

SOURCES += \
    fuzzylite/fuzzylite/src/defuzzifier/Bisector.cpp \
    fuzzylite/fuzzylite/src/defuzzifier/Centroid.cpp \
    fuzzylite/fuzzylite/src/defuzzifier/Defuzzifier.cpp \
    fuzzylite/fuzzylite/src/defuzzifier/LargestOfMaximum.cpp \
    fuzzylite/fuzzylite/src/defuzzifier/MaximumDefuzzifier.cpp \
    fuzzylite/fuzzylite/src/defuzzifier/MeanOfMaximum.cpp \
    fuzzylite/fuzzylite/src/defuzzifier/SmallestOfMaximum.cpp \
    fuzzylite/fuzzylite/src/defuzzifier/WeightedAverage.cpp \
    fuzzylite/fuzzylite/src/defuzzifier/WeightedSum.cpp \
    fuzzylite/fuzzylite/src/factory/DefuzzifierFactory.cpp \
    fuzzylite/fuzzylite/src/factory/Factory.cpp \
    fuzzylite/fuzzylite/src/factory/HedgeFactory.cpp \
    fuzzylite/fuzzylite/src/factory/SNormFactory.cpp \
    fuzzylite/fuzzylite/src/factory/TermFactory.cpp \
    fuzzylite/fuzzylite/src/factory/TNormFactory.cpp \
    fuzzylite/fuzzylite/src/hedge/Any.cpp \
    fuzzylite/fuzzylite/src/hedge/Extremely.cpp \
    fuzzylite/fuzzylite/src/hedge/Not.cpp \
    fuzzylite/fuzzylite/src/hedge/Seldom.cpp \
    fuzzylite/fuzzylite/src/hedge/Somewhat.cpp \
    fuzzylite/fuzzylite/src/hedge/Very.cpp \
    fuzzylite/fuzzylite/src/imex/CppExporter.cpp \
    fuzzylite/fuzzylite/src/imex/FclExporter.cpp \
    fuzzylite/fuzzylite/src/imex/FclImporter.cpp \
    fuzzylite/fuzzylite/src/imex/FisExporter.cpp \
    fuzzylite/fuzzylite/src/imex/FisImporter.cpp \
    fuzzylite/fuzzylite/src/norm/SNorm.cpp \
    fuzzylite/fuzzylite/src/norm/TNorm.cpp \
    fuzzylite/fuzzylite/src/rule/FuzzyAntecedent.cpp \
    fuzzylite/fuzzylite/src/rule/FuzzyConsequent.cpp \
    fuzzylite/fuzzylite/src/rule/FuzzyExpression.cpp \
    fuzzylite/fuzzylite/src/rule/FuzzyRule.cpp \
    fuzzylite/fuzzylite/src/rule/Rule.cpp \
    fuzzylite/fuzzylite/src/rule/RuleBlock.cpp \
    fuzzylite/fuzzylite/src/term/Accumulated.cpp \
    fuzzylite/fuzzylite/src/term/Bell.cpp \
    fuzzylite/fuzzylite/src/term/Constant.cpp \
    fuzzylite/fuzzylite/src/term/Discrete.cpp \
    fuzzylite/fuzzylite/src/term/Function.cpp \
    fuzzylite/fuzzylite/src/term/Gaussian.cpp \
    fuzzylite/fuzzylite/src/term/GaussianProduct.cpp \
    fuzzylite/fuzzylite/src/term/Linear.cpp \
    fuzzylite/fuzzylite/src/term/PiShape.cpp \
    fuzzylite/fuzzylite/src/term/Ramp.cpp \
    fuzzylite/fuzzylite/src/term/Rectangle.cpp \
    fuzzylite/fuzzylite/src/term/Sigmoid.cpp \
    fuzzylite/fuzzylite/src/term/SigmoidDifference.cpp \
    fuzzylite/fuzzylite/src/term/SigmoidProduct.cpp \
    fuzzylite/fuzzylite/src/term/SShape.cpp \
    fuzzylite/fuzzylite/src/term/Thresholded.cpp \
    fuzzylite/fuzzylite/src/term/Trapezoid.cpp \
    fuzzylite/fuzzylite/src/term/Triangle.cpp \
    fuzzylite/fuzzylite/src/term/ZShape.cpp \
    fuzzylite/fuzzylite/src/variable/InputVariable.cpp \
    fuzzylite/fuzzylite/src/variable/OutputVariable.cpp \
    fuzzylite/fuzzylite/src/variable/Variable.cpp \
    fuzzylite/fuzzylite/src/Engine.cpp \
    fuzzylite/fuzzylite/src/Exception.cpp \
    fuzzylite/fuzzylite/src/fuzzylite.cpp \
    fuzzylite/fuzzylite/src/Operation.cpp \
    main.cxx \
    mainwindow.cxx \
    parametersdialog.cxx

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    fuzzylite/fuzzylite/fl/defuzzifier/Bisector.h \
    fuzzylite/fuzzylite/fl/defuzzifier/Centroid.h \
    fuzzylite/fuzzylite/fl/defuzzifier/Defuzzifier.h \
    fuzzylite/fuzzylite/fl/defuzzifier/LargestOfMaximum.h \
    fuzzylite/fuzzylite/fl/defuzzifier/MaximumDefuzzifier.h \
    fuzzylite/fuzzylite/fl/defuzzifier/MeanOfMaximum.h \
    fuzzylite/fuzzylite/fl/defuzzifier/SmallestOfMaximum.h \
    fuzzylite/fuzzylite/fl/defuzzifier/WeightedAverage.h \
    fuzzylite/fuzzylite/fl/defuzzifier/WeightedSum.h \
    fuzzylite/fuzzylite/fl/factory/DefuzzifierFactory.h \
    fuzzylite/fuzzylite/fl/factory/Factory.h \
    fuzzylite/fuzzylite/fl/factory/HedgeFactory.h \
    fuzzylite/fuzzylite/fl/factory/SNormFactory.h \
    fuzzylite/fuzzylite/fl/factory/TermFactory.h \
    fuzzylite/fuzzylite/fl/factory/TNormFactory.h \
    fuzzylite/fuzzylite/fl/hedge/Any.h \
    fuzzylite/fuzzylite/fl/hedge/Extremely.h \
    fuzzylite/fuzzylite/fl/hedge/Hedge.h \
    fuzzylite/fuzzylite/fl/hedge/Not.h \
    fuzzylite/fuzzylite/fl/hedge/Seldom.h \
    fuzzylite/fuzzylite/fl/hedge/Somewhat.h \
    fuzzylite/fuzzylite/fl/hedge/Very.h \
    fuzzylite/fuzzylite/fl/imex/CppExporter.h \
    fuzzylite/fuzzylite/fl/imex/Exporter.h \
    fuzzylite/fuzzylite/fl/imex/FclExporter.h \
    fuzzylite/fuzzylite/fl/imex/FclImporter.h \
    fuzzylite/fuzzylite/fl/imex/FisExporter.h \
    fuzzylite/fuzzylite/fl/imex/FisImporter.h \
    fuzzylite/fuzzylite/fl/imex/Importer.h \
    fuzzylite/fuzzylite/fl/norm/Norm.h \
    fuzzylite/fuzzylite/fl/norm/SNorm.h \
    fuzzylite/fuzzylite/fl/norm/TNorm.h \
    fuzzylite/fuzzylite/fl/rule/Antecedent.h \
    fuzzylite/fuzzylite/fl/rule/Consequent.h \
    fuzzylite/fuzzylite/fl/rule/FuzzyAntecedent.h \
    fuzzylite/fuzzylite/fl/rule/FuzzyConsequent.h \
    fuzzylite/fuzzylite/fl/rule/FuzzyExpression.h \
    fuzzylite/fuzzylite/fl/rule/FuzzyRule.h \
    fuzzylite/fuzzylite/fl/rule/Rule.h \
    fuzzylite/fuzzylite/fl/rule/RuleBlock.h \
    fuzzylite/fuzzylite/fl/term/Accumulated.h \
    fuzzylite/fuzzylite/fl/term/Bell.h \
    fuzzylite/fuzzylite/fl/term/Constant.h \
    fuzzylite/fuzzylite/fl/term/Discrete.h \
    fuzzylite/fuzzylite/fl/term/Function.h \
    fuzzylite/fuzzylite/fl/term/Gaussian.h \
    fuzzylite/fuzzylite/fl/term/GaussianProduct.h \
    fuzzylite/fuzzylite/fl/term/Linear.h \
    fuzzylite/fuzzylite/fl/term/PiShape.h \
    fuzzylite/fuzzylite/fl/term/Ramp.h \
    fuzzylite/fuzzylite/fl/term/Rectangle.h \
    fuzzylite/fuzzylite/fl/term/Sigmoid.h \
    fuzzylite/fuzzylite/fl/term/SigmoidDifference.h \
    fuzzylite/fuzzylite/fl/term/SigmoidProduct.h \
    fuzzylite/fuzzylite/fl/term/SShape.h \
    fuzzylite/fuzzylite/fl/term/Term.h \
    fuzzylite/fuzzylite/fl/term/Thresholded.h \
    fuzzylite/fuzzylite/fl/term/Trapezoid.h \
    fuzzylite/fuzzylite/fl/term/Triangle.h \
    fuzzylite/fuzzylite/fl/term/ZShape.h \
    fuzzylite/fuzzylite/fl/variable/InputVariable.h \
    fuzzylite/fuzzylite/fl/variable/OutputVariable.h \
    fuzzylite/fuzzylite/fl/variable/Variable.h \
    fuzzylite/fuzzylite/fl/Engine.h \
    fuzzylite/fuzzylite/fl/Exception.h \
    fuzzylite/fuzzylite/fl/fuzzylite.h \
    fuzzylite/fuzzylite/fl/Headers.h \
    fuzzylite/fuzzylite/fl/Operation.h \
    mainwindow.h \
    parametersdialog.h
