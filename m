Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932401AbeEWJeg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:34:36 -0400
Received: from mail-he1eur01on0090.outbound.protection.outlook.com ([104.47.0.90]:36413
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932164AbeEWJbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:31:40 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>, Andrzej Hajda <a.hajda@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v5 1/7] dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
Date: Wed, 23 May 2018 11:31:16 +0200
Message-Id: <20180523093122.27859-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180523093122.27859-1-peda@axentia.se>
References: <20180523093122.27859-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::23) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:eVEcpzUctpY+ZXLYN3NG5ujcpeY8pO4Z9q10wO9Rf6ZJ2UAfPnAU79WwhspeHZToNOErY4HeL97M4r3mseAbTGsKlom30u/Ys/yTe0iSEILmJt9w9Kk4HNggvSGk0KNi/VJcIatwbxqgOjQk8/ftcubPKXAP/YY0KSpaGf2t7VgK/H8VlyI/JwfMTvErf0Wvo3H0TFZuwkmSvtT1EXi1gAJ7ix1TmlGFjXa/+rjs3uqbkGItXY/SFbnobN0qY74f;25:Z40N+82EP2IiieuxI/wy9s9zgu6ZJAO4dT/Vct3Sqm1nZayYUVlbWcK+FpEn3Zqr9ORtITvLf0uGboM73TVM2tAq5Ub2l9m+gEKyTgSslcA4BEsrPrmD+eBf45wtWeLo8mbCJP7lObszP/WPcwX07yvp+Fcsi9HRZCCcHk1w+DtviU083iQnXTRmGB7Y1jUQejN1fHqvtgk3Nx7yfC/Gu/ATpB2BX5QC/JSZ4cALnGSAadUbLPoBuH8Dh8cEwqL+fTT9nXp+jMLOqpVR3ANbg3rytXKML5cd2WE+hnDJ79Y4ybkODlfv4wfvYiugGBrbqdTu8+e7bDcxOmlK9TVqGQ==;31:B7Pwqq/mFUgJfWvIWtuWgeejoedNugholuFBuHLYHL5TBwD79kpi005UtNGe54YXxWvZEMUM7gcmmHP6DQp1XCWqcusiOjz1ViaFgEl7KMiyUdHqFBCG3+h1RFEJB+j+n77sfn+O28cMVIAW7HhzEcOL08rr5Inzv6jrg+ChDGTyUBrKSBpdZAq/ppD3b1UYirQu9z6rTBExZ1fyLDZPj1vcrlOKk6JOC5xvUZ/SQvk=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782B86FCE215767B899D166BC6B0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:bLW6nTmr/kuuFD9EH1Obf4wcrdwFzKfHQhG+ALZukpCd6hDI0yobekaSX3m9A0MqmJ7//N0i7M7ade06DKC5evm4fcydxJlrKNtD2as5fG1Hu2HEWXr4Zxr+nPByJQqNCWBF5GdXePJ+1B/PrY2im/FdqM9eyy7Js5G22usct/zznRFLIOdv4mhU72IAMjhVyLs41sIkWlkWRLM2ivzkYGBIazQUE/0yjuSIEeWg2QpvjEC5DkrVWJCpxiS87pdNf5OL/vuGRMEe/rqhqRsCIA==
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(39380400002)(376002)(346002)(366004)(189003)(199004)(486006)(68736007)(956004)(476003)(3846002)(97736004)(6116002)(478600001)(2616005)(5660300001)(6916009)(6666003)(53936002)(2906002)(4326008)(11346002)(6512007)(446003)(1076002)(36756003)(86362001)(16586007)(7736002)(59450400001)(76176011)(52116002)(51416003)(25786009)(7416002)(305945005)(8936002)(6486002)(2361001)(48376002)(106356001)(66066001)(74482002)(50466002)(47776003)(26005)(316002)(6506007)(81156014)(105586002)(16526019)(186003)(386003)(8676002)(81166006)(50226002)(2351001)(54906003)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:O93X7NYW9Cn6ml6vTQZ+/xrGGhQW1eRSQXaehYZ?=
 =?us-ascii?Q?wIBwtDVhog1HQ9+5tkivwlNAxa3FlvdtSRS0Tyo42pnIgqorbdCCilGSpeeF?=
 =?us-ascii?Q?Zujb3sJ658396YZahY6LfAtZYZXXfR4SVgiUPc0NXCz3wmsQvPjLf+s1VjB2?=
 =?us-ascii?Q?gv2y8rgVTM4l7H02d+A4YtAQ4d4BHYm/hH23AxHcIsAjBpFjqXHiZY8zOl8e?=
 =?us-ascii?Q?WGf1+IEHPE9SHzOHWv59wGGN4xDKMlCC5cYpCUpdMFmO6e8yNPyIcpH3+lhs?=
 =?us-ascii?Q?Mw7fox2p4VkBy9fJ5AlpRMarIukiC5mzTOCRzUoQsJsuHcGx07/Ho0BEaocu?=
 =?us-ascii?Q?6ggmrWVSbsG8dUjSYKfXVaHWt9Dy63to2GJGOBzxhdXzAcOtezPURQu3U6Io?=
 =?us-ascii?Q?5LFDmmm3iOPsWjFFd+yRKHIm2F+MTk3jN0h8LqExWrmwkk2sSH3RnsRE9nE6?=
 =?us-ascii?Q?m+jpcL4DrZe0TbjKdFI9GVcTJrY3zXZHQFiCUYg4bflrO3IjVIbGFMKkeEeb?=
 =?us-ascii?Q?DuLy6ce95GanRxrFW9PKrv9oj7DHJ/WemtIHwlOC11OzwqkHqcD5oHlGQLrj?=
 =?us-ascii?Q?xV6iJIqNVOtYoY675sELpMoTHHWgXefVQBV8xTkTRFuowINsRGXjSetKsBVc?=
 =?us-ascii?Q?z7a6rnWCMJS3Os7MhhV0ge54GWGgY2b/5CyOlTIkvMAmDUQGegqhM9dtmDM+?=
 =?us-ascii?Q?exTdUUd/RfQ9YPURKF9sMPJ7W0XaFZtPih5Cxrg7kLu4YIjQkZ7tn38j1NeO?=
 =?us-ascii?Q?9EyIJIRURrwFzDSNGKvdAAmTmoLRDt0cllLr/q0bPzNuzh3XBElJyunPr/h5?=
 =?us-ascii?Q?KyV+S4NEX8cDxKsAX3bEQBFCmcKMAJ/tcAB1sxb7yW6obibz+sXhoJjoM8Wg?=
 =?us-ascii?Q?V3WdgRf6NMdGF2LNCTjbb9i2j4sh+br+Ne82F4z2mUErL+juNFtejcHBJGDZ?=
 =?us-ascii?Q?9ynEbApBHAoivV7TV46KZRIeQ2ecxjo5+FPQlQfWZqdtuxhPEiIBywKjeM14?=
 =?us-ascii?Q?kSTZvvutI+bxYEDZOSPvcnsEOL8Ybsg2xp11MsvlILjhwecCwXuXYXIdjojx?=
 =?us-ascii?Q?JtGrfjpUlyobaizksGOn2Kdase2mWlB7ofzQNB+CvZ1Do6WpZ8WFKPCgQrqz?=
 =?us-ascii?Q?RZAS5ORbrbuuvl8E4Kh/nNLmlrtqfr0bcqMETJZLTQ2/EHTKs+KGB8om7xyF?=
 =?us-ascii?Q?5swXcJKF0Tv9aDmNHC8IWvTon0o/TGYrmc7J3OCmtdpblQ2jA6TUA946KQIu?=
 =?us-ascii?Q?yzSrx88IQg3wbGSIG2hDkYOG22dj+5sWc3Q8ymCGj57xR4EekMJKEo8UEAFC?=
 =?us-ascii?Q?d/Ch4yHXc3O/HPbTXQniVuxGjFHgOtw1UCke4j+EZuFtl3MG/AA/4r/LwU8a?=
 =?us-ascii?Q?4+C9M7A=3D=3D?=
