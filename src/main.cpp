#include <QApplication>
#include <QIcon>
#include <QDebug>
#include <QFile>
#include <QFileInfo>
#include <QTextStream>

#include "mainwindow.h"

static QFile *g_logFile = nullptr;

static void messageHandler(QtMsgType type, const QMessageLogContext &ctx, const QString &msg)
{
    if (!g_logFile)
        return;
    const char *typeStr = "";
    switch (type) {
    case QtDebugMsg:    typeStr = "DEBUG"; break;
    case QtWarningMsg:  typeStr = "WARNING"; break;
    case QtCriticalMsg: typeStr = "CRITICAL"; break;
    case QtFatalMsg:    typeStr = "FATAL"; break;
    case QtInfoMsg:     typeStr = "INFO"; break;
    }
    QTextStream ts(g_logFile);
    ts << "[" << typeStr << "] " << msg << " (" << (ctx.file ? ctx.file : "") << ":" << ctx.line << ")\n";
    ts.flush();
}

int main(int argc, char *argv[])
{
    const QString logPath = QFileInfo(QString::fromLocal8Bit(argv[0])).absolutePath() + "/tft_debug.log";
    QFile logFile(logPath);
    logFile.open(QIODevice::WriteOnly | QIODevice::Truncate);
    g_logFile = &logFile;
    qInstallMessageHandler(messageHandler);
    QApplication app(argc, argv);
    QApplication::setApplicationName("TFT HTML Editor");
    QApplication::setOrganizationName("Local");
    QApplication::setWindowIcon(QIcon(":/icons/app.ico"));

    MainWindow window;
    window.show();

    return app.exec();
}
