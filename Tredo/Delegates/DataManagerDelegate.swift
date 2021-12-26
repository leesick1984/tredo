protocol DataManagerDelegate {
    func didParsedData<T : Decodable>(_ apiData : T)
    func didFailWithError(error: Error)
}
