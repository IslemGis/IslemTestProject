pragma Singleton
import QtQuick 2.3

QtObject {
    property var yapiEnums: yapiEnums
    property var digerYapiEnums: digerYapiEnums
    Item{
        id:yapiEnums
        property var tip: 1
        property var tip2: 1
    }

    Item{
        id:digerYapiEnums
        property var tip: 1
        property var tip2: 1
    }
}
