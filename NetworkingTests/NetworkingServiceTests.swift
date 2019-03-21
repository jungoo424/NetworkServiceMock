//
//  NetworkingServiceTests.swift
//  NetworkingTests
//
//  Created by Jason Kim on 3/20/19.
//  Copyright © 2019 jklabs. All rights reserved.
//

import XCTest
@testable import Networking

class NetworkingServiceTests: XCTestCase {

    class MockNetworkingService: NetworkingService {
        let result = (
            date:"2019-03-20",
            explanation:"Welcome to an equinox on planet Earth. Today is the first day of spring in our fair planet's northern hemisphere, fall in the southern hemisphere, with day and night nearly equal around the globe. At an equinox Earth's terminator, the dividing line between day and night, connects the planet's north and south poles as seen at the start of this remarkable time-lapse video compressing an entire year into twelve seconds. To make it, the Meteosat satellite recorded these infrared images every day at the same local time from a geosynchronous orbit. The video actually starts at the September 2010 equinox with the terminator aligned vertically. As the Earth revolves around the Sun, the terminator tilts to provide less daily sunlight to the northern hemisphere, reaching the solstice and northern hemisphere winter at the maximum tilt. As the year continues, the terminator tilts back again and March 2011 equinox arrives halfway through the video. Then the terminator swings past vertical the other way, reaching the the June 2011 solstice and the beginning of northern summer. The video ends as the September equinox returns.",
            media_type:"video",
            service_version:"v1",
            title:"Equinox on Planet Earth",
            url:"https://www.youtube.com/embed/LUW51lvIFjg?rel=0&showinfo=0")
    
        override func requestData(completion: @escaping (Result<APOD?, Error>) -> ()) {
            let apod = APOD(date: result.date, explanation: result.explanation, mediaType: result.media_type, serviceVersion: result.service_version, title: result.title, url: result.url)
            completion(Result(value: apod))
        }
    }
    
    func testNetworkingService_Success() {
        
        let mockNetworkingService = MockNetworkingService()
        let expectation = XCTestExpectation(description: "network request data")
        
        mockNetworkingService.requestData { (result) in
            switch result {
            case .success(let apod):
                XCTAssertNotNil(apod)
                expectation.fulfill()
            case .failure(_): break
            }
        }
        
        wait(for: [expectation], timeout: 2.0)
    }

}
