Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753362AbeDQNL0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:11:26 -0400
Received: from mail-he1eur01on0106.outbound.protection.outlook.com ([104.47.0.106]:8025
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753276AbeDQNLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:11:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/6] dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
Date: Tue, 17 Apr 2018 15:10:47 +0200
Message-Id: <20180417131052.16336-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417131052.16336-1-peda@axentia.se>
References: <20180417131052.16336-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0270.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::22) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:0Ay/6bSpHcBb0zUXgp65qggsPMrxDPElpvzlx+UveySSw71mpeNmM484u8Chx0t15+yAf1zwB1gtdwYTsmgo89K5udcWQ2eYV6rb14+TVALBdP+tcWGZWuxlwWhvlezCiVpTaYlXSs2BfyF3pfonkvbvlSMj6HP5T2ZqdTVRfpI/u8cDmXt734awBtpRlP+S/DyDm3KpNTkssvrsBMUzf0QTxT3EQHFpcmrRi0A19U9/BXVvzNXTyUwXy9QR67Pz;25:dnRkcJWd15vEEmN79F8Ox6IWIWaR85LIdlvkpqL33/7J/JSDjxBa7PiDhyTv4ElqFivCWp1BoPmn7P306nmKDegSofotqM6+CR+Pw4o6kgVY1tMoDdDzX504bO+EuVddjs0i/Fb0qQCFujnQK7ICzagtkcUAwIj00DOASvkjr6PmSZfPcepPkIgSVK68tjwmnzDZD+U3r1aobJ9WrFl4tDDrlyP8FEbBvyb3mWBOTnPHYe/qHdEaqlud3Vymk1+JlWELpCHytmPJM6kGmuBLW6fyZMDfSHNXlZ+mIy5zy/F7z7Vgifp94BHbMSVXG68dY1mFKOysIZdc5bt6cOLbjw==;31:I53gN3rVeLJ3OE5w86BpwqIWtCYNLo1pLhn5ZWvOm4TcC0MjTquWN0uocunkFTlIGMprcx/fUlhFW9PnBjVaiAgH4XO/0KJnvAIRw2iqCZRR/C2aoVKU9dc9kBze0wql4LXZBinuYsdKp/YeHUXHCxZHk1Lw9+CqDlh9ZDFoU3biWCFe/vT0IvchvLlVQnVBVd0Il+O3TP6oUlLm+y5jpjhpzka+cjnCCd16oasDepU=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27787B72378A98D752CC6432BCB70@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(3002001)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:ZPtb/axRXhxeLLvYgyTdM5o3xELl/SMlYPP5KUCjIA20b3SLCFD5y7Hs8sqfo8JyQ1u0rcPAKYdKfnHq+7rvBzhwyDgdQYszMxA7C7lgjbxjhXsPD+nGLyO6TaEVJ9p4CRJG08fABmoVtX0pHY4laIzihhMiNSwt2APaZ2S/tGlF/+Us363+tSipdI321B2CjklDsc64V3Usn2Ew68CjuEAL3LIbst2pWPG9O/UwftfFzM0DWyPm43PVaBHX+1L3ILz8bKvQVPg50sfEFokaFQ==
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(346002)(39830400003)(376002)(189003)(199004)(386003)(6116002)(6506007)(8676002)(51416003)(106356001)(97736004)(76176011)(26005)(52116002)(4326008)(53936002)(3846002)(6512007)(476003)(486006)(11346002)(446003)(2616005)(956004)(6486002)(305945005)(6666003)(6916009)(59450400001)(7416002)(86362001)(1076002)(2906002)(2361001)(2351001)(105586002)(50466002)(36756003)(66066001)(47776003)(81156014)(74482002)(54906003)(16526019)(186003)(68736007)(16586007)(8936002)(5660300001)(7736002)(50226002)(81166006)(48376002)(478600001)(316002)(25786009)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2778;23:kxIvaYiVwMMY8Tz7OgwDZZT8j5L675qKeB1z+qk?=
 =?us-ascii?Q?Bzz6AjggDminVjSPejAn/nQ0MsIZDCLgL6tYLwReHBhGVtxo3L2CNnc2cCoY?=
 =?us-ascii?Q?9ePMrcdQtOhfurIxNpinjLW7wbBsZhJj1rnAtP9nIN9p2junoFzrr+E5fBmd?=
 =?us-ascii?Q?rN/vYeZ9dt0gkzJW5+uE5L10kHoQIkfSRlfEZEJc2t3Kpdd3ZtW0XdCwAQzN?=
 =?us-ascii?Q?P3cNrOkxoDG7AewTDWqleRlKI/Uo3IrSVUy4UzCXmPtWf4Wlg/lz/hHP5LZN?=
 =?us-ascii?Q?lrQ5skQShf1jCoq5bEuGJUe430qFuPth7ChfovX53CB2CfW0JTEB8fWxqv7O?=
 =?us-ascii?Q?8rb2DJYchqXZNaaZSGtOrwuY52/xtLEmDuYqd1j8PPrQrEc9Q3EFpVSPnqc0?=
 =?us-ascii?Q?kCnUrGRXQGVkLcjkoph3NAXmvUDIUXNFg2dMvcn/7xO1SXPpQQ7XQ3a55YB/?=
 =?us-ascii?Q?Vggs9jkA6pHGzsYczgG07+8wtKNy16RkCyB1PSoDr0yD8fT9WehDvdwKq8kk?=
 =?us-ascii?Q?BvNU9CQccUZL3lgdKcbx+cB/CYArB31kZQBhAmEPPC0zrlyqLxb2TglTVMem?=
 =?us-ascii?Q?T1iduMHZpeHztRMyeJhSIMwlH2q1b7ERfYBIwqFpy5GUkFEcNow0anDVrk/F?=
 =?us-ascii?Q?9ZhAQfttB0tpTWzHOSfv+pmlBW3dtOQFd+pyDJ1ZAIQA3PoKsRHHy+Q4fc1b?=
 =?us-ascii?Q?V8l5fpCxg2aoKIUsuKnV/1hV0V4qvxQWz4uP/FCsRyVCf/VSHFNx9NWiDXHf?=
 =?us-ascii?Q?Yuklc/2Lo8YcFPVY/SKeVYZce9R0zE5iNByXI0fM7xNeFIyIzbGCUV15r2Du?=
 =?us-ascii?Q?MuXpKz7/KYan8KgVv6CONEyLBPGHNoJn/Q1KM+gzmaHJRBOV+QRoY3kJFFE7?=
 =?us-ascii?Q?mQqdet5joImsk4fquFD4/C319r09quTkyS9yOTfRz4Xy+dlsB0SlUaUzqwgL?=
 =?us-ascii?Q?uJFYz65Ggd5uWYIfnY7apAb55pQ9LohSh91fSv2NbGxcnFn/J1UgzFZbTEfy?=
 =?us-ascii?Q?+NpYQPe1tjWwjKyYzoOoc6MTrXOwmhn1NuAbrxIkKvTnEc+npxI7Ed1ECCXu?=
 =?us-ascii?Q?xx+6I0UUTh99Tc21Ts51sFFMUQbDWKXWJ1wppRSyHjmRDsPOJQfmcJFFIhKv?=
 =?us-ascii?Q?Uzoczr5Uu/bxLtqPscYRNp94vfUyZf6r8+IzeCkIyhERwxfa2TK1K0cC/bXS?=
 =?us-ascii?Q?v0YiVjFkOQyaytvG82tWjhC+hed6V3vKTKzI4VviMf1pJysC329WRj+2i/IO?=
 =?us-ascii?Q?GLVPZbvGo3icaAgPR242szTm3DZhEi2+lMtj1kdyftihddtbEQrUR0RBFJWR?=
 =?us-ascii?Q?KasdnkpSPxkJs1gpQptj/suAmTxUQl5Nyd+uLdP63CWu1+2/O5hyy2661mMj?=
 =?us-ascii?Q?PHtTPXQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: OZ60IOnHtTvnR7q67EomrBDEG3sOlhXonKFD2cIl/lbehq+9gKaQZzSHTZy7inHAZ+DKfmmGIj6sXtnHQTBwnUDemLtDo8CXKTh7H2rP1h3otMdXxZX9tE80cb6HWRiWejo2owvBskc8Wt3bgAYBYnOYFeRixLHVFRo7LrZiq3tdkTVkwMfDr3BhgxMKF29x
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:sPuxO9AofRCWiX+8IipkCLFKpEmbGXmciYKJ5pYnnDslW0HZGxQ3SJ+/6NxKkmtRW6Hv2+okoClGp+clo7lT15/P/T0q7IZ2fpbib7e/0rvH3oGvEqx19vKNDg31Zr6bcUMLmfiHkPd+85lLj2ueCdfDFMnETlCI96Hy7Q+bplBKfn2HJegcrwfp/4wbukW0F8ym+rpzRN72TNw0pHF++VZyeb8JqLjaBZH5YwrVavahwOJbmlS2pehZc+9KgVXwWOurz0g/AjrR1iRHxtigzhh6IdZhWxGZ2xhpXYfVm1ASaZ7HZ5pQwUoedyylER2Bu2vgtrDmZM34pOoA5ozvxszbfo124c/A1BrBNwrJHTFCQydqJzkntnecL80uy7LhYynKXWoBn1SeZV9gu1LNEz4LtNZNE0BFjXou9uGbUWTu9VlsoFddvD4+kk5qdhDY8IefGdTQa7FxtDcSb0+xCA==;5:44oSMq1v35okzl6gzN711sFwLhC0FQKa3y+F/+3qSkEZaqITmAQKK8GywrRgav4SINkUrfSSYFuyhgU+DInUzKssFV8IsDzQx/e9wvr7HukCzYxTGAU04RWV7EbbuScX7SeeVWI5VNWo4yysyryBquT7CVZ+Ynz/qVIT7GTo4ec=;24:rRVCegLMbQVSjanVfRZcU4BgOVVBEQXSvMPLSQUEtvxzwkHYuX93hFyTsL+cdljQh9+p0JMmVBlBnxYdTWLImcepz/gtV9k5sh/dfMIx6ZI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:lxnyYTMqXQip9z7YteTew7Kov3O5LCYElGZXdSovUg8k2BKAL3fZ3cBj60Y23W2z3ognplVj16Kl7GE+KZZx/xbuOcFPMDjH0Xs3r8RzzN/1t1pS4jOIq1vdyAuxxAQoe1Tgg+5cIJb5OAVGtKcWCFRMS6Em2vropNfYGHWRse9Lk+vG7UUTAdCHH2dputfXljsopa8q1suQiErrrnP2iZSVvx/rHuc+BYBRXXgPPijdwm7VpUMBD+4+q0btNal5
X-MS-Office365-Filtering-Correlation-Id: 30576b89-5eb9-4535-51ff-08d5a464b432
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 13:11:16.5768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30576b89-5eb9-4535-51ff-08d5a464b432
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
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
