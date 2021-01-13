import json
import urllib.request


def get_categories():
    connection = urllib.request.urlopen('https://www.sheypoor.com/api/v5.7.0/general/categories')
    response = json.loads(connection.read().decode("utf-8"))
    categories = []
    result = {}
    for i in range(len(response)):
        # print(response[i]["categoryTitle"] + ":")
        categories.append(response[i]["categoryTitle"])
        subcategories = []
        for j in range(len(response[i]["children"])):
            # print(response[i]["children"][j]["categoryTitle"])
            subcategories.append(response[i]["children"][j]["categoryTitle"])
        # result.append({categories[i]: subcategories})
        result[categories[i]] = subcategories
    print(result)


if __name__ == '__main__':
    get_categories()
