Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeCHT66 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:58:58 -0500
Received: from mail-eopbgr10112.outbound.protection.outlook.com ([40.107.1.112]:11232
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932173AbeCHT6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:58:52 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: trivial: add various mcp4017/18/19 potentiometers
Date: Thu,  8 Mar 2018 20:58:29 +0100
Message-Id: <20180308195830.16348-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180308195830.16348-1-peda@axentia.se>
References: <20180308195830.16348-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0902CA0006.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::16) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26481a70-9a44-47ed-fec0-08d5852f02e2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:gC7jXrCo5zC/0M4hHkladFvzvHpCBzblEjVIxTXaVC7xadgt2K7zSxkQzwK8Pq62KzOMKjSeg0cNqvR/daEi77QCjY8wEX//7GedyJaX0VSsbHNRE5xr967hnmarBfaZCfvZeZZ/fhQqjyIeiJa21f0gFQ/jOYxQyGx3pZYMSKDLqzQgkxeCNRQujlenOexpvMhU9JVTNFRSHkb63gi24h5icCfuy+DG9OI4kfZLyfDkBHcurtPZab2+CzEUB/Ab;25:ta1f4Ypz7nxUkwsSrU6JVAn2wbPKL9Q1FJg9brQSNrCTro5DIUfP63CRSiNqnrCIO6ow0KS49Q00uoRrrm+DCvuLjCQgfQvBvagbMBW5k9SbKsN9YdZxBS+mgWxNqJ/9VdX8AIuZW1ou3obBuIX7rwcJSiiOtPDE9brSG5BTCYO4fsIiNO7k2yYJ64oD3bxkLwQi32aVp2hq/shruT6rbUTRQWuAeVxIobjD6/Y14E7MjD/CK1OFUzccHQh2oS5a8gIRUpuJypHDHXBngzVo250Ys6LFFJE4Co40RpxvqYh/0agStmZAJcNxGdN6FV+QsaRr4CqXtfNRNaeJ6kLV9A==;31:kmYfJz8qHF48jDEdPy8fRl9jTBXuL4Oj8+ttVEGNZeRsqx5k+vm/inZGD282PYA7BpNGpq3nLeprfgv3rxj4hBt/ujuwiLMrp+xjM/K7ZI2vW/kR1/uOFHOrbUkLy682hZReF1DWQYu8JmOidrRDeM9+Ooxg0Z53Y3vFwtHcRxAtjIQ2IaBY2Ttr9/auh86GrTSeLFN2EDjojuEfcMhfA03LgxqKpg2r6sVVmSvZCjQ=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27722AD830069F159CBA8607BCDF0@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6041288)(2016111802025)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:D2VcJtp+7AHOEHZpLTettPQDgd2g4FI2fD1yloy5SOv0lRbPc6S/SnJfi1dM0slcleDzUm1eZe6GzHz36fV1TD73ni73hhzfVIBeUAznMOw/RPq9PuVF5yIRo5VSlolX0wQ1+IB9kq63tmjnaKnM/qnO3M6FwcGPCMPkdB6tjmtu/InyNQ9CYNACt+8jFM0+lPtJ/lAyw849uilBv5ki3Fa+QVWxyDl+XYTm/Tmp28PyZdx0GgBx7nYuBSswFr+AYCxlRbdXqXwUZBcGeNJhqg==
X-Forefront-PRVS: 060503E79B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(39830400003)(376002)(39380400002)(199004)(189003)(66066001)(26005)(47776003)(81166006)(2361001)(81156014)(305945005)(2950100002)(6486002)(7736002)(6666003)(8676002)(186003)(23676004)(6916009)(16526019)(316002)(106356001)(8936002)(50226002)(74482002)(68736007)(36756003)(2351001)(6506007)(97736004)(386003)(5660300001)(52116002)(105586002)(2870700001)(4326008)(3846002)(76176011)(2906002)(54906003)(6512007)(86362001)(478600001)(8666007)(50466002)(25786009)(53936002)(1076002)(6116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzI7MjM6NXRtWEwreDk5TDVCUHVOa0ZDWUwvTFRQ?=
 =?utf-8?B?NGdkZExJcHFHN1AxQUtYUnV6UXpZZlNNbkZDc3FoRjVSSEE4c1VWN0V0N3NB?=
 =?utf-8?B?cFFNUUZjK2ZIbUN5NVd5cTdOTUlabXlsWWpTTTNWY1hqaFc0QVlOQVJrc01s?=
 =?utf-8?B?WTlZNmlQWVZMSzcrTWpKbEVMd1dmN25KRTN4RDR1QWlJMWtteTRmbUkxamw3?=
 =?utf-8?B?dDR3Q21qajlpMWovU01FVkpUQS90UitTTWdqTy9CeCsrTCt2MlhSZDJTTW92?=
 =?utf-8?B?UVpmbS9lZ1JEdERMLytCSjNkYUJHUmtsb1JRRTk1aEZweGx3UnB5Q2NwNWl0?=
 =?utf-8?B?bkd2endBT1BZYmZtbVBiNGN5aVVQS1phaDRTSUkyazQ4UjBnMm55TTYxUVY3?=
 =?utf-8?B?akhaekJTdFhvbUxyUWRXWmZIRVlCNlN0QWdEVkNlMU1USklwNDhqeER2Rnhr?=
 =?utf-8?B?MGFlcDNzbWJLSk5HVng3ZnRPNnlHZDlRY1JvN1doYTI1amZ1RnNnVHRoTldL?=
 =?utf-8?B?eDJUcWUrVW0xdXI5eldSNEQ3RHNyOVF1OUVNVmt2eWZ3cXNHZHNJSmMyYXJR?=
 =?utf-8?B?Z2tFUUNabUNQd1lLMzV4TDB6MmxVTEpGK2tWSGJvQlJoR05SYTIxN2wzVTFC?=
 =?utf-8?B?VUxzOGFpbllqdnozdEEycE9yZDRaSko0c0ZPMmNRRm1tMy90cEpDWTd2NzJP?=
 =?utf-8?B?cStxRGFGUzhrb3hlSzV3TlpDSjFmTHErWDVrMFBxVW1jTzg2OHY1ZDgyeXNE?=
 =?utf-8?B?WTF4UUR3bGlmN0pSZDEvNEl1U3diZVVTdHZYV28ycHV0bzVuMVFiem8zZkpT?=
 =?utf-8?B?NDVzeHkyUk03d3VBVXplVWdTNG1FVmUrRTFxangwd3Bzc3k1cFZob212bDVq?=
 =?utf-8?B?M3ZmRlMzeGFGMWY0UjFpSHdicDBneXQzOTRXdnNpSU5RS3JrYUpIeUNYbDdm?=
 =?utf-8?B?S3ZCZWd1cnpGaHl0ZGViMlR4Q2NUSjFFTkdMenMvRGJzcXRDMU4vVHdaL0Zl?=
 =?utf-8?B?blF6TjlYWmRlR0VOYzk1YnBUbzA4aWNqc3hhMkk2UFFTTzBES0RyN0l5Zzd3?=
 =?utf-8?B?WkFCR0ZydXdIMmFuWlNYelZJMXJXeExDa1JSNzhmVnFGcEhsL0RlbVdmb2Jq?=
 =?utf-8?B?MTZjYkUzZVFCK0N6QjdBMjZzNGNORFR4WnhOUUcrS3VMeVh1VFFoOWdmMXM5?=
 =?utf-8?B?ZEVNZmFJbVhCZ3NPcmVYQXhtZ0FjYmJ2NFJkZ1FZS1k3MFlDNlYwcFhLUEhK?=
 =?utf-8?B?R2huK2lMS29pZ0hyQzhUai9BU2pPZDRpOXhUZFh1dFZxeTlrSGN1T2EzQmRR?=
 =?utf-8?B?ZnFpbmRFM0MxTWdQc3Z6M0NMalgrdzlkNldHRTJycTJiY0tiRzEzVjBVODhT?=
 =?utf-8?B?TjhnblFtazJ3WmNYYUFYNGVQS2Z4eUsyVVdPOTZKNlRUMk9qMlQ2UXM4cC9R?=
 =?utf-8?B?TGI3SmdaWXd5eU9WSmgweXJxTGh2WVlhTFdFVkJHc01lcU81MjZGaThBMTBx?=
 =?utf-8?B?dnhUcm9zRHVzSjJnZU9sUnVlby85dUxqaGg4UHNGQWRkai9kZjcwRW10QjN2?=
 =?utf-8?B?ZWpBWHJRNThhK1JLSUhLcGlXSVB5dDl6NTJmU1gwSG5uWW5WcnlCL2t1RDlJ?=
 =?utf-8?B?R2duakhkcy8xWi9TcC9rSkVucTVRTmtuQk1QQ21jYXJaQkJUQW5xQXFBUEE9?=
 =?utf-8?Q?=3D?=
X-Microsoft-Antispam-Message-Info: iDOTbDZH20khLGivvhKWmRxe1w+wurFYWzdqRx7DfPKBjuEGv+o8dh3dcXYjzGsMni1EguyLdmy4tQPZIYKk8CSSNvjXNINQ8TPA6u4uTt6xp7so7eFiuw+lVSnYLyCPQiWjJCaJVaT2ONHFsCuHFOMsx2Ru8cWxGkrWvt7uvs3ApirNhPM8H+0q7Jn7Nh5m
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:RMQGgSaiI0Kn2CT/tRAaiiMmO/VQ9rbFisk1LSMDeAAbHnD9TcPKnkXuURQVEe26SQJo9kvz2NfdOryqpf7+2prgrf1Tur6QEbNygP1Xz8cqBQKIRN84Ijv0ssSjUHqBvXG8lxZCfVRSGwWA0di7oaK7UpaMshFofqt5Bavr0i2Ds7js1pZezU6f2ZjymzGXLZwcYcBuCQMOfUHyr3E/peKkVFzzKRp+1NRm503hA7JLjJOHrvdc6Y8xkNqEQu8A4n3nbdwfGSPjo0xHWeCmFt140dIbYP+Pv6qK2lEEpSfkL+4hQNgXc3zTRisB2AmfDNABBWIZ/UmjGL7oZeK9y4BIqwg59CiplVvtLb5coyc=;5:uXGDhMTTFawkz+NghKJT4URrsxjMDdZX2I62e2zUzYgiGW2tzNF2gf/rhMaCW0aHlDMm3UiS0mfMbxvEfU2MNbYJLS1EE3g/qCobqDC4eCP6HHKnRMlGFXqA4VmW9+aLj0L92v7UPh901WVQ9DCbIYJ5dmCBMupAWSsOR0GqQyM=;24:S0BaUXWGFiqomJxCVEIRM96rDF2ENdxPjm2Z/xW0QL5ap9Nphtk5qzsszbBSFF6BYzoHP1WhVSJ+I6SHRd71mFutnJFlkWRIsKNdnhRBKvg=;7:8b/4ubx7zN/StsfmTelXtJGtUzb4SiwuDhMqdQiX2+B6KLwHbS5nuaR0Br9h+73l8mC013GJC+XwhgdEPXPyLEcJA6MT7i22fA6pnmQIeMBeC3ZEbdPX59h+Q/51ruxOq3avtT4hJtdsp4Uzm2ldAzYCn9vRun585a3ZtWx2zXQE9RhSHD0LqraExf17TYfyAdhIpoSIqKweYWq0QVIievtiIVO8Ze77DBe+Vpqz/JcbeKWvti/SfVp+7xYnfNpX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2018 19:58:49.4931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26481a70-9a44-47ed-fec0-08d5852f02e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They come in 5 kOhm, 10 kOhm, 50 kOhm and 100 kOhm variations.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/trivial-devices.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 2e3740f98c41..763a2808a95c 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -75,6 +75,18 @@ maxim,max6621		PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion
 maxim,max6625		9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
 mcube,mc3230		mCube 3-axis 8-bit digital accelerometer
 memsic,mxc6225		MEMSIC 2-axis 8-bit digital accelerometer
+microchip,mcp4017-502	Microchip 7-bit Single I2C Digital POT (5k)
+microchip,mcp4017-103	Microchip 7-bit Single I2C Digital POT (10k)
+microchip,mcp4017-503	Microchip 7-bit Single I2C Digital POT (50k)
+microchip,mcp4017-104	Microchip 7-bit Single I2C Digital POT (100k)
+microchip,mcp4018-502	Microchip 7-bit Single I2C Digital POT (5k)
+microchip,mcp4018-103	Microchip 7-bit Single I2C Digital POT (10k)
+microchip,mcp4018-503	Microchip 7-bit Single I2C Digital POT (50k)
+microchip,mcp4018-104	Microchip 7-bit Single I2C Digital POT (100k)
+microchip,mcp4019-502	Microchip 7-bit Single I2C Digital POT (5k)
+microchip,mcp4019-103	Microchip 7-bit Single I2C Digital POT (10k)
+microchip,mcp4019-503	Microchip 7-bit Single I2C Digital POT (50k)
+microchip,mcp4019-104	Microchip 7-bit Single I2C Digital POT (100k)
 microchip,mcp4531-502	Microchip 7-bit Single I2C Digital Potentiometer (5k)
 microchip,mcp4531-103	Microchip 7-bit Single I2C Digital Potentiometer (10k)
 microchip,mcp4531-503	Microchip 7-bit Single I2C Digital Potentiometer (50k)
-- 
2.11.0
