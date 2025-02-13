/*
    main.cpp

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/
#include <QGuiApplication>
#include <QQuickView>
#include <QQmlEngine>
#include <QQmlContext>
#include <QCommandLineParser>
#include <QCommandLineOption>
#include <QStandardPaths>
#include <QDir>
#include <QDirIterator>
#include <QResource>

int main(int ac, char **av)
{

    // Set OpenGL requirements
    QSurfaceFormat format = QSurfaceFormat::defaultFormat();
    format.setRenderableType(QSurfaceFormat::OpenGLES);
    format.setVersion(2, 0);
    // Don't do MSAA for now...
    //format.setSamples(4);
    format.setProfile(QSurfaceFormat::CompatibilityProfile);

    QSurfaceFormat::setDefaultFormat(format);

    format = QSurfaceFormat::defaultFormat();

    QGuiApplication::setAttribute(Qt::AA_UseOpenGLES);
    QGuiApplication app(ac, av);

    QDir resourceDir(app.applicationDirPath() + QStringLiteral("/resources"));
    QDirIterator it(resourceDir, QDirIterator::IteratorFlag::NoIteratorFlags);
    while (it.hasNext()) {
        QString path = it.next();
        if (!QResource::registerResource(path))
            qWarning() << "Failed to load binary resources: " << path;
        else
            qDebug() << "Loaded binary resources: " << path;
    }
    QQuickView view;

    const QString assetsPrefix = QString("file://" + QGuiApplication::applicationDirPath() + "/data/");
    // If we want to pack everything in one file (slow)
    //const QString assetsPrefix = QString("qrc:/");


    view.engine()->rootContext()->setContextProperty(QStringLiteral("_assetsPrefix"), assetsPrefix);

    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.setSource(QUrl(QStringLiteral("qrc:/main.qml")));
    view.resize(1920, 1080);

    view.show();


    return app.exec();
}
