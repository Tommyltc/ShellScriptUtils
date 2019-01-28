var isInt = (value) => {
  if (isNaN(value)) {
    return false;
  }
  var x = parseFloat(value);
  return (x | 0) === x;
}
var isBoolean = (value) => {
	if(typeof value == "boolean" || value.toUpperCase() == "YES" || value.toUpperCase() == "NO" || value.toUpperCase() == "TRUE" || value.toUpperCase() == "FALSE")
		return true;
	return false;
}

//Identify key valueType pair
var parseXmlElement = (ele) => {
    var objectCollections = {};
    var parseXmlElementRecursive = (root) => {
        if(root.childElementCount>0){
            var result = [];
            var p = 0;
            for(var i=0;i<root.childElementCount;i++){
    //             console.log(root.children[i]);
    //          if(level < 3)
                result.push(parseXmlElementRecursive(root.children[i]));
            }
            if(objectCollections.hasOwnProperty(root.nodeName)){
                objectCollections[root.nodeName].push(result);
            }else{
                objectCollections[root.nodeName] = [result];
            }
            var typeName = "";
            if(root.childElementCount==1){
                typeName = result[0].nodeName;
            }else{
                typeName = root.nodeName;
            }
            var customerObjectType = typeName.substr(0,1).toUpperCase()+typeName.substring(1);
            return {nodeName:root.nodeName,valueType:"Array<"+customerObjectType+">",child:result};
        }else{
            var type = "";
            if(isInt(root.innerHTML)){
                type = typeof 9999;
            }else if(isBoolean(root.innerHTML)){
                type = typeof true;
            }else{
                type = typeof root.innerHTML;
            }
            return {nodeName:root.nodeName,valueType:type};
        }
    }
    parseXmlElementRecursive(ele);

    //Transform and flatten structures
    var finalStructure = {};
    var structureSum = (key,obj) => {
        var objectStructSum = {};
        for(var i=0;i<obj.length;i++){
            //check properties
            for(var j=0;j<obj[i].length;j++){
                if(obj[i].length==1){
                    objectStructSum = obj[i][j].valueType;
                }else if(objectStructSum.hasOwnProperty(obj[i][j].nodeName)){
                    if(objectStructSum[obj[i][j].nodeName] !== obj[i][j].valueType){
                        if(objectStructSum[obj[i][j].nodeName] === "string"){
                            objectStructSum[obj[i][j].nodeName] = obj[i][j].valueType;
                        }
                    }
                }else{
                    objectStructSum[obj[i][j].nodeName] = obj[i][j].valueType;
                }
            }
        }

        finalStructure[key] = objectStructSum;
    }
    console.log(objectCollections);
    for(var key in objectCollections)
        structureSum(key,objectCollections[key]);

    return finalStructure;
}

var parseJsonElement = (ele) => {

}

//Output the structure to Js format
var getOutPutJsStructure = (struc) => {
	var output = "";
	for(var key in struc){
        if(typeof struc[key] === "string"){
            continue;
        }
		var form = "export class "+key.substr(0,1).toUpperCase()+key.substring(1)+" {\n";
		for(var subClazzKey in struc[key]){
			form += "\t"+subClazzKey+": "+struc[key][subClazzKey]+";\n";
	    }
		form += "}\n";
		output += form;
	}
	return output;
}

var ele = document.getElementsByTagName("vas")[0];
getOutPutJsStructure(parseXmlElement(ele,0));


var isInt = (value) => {
  if (isNaN(value)) {
    return false;
  }
  var x = parseFloat(value);
  return (x | 0) === x;
}
var isBoolean = (value) => {
    if(typeof value == "boolean" || value.toUpperCase() == "YES" || value.toUpperCase() == "NO" || value.toUpperCase() == "TRUE" || value.toUpperCase() == "FALSE")
        return true;
    return false;
}
var parseJsonElement = (n,e) => {
    var result = "";
    var getFunctionsJsRecursive = (name,val) =>{
        var classname = name.substr(0,1).toUpperCase()+name.substring(1);
        var classStructure = "export class "+classname+" {\n"; 
        for(var key in val){
            var dataType="";
            if(val[key] instanceof Array){
                dataType = "Array<"+getFunctionsJsRecursive(key,val[key][0])+">";
            }else if(val[key] instanceof Object){
                dataType = getFunctionsJsRecursive(key,val[key]);
            }else if(val[key]){
                dataType = typeof val[key];
            }else{
                dataType = "any";
            }
            classStructure += "  "+key+": "+dataType+";\n"
        }
        classStructure +="}";
        result += classStructure+"\n";
        return classname;
    }
    getFunctionsJsRecursive(n,e);
    return result;
}