X-Microsoft-Antispam-Message-Info: TreHHiXyb/Qmx0WtwS22nvMwrOGvFGzMDxkmhclZsaqJYE3Mxk0i9UdHq8VpIzgpYthqC67sEr5s0rfolSbcpPwbOnvW0iysf/AjdNYuYMNLHsvWyMHsGeeFhZBDKN9c7ftZb9Wxh/iXR+lSjOU76PT3nEfMZkzwwR4mWmUv9RxI0EVZUd4wsn9cB7n7KXo7
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:fWyK/bNouixEEU29Raelo6ZzJOb6oIjaIjZ/fEDUlzpYT3JwSFbIb856gk+/aAcf+qJ/UK1BF96WWStM53hU+VQOIvlOullI8sOSegfCitr9wRdj1Trol2CmXsp7L3fbFt8bT2Q+aifsDNZGWWM3jFZeIDMjDvHbp/ISPQhRB9Hnb0p0lDRIOYlkeFgB5nsd+wEgaecQwkIgW2n77MO9H3RC72kgXLeUOQcPTmgDMBevxC+VZEraklWJrB4wVuOhCdIPyAsr7dof6wLOiDdBV9CNc5I1Hla9wOIAbNInIZcG80jFf8eOVDSRr5tUOv8mSoLy2ZR3Pivlts+/g1n5RS3FkkeV3gTufoC+f+Z/VekJxNHYLgrFmyKKGIbaywWwT6caJKjtTIJQ/c4wE14iluH1JcrfQApjkYO/nUN3jJG9SfxfZh6cwL6OcYMn4avCjVS91XiDxItEwWQVCdpL1A==;5:SI4yMNPRDh2Aoz8NhsVsyXR22OKAY2g4DAZUYfN0fLcV9uXtZQs6eV8BEb2Q9gxifB4mtsqZ2E/SxN6Xh33uij2f6BTs8CUJCSBr4S8Dvi1DeyXo+n7CYdyH/OVjOS9uUbpWoRgRmSu5Iotjb686kSWf7dzxePgPaF5Sihoh4+U=;24:obCoKcQp++ERUecFB9A68HW3xr0kJLxzLaGAByKG+lkJI83U8I+M0oRRsa3VHOVSSSBkwhyWYSc7sjTCZIWf4NwOycZ4OCuum2e8n7tsadE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:nPxqA38vIsv6G6dNkhQPYfo19OA2eLfa+7AxOQ/GPpunQ2gtt7QT40nZbcnUaxIzUMyb8AwO2lCIM6+LpxuvLxZ89e3+DOgcNmlUDhZ07P7KwxzQiLRTWX2Wb9VhLJAciQ+8ri+VC3PU0IVb2BWqOpWqANk4xTu+AKm57zs9h/6EgjbpWmev9Q+Um5N2yFSMj+4KSzEyUB74Jc+5B/psz/muG6MIseNtTsji8rRr5K/i7MROte3tkjZ/K5OHDfBl
X-MS-Office365-Filtering-Correlation-Id: 8f888002-409a-4e09-2386-08d5c08ffbb0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 09:31:36.5774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f888002-409a-4e09-2386-08d5c08ffbb0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start list of actual chips compatible with "lvds-encoder".

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/display/bridge/lvds-transmitter.txt       | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
index fd39ad34c383..50220190c203 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -22,7 +22,13 @@ among others.
 
 Required properties:
 
-- compatible: Must be "lvds-encoder"
+- compatible: Must be one or more of the following
+  - "ti,ds90c185" for the TI DS90C185 FPD-Link Serializer
+  - "lvds-encoder" for a generic LVDS encoder device
+
+  When compatible with the generic version, nodes must list the
+  device-specific version corresponding to the device first
+  followed by the generic version.
 
 Required nodes:
 
-- 
2.11.0
