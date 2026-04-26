#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
#if !defined(Q_OS_ANDROID)
    QGuiApplication::setDesktopFileName("com.madhav.ToGetMathTable");
    QGuiApplication::setWindowIcon(QIcon::fromTheme("accessories-calculator"));
#endif

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("ToGetMathTable", "Main");

    return QCoreApplication::exec();
}
