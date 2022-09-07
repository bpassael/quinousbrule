export function timeConvert(n) {
  var num = n;
  if (num < 10) {
    return Math.round(num) + " minutes"
  }
  var hours = (num / 60);
  var rhours = Math.floor(hours);
  var minutes = (hours - rhours) * 60;
  var rminutes = Math.ceil(minutes);
  if (rhours === 0 && rminutes === 1) {
    return rminutes + " minute";
  } else if (rhours === 0) {
    return rminutes + " minutes";
  } else if (rhours === 1 && rminutes === 0) {
    return rhours + " heure";
  } else if (rminutes === 0) {
      return rhours + " heures";
  } else if (rhours === 1 && rminutes === 1) {
    return rhours + " heure et " + rminutes + " minute";
  } else if (rhours === 1) {
    return rhours + " heure et " + rminutes + " minutes";
  } else  if (rminutes === 1) {
    return rhours + " heures et " + rminutes + " minute";
  } else {
    return rhours + " heures et " + rminutes + " minutes";
  }
}


export function formatInput(input) {
  const returnValue = input.toLowerCase()
      .replace(/[àâä]/g, 'a')
      .replace(/[æ]/g, 'ae')
      .replace(/[ç]/g, 'c')
      .replace(/[éèêë]/g, 'e')
      .replace(/[îï]/g, 'i')
      .replace(/[ô]/g, 'o')
      .replace(/[œ]/g, 'oe')
      .replace(/[ùûü]/g, 'u')
      .replace(/\W/g, ' ')
      .replace(/ +/g, '+')
  return returnValue;
  }


  export function isValidAddressInput(input) {
    const returnValue = input.toLowerCase()
        .replace(/\W/g, '')
        .replace(/ /g, '')
    return returnValue;
    }


export function get_code3_dep(x){
    let strx = x.toString();
    if (strx.length===3)
        return x;
    else
        return "0" + x;
}


export function inside(point, vs) {

  var x = point[0], y = point[1];

  var inside = false;
  for (var i = 0, j = vs.length - 1; i < vs.length; j = i++) {
      var xi = vs[i][0], yi = vs[i][1];
      var xj = vs[j][0], yj = vs[j][1];

      var intersect = ((yi > y) != (yj > y))
          && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
      if (intersect) inside = !inside;
  }

  return inside;
};
