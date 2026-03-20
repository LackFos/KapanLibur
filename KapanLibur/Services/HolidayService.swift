//
//  HolidayService.swift
//  KapanLibur
//
//  Created by Elvis on 19/03/26.
//

class HolidayService {
    func getNextHoliday() async throws -> Holiday {
        let client = ApiClient()        
        let response: ApiResponse<Holiday> = try await client.get(path: "/v1/holidays/next?lang=id")
        guard response.success else {
            throw URLError(.badServerResponse)
        }
        return response.data
    }
}
