  import { ascending } from "d3-array";
  /**
   * Crop data at a certain value
   * @param {{string: any}[]} data - the data to crop
   * @param {String} key - the key to crop on
   * @param {Number} val - the value to crop at
   * @returns {{string: any}[]} - the cropped data
   */
  export function cropData(data, key, val) {
    // sort data by key
    //@ts-ignore
    const sortedData = data.slice().sort((a, b) => ascending(+a[key], +b[key]));
    for(let i = 0; i < sortedData.length; i++) {
      if(sortedData[i][key] > val && i < sortedData.length - 1) {
        // get next value and keep it value
        // note this will work for this concept but is brittle. make it better later?
        if (val == sortedData[i-1][key]) {
          return sortedData.slice(0, i)
        }
        let next = Object.assign({}, sortedData[i], { [key]: val });
        return sortedData.slice(0, i).concat([next]);
      }
    }
    return sortedData;
  }

