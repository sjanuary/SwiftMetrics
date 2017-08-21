// swift-tools-version:4.0
/**
* Copyright IBM Corporation 2017
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
**/

import PackageDescription

let package = Package(
  name: "SwiftMetrics",
  products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SwiftMetrics",
            targets: ["SwiftMetrics",
                "SwiftMetricsKitura",
                "SwiftBAMDC",
                "SwiftMetricsBluemix",
                "SwiftMetricsDash"]),

        .executable(name: "SwiftMetricsCommonSample", targets: ["SwiftMetricsCommonSample"]),
    ],
  dependencies: [
    .package(url: "../omr-agentcore", from: "3.0.0"),
    .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "1.7.0"),
    .package(url: "https://github.com/IBM-Swift/Kitura-WebSocket.git", from: "0.8.0"),
    .package(url: "https://github.com/IBM-Swift/Kitura-Request.git", from: "0.8.0"),
    .package(url: "https://github.com/IBM-Swift/CloudConfiguration.git", from: "2.0.0")
  ],
  targets: [
      .target(name: "SwiftMetrics", dependencies: ["agentcore", "hcapiplugin", "envplugin", "cpuplugin", "memplugin", "CloudConfiguration"]),
      .target(name: "SwiftMetricsKitura", dependencies: ["SwiftMetrics", "Kitura"]),
      .target(name: "SwiftBAMDC", dependencies: ["SwiftMetricsKitura", "KituraRequest", "Kitura-WebSocket"]),
      .target(name: "SwiftMetricsBluemix", dependencies: ["SwiftMetricsKitura","SwiftBAMDC"]),
      .target(name: "SwiftMetricsDash", dependencies: ["SwiftMetricsBluemix"]),
      .target(name: "SwiftMetricsCommonSample", dependencies: ["SwiftMetrics"],
            path: "commonSample/Sources"),
      .testTarget(name: "SwiftMetricsTests", dependencies: ["SwiftMetrics"])
   ]
)
