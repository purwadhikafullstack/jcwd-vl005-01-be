import axios from 'axios'

const ADMIN_KEY = 'adminToken'
const BASE_URL = 'http://localhost:5000'

export class API {
  get(url) {
    const token = getToken()
    return axios.get(`${BASE_URL}${url}`, {
      headers: {
        'Authorization': token,
      }
    })
  }

  post(url, data) {
    const token = getToken()
    return axios.get(`${BASE_URL}${url}`, data, {
      headers: {
        'Authorization': token,
      }
    })
  }
}

const getToken = () => {
  return localStorage.getItem(ADMIN_KEY)
}
const setToken = (token) => {
  localStorage.setItem(ADMIN_KEY, token)
}

export default new API();
