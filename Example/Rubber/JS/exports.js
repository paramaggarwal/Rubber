function clickHandler(path) {
  console.log('Tapped path: ' + path);

  var node = nodeAtPath(renderedTree, path.split('.'));
  node.props.onClick();

  generatePatch();
}

function panHandler(path, translation) {
  console.log('Panned path: ' + path);

  var node = nodeAtPath(renderedTree, path.split('.'));
  node.props.onDrag(translation.x, translation.y);

  generatePatch();
}

global.clickHandler = clickHandler;
global.panHandler = panHandler;