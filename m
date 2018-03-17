Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbeCQWP5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 18:15:57 -0400
Received: from mail-he1eur01on0128.outbound.protection.outlook.com ([104.47.0.128]:32661
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753137AbeCQWPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 18:15:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [RFC PATCH 1/3] dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
Date: Sat, 17 Mar 2018 23:15:23 +0100
Message-Id: <20180317221525.18534-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180317221525.18534-1-peda@axentia.se>
References: <20180317221525.18534-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6P189CA0021.EURP189.PROD.OUTLOOK.COM (2603:10a6:6:2e::34)
 To AM4PR0202MB2769.eurprd02.prod.outlook.com (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9563e58-05a6-4f0b-feb1-08d58c54a277
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:mITOEKZjTzG25LVoOSz6H1BH4quoCaDPAMLMPO2AGNcK26hVKRgfLHf8MZKcOzLzwWqlxxWgcSoC76so39FeF5xfUyQ2V+MLnoUe0AaexcSHQX8GMTY9OhHXntOuvWpr+DadDii+LJ6twPUwpgadJm9cLuAsw3oLmUYjoJMH7V7BL7o1tK55HoJ75HoCIN6/gA4SqBoGeeXCyiLiYIayv2CBJVqNocttow32fBME3IQ7R4Pb75eHPi/21zkMxDQQ;25:Tq0FggH9IEYcHZ0pELBDe9My5KWqJnK0VdyFxbIHhBjHwv8KJg0JzetDnUxrr/A8woDRZvRrmHGn+GzNjfx+vjF0RtRGwT9G2pdwuntxGfxf5cHCmYcB8cS09yjVXGvouUQFw9maAT9ZrzaYwKR6u4HS5QICST22EcHj32/GzbwBG7lEilIBdBtNnJIH8PeehqkpV5juKak5NL4B+tdsphbJ+4CJjrXMr3O4KxohFgMgTfULRd5pgjR+4FpFYIyaxicIki+WLpbbQuQu1hmCOQ9ti0XVF6Nocvm1/0tAxpltH8cOTreTuXltv0YkW2XFvlYjUeofVxc1YHgMds31Qw==;31:I1maOrj/EBF529bs2HL9rYPHDP8gDL9rsIrKkqlZm0CfIEfQU7kzQdh+5xjCg190Ln5SbkV/vXgc9rJtr8sSwgKz/9vziyX4BoD0wML4El0WgzElC+wsPs/MOfCXZMonX7IEnzTABhJ7m2Oa2iE+W86G8KWG6e69l2Pv3TLfTS4iM6hbfFoZdA5VItwlCHpSBUAo/j/1uHBVf7vZzKowT+94L4BG54WjEWGzyCRUiUo=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27696F0C8E7EA150FEC2C576BCD60@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501300)(52105095)(93006095)(93001095)(3002001)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:VVXsttcdLlTkpsF2MKsYaYfgkABXG6aU1EKTEpSxyX8ZLaJaOD2qts1BMcMbJFgI06fZBb5bo760Dxi3St7HDCNTZY52EgBXLyGqIJ4N6Uvzy42sPFnHaqQr6CvJrP33sY7sDjZiQ/sHuWZ8bkGByibwzdxddbP6SEiO0QMP3IkOheefbv19GuLuODstYRld9dc/2ftCErraKbYvmN1+9XZihVsOmTVtalvuzWpusdNZ1bOikgPjGd+fdKs6NOhBSRp9pZB5ZTMsL9mCo9kOwQ==
X-Forefront-PRVS: 06141B80DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(376002)(39380400002)(346002)(396003)(189003)(199004)(26005)(25786009)(4326008)(86362001)(50466002)(316002)(52116002)(51416003)(76176011)(5660300001)(186003)(66066001)(68736007)(105586002)(97736004)(16526019)(7416002)(48376002)(386003)(6506007)(47776003)(81156014)(81166006)(2351001)(16586007)(6486002)(478600001)(2361001)(8676002)(6916009)(53936002)(50226002)(8936002)(6666003)(2950100002)(6512007)(74482002)(106356001)(36756003)(1076002)(3846002)(6116002)(305945005)(2906002)(7736002)(54906003)(142933001)(42262002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:i7FCd+Z30S2gWC3K/UsCzsLuksj+Zg4CawpM0qh?=
 =?us-ascii?Q?hOFP3sfjpjP1T8q2lnLYirRPuW1KWw5YTQfAlLifYFHMkeS/SJ6Gdaxutn8a?=
 =?us-ascii?Q?pxWw5KZU5qDTlN5++58+uF7Ba/M5nmnrxbtoJ1GqM/p85d8Pp86pdInFiode?=
 =?us-ascii?Q?4YdhdWGrukLZdQViMezW1njqoO01P7KXjlYGUQl6PpAJC6DcO4ZfM2oSNFqU?=
 =?us-ascii?Q?uVqAO17JXiy+psvw1xozHgWG+TmkkwuQ8QZjS1SbOY+oEV7GTZcLiZSDjCpf?=
 =?us-ascii?Q?EVmRYWXykOMAHv7kVbxkzH/EKEnLMsHQNqWMksSX4caTYTPKK7OyuxAvAzhT?=
 =?us-ascii?Q?RJ0Wfmc5xrjbPUNMVmrdU6sdnxX1AMVS4mt8960K8N9yUp2kCjI3Rh1N4dn9?=
 =?us-ascii?Q?WULbz/muQ97BWwoXhwTtc4UyTEsrtF9eQUptJyJesdNInc3sx3BlaO+LQxa3?=
 =?us-ascii?Q?gWkg+hafBQ2vjnwLwvj4q5kuGmCs2bp2FLzcmtCYOwaTdO7dxuDw8ZDjqsvS?=
 =?us-ascii?Q?m0UFXCaOpgjvU2RSXYXnZTz1EJtmvdCEGHguqtZJ6J2LuDRDY3q0Td3LFXP9?=
 =?us-ascii?Q?0kpSEhuyzrIsMpy3LMmkGBKuSY+srCQcuRKWr3mxvEEV/GXcFEajkmK5VL78?=
 =?us-ascii?Q?oYhzMD04RZ58os+cR5IAX5qW/mDDIUIol3Jbyr1jEsWFj+gTO0icvwI0QhNa?=
 =?us-ascii?Q?P9SMBXQQmQC+BNaVkfISJgngQF1+792K819dKyIGULZjnHW50RCiYGCF5bPQ?=
 =?us-ascii?Q?8AWg63eKi08RYJKH5aeH0T7XTEeTTGIT/hRqzeBvCsRVn+MsWFTRtgjWHjoA?=
 =?us-ascii?Q?NGIYjibyfJSijy6kucnFXt4Zg3j+CSF32remtPdy15BV4X5lvwd6Iy3q2PRF?=
 =?us-ascii?Q?LW0AZnT2Qv96rii2ikg1xbhgFoilTljJR0qTWst4AJCRUMp/kF+xAEiQ9Jio?=
 =?us-ascii?Q?v3Xy4KHr9aWPd39fwZ59v3ddwfPLo5kUKTkmlrcdeaVReFWsaIlvyEYzuLPu?=
 =?us-ascii?Q?OiGpaiS3MetoSrr0Q1Vzb9xbL4920YypvhV2yBepQNY6qQNoHd9Ipssw9XS0?=
 =?us-ascii?Q?Z/X5mq97QNwdsVnhpoMs8kILOsVc0M0DRwevco6NhmervHyF4WGnY9Fd7SHv?=
 =?us-ascii?Q?CVWQOS+o3iQZXEhQU+TLNW8oJPArMKb0N2UGjtwGGJ8kLOIXZGNkKoQ2VChx?=
 =?us-ascii?Q?QbxvJKalRLzHIGbG7gvE8FtLI90EgF2F31P6vFqW/akzerXs8BUoFEMWGYXF?=
 =?us-ascii?Q?+Y1ewgyJ1V0iEKBuicRwSzRf2ObNXHBvQ7saM/UBt95sQBhLVSLpxnwv1mRH?=
 =?us-ascii?Q?okQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: FTEqVOGAaycNhh1LEAwvuVGx0MgXxALPucFNpHtgCybl0aS9fg8Zs5DQKVjCC1r705r6OvDtohsodEgB9yVRrvVlL5fw/jdefzTKsx64cHs/RQbiF4p/Cnq+kcDG2OeRbCsyRW8BIsV7Hq0KDabJv6vpIeFMUbMWcDg2utOKqo+ezgcdxY6s10cowrXK9neZ
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:maU36gvZ3fAnIp3eMxQrepU0h+FP/JWGkhEJ4KkelBM/1b+MnUsQm5+VwQ0wSpSocQ2mbXZass+AoQDVp6WP2WX+t14oZcIfdKW/CN/Xge9DzVcLf6PcnFCrUjKY3he3eYw/Z2/jp17cj6sIcNbxeZfZuSXEkidJpt9mE4fiDDqXcakFDv9TiyyqN4y4zT+SQSk/QP3bprP3KqOElk8gp4oUG1OnEF52rEwbg0i/cZ4TjStteELZ+PVqxoW4qNwJtCE9LHaOL6UjuKgcwwrJw3mMecRZHUr9DoIRyaaXjvqXS+VYAwXffIOwx6GPUtyxOYFyHTpw5yf3r3eSKGG21N2y9vSBL7ywKLF+b0bMH/8=;5:gh2FvppiKUsuA+3diE0YYfYcgikqVzQ2Z9+2DtQ5+zFtT1iPu9+4HWxVVx0ABNxBo9/0ya6e4nZEXRbWvdRXnkB4qntvkXeUAif7alXE7+3qVAEZEkbcrLY1YQobVwHszTZDR1hPgMgUPf80Qrpzk8b4TTlkm1uHY2bqPwJypaY=;24:hsf3E5oWI712zmxLU09Jg0qodj0I6Cgb/CrP8ERehMslPyiyR3PjdnmBW8fK6RL70sSuoLvbNU6DiuxJDcrl2zMlVyg8fw5SG9uFxJrzYrQ=;7:g2lKoGWRd2iW/jpZc2nKoQsSUiTYQxZAcWrleGJyF3H0SJuZajb3fAQuu/eBrnrZXsKwdGp8T61VzfhrDOaJ8YpsfRKHUvTfSk/UqXLGk1luKf2YWyLcZ+tmqxBi+BdOaKVZz7D/9RbOYKuoG/46KYUWHkJwF8a6vvp2sgK/a2Y+4hQHt/Qq75TpMG8BFvECsPU/bMsj74zQlHt0HX3sXuLJyVzhdTz6v/vTz585DfzOXiA3K54+evF89dd/8cfX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2018 22:15:46.4020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9563e58-05a6-4f0b-feb1-08d58c54a277
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start list of actual chips compatible with "lvds-encoder".

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/display/bridge/lvds-transmitter.txt          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
index fd39ad34c383..9d09190d9210 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt
@@ -24,6 +24,11 @@ Required properties:
 
 - compatible: Must be "lvds-encoder"
 
+	      Known actual chips (these should still use "lvds-encoder" as a
+	      fallback compatible) include:
+
+	      "ti,ds90c185"
+
 Required nodes:
 
 This device has two video ports. Their connections are modeled using the OF
-- 
2.11.0
