Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757150AbeDZVhC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:37:02 -0400
Received: from mail-eopbgr40120.outbound.protection.outlook.com ([40.107.4.120]:65072
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757126AbeDZVhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:37:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Hans Verkuil <hans.verkuil@cisco.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: adv7511: fix spelling of driver name in Kconfig
Date: Thu, 26 Apr 2018 23:36:44 +0200
Message-Id: <20180426213644.29318-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR09CA0083.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::27) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:sxVoFIvtuaA1SRiV1Knr+wnKpyTHXquaEZkD/EaNlW1wB+J0p+ImukR73LemjSjmplkbaCpENCSmX9IX3i+l1fmHFyB6Xc/dCm+ByCuv/1EDU/dljYPm/x1jydBGqxjDKFBylpSXY6wijtiZHrlW7lSgtJwT89pZadJWXKTYhIqNJBVqUBnHVKMf5ZhaRiIZgn9QK8eLx3NHdZPGWq4LvGQabU9t1VvYB4RGMD8w7D+UC8qNfQB6wFgdHch48Lps;25:zWbHcJYdC7dRnvJkmM4x1KDVqqR0gG8Tis1Xl763++u1zWASo8OHMjrshLuDH+5GPEhBCUlcEtS9/VjulfQ78oYhg9TZTk8DTKe3j41IQvyVwybimrZrSsPRLD6uSbJCCxgdqQbwjxjDFMD2l935zzZ1f+sXPEQnIW3jdWwej6ynBqiDz6Aw84GdIcwJhmTZF/ChxLJyX6vWrJg8QksKea8hRuEZkM/6qCxFOlRGqUoSmY9C57Rg5bik0U6NiabJb3JdRugP7tnVGoB48ofWJPeyImZOKirOamM8A49CrtCBbEQh8zG9e0tEs+ELI9HwpJWWoacRBphmFRCcR2/2nQ==;31:wA065pX+tksDsEUX7EIh91beMQwzHmB0lc1zImCBLM05GgAhYa4iI0OhY+K97Q/kbBv34woO14nOpanuYGPw713xZp8M38ZydyHt7yjoRQEsK7qduV3Shx4u4wF/DiUtpPrgy9OITL8bFJJlKTV+dPLjcMhqzjLkt0dZMrt3M4kyMB1WhB0fS3+1incVnvtGisMFEJgkCrQ7FO5IWaH7KvuLL8OPoQbgpFC5EcgSBJQ=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2779D2DC02A447B1BD95C9D4BC8E0@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501410)(52105095)(6041310)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:/H0EeqKuQbMALSQw41wzUw60tGJ87skHXQ1RIhkSJzOb4Tappdxz4wP9OBsRaiqtfSeyVFVC+2zAzBXVHes0xcIqSu4S1Q0wQ6bxHJepVJ1dHdzgOQRDyblF+UEaMPMxQ7/OFIGKyah1CB4adPpCO96x3Oms6RP7Jg4FA3Wc7HZjxrcN5kj8uJQ2VVjzSsU/uonpkew0+jGJOD/oBNqXyae/2Nj3kprUpYwOg6G84q0E9UZJoW0z+6jfDuQ0afqO1FmFPBK87R/Nxrsblb7sRg==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39830400003)(346002)(199004)(189003)(8936002)(476003)(6506007)(1076002)(59450400001)(1857600001)(6116002)(16526019)(2351001)(3846002)(26005)(186003)(66066001)(6486002)(105586002)(50466002)(2906002)(2361001)(47776003)(478600001)(48376002)(6666003)(74482002)(81166006)(25786009)(81156014)(36756003)(8676002)(4326008)(6916009)(486006)(5660300001)(53936002)(305945005)(97736004)(50226002)(68736007)(316002)(16586007)(2616005)(7736002)(86362001)(54906003)(51416003)(6512007)(386003)(106356001)(956004)(52116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:izpP3d+3MK6z5uxsrNngOiGZvQ0/Wd3gYzWyQnw?=
 =?us-ascii?Q?vR7GFd/3e+Z9UicpFlu6T5o4j5wAEigfRnVLXsytyy9yxX7AzyNOiqjSljT1?=
 =?us-ascii?Q?nHVRxm61CvpJ+FTptCcQBfOli375kXSrla2ojq/RyyDXuE1geGPrp2D68xpR?=
 =?us-ascii?Q?pJ5I2CU4sYu14QNA+n6Ij3hNENkzWKGCNJR7VX+9+1nie6hGisnciNgJfCjF?=
 =?us-ascii?Q?tNjT67eRvb3RiCjG4F1Wmti114+mxfNUo85UYsOu48zxbzu514ufVpIjreRl?=
 =?us-ascii?Q?tYjPbqUDcVWoM5vmFEE/yvOhsUHPA7UBb/8X9tonSunJ0Shcqmazk8QCJQUa?=
 =?us-ascii?Q?2wqVG3gOjsJjMVv40QLM73lv+/c84sBCZGBUMnGs7bBTZt7GZY6t6qhSVvOU?=
 =?us-ascii?Q?9FRjjIZYyOSv9zlDZ+IAdz1kLMcUK6fUOiljM4Ft9nNhT6+iw5u0E+gaXK0B?=
 =?us-ascii?Q?fk/tMmq4J6ZYjuE22ZDp/0GT+bjpdxRuVmqdQr4Fbo7tV2PCKLi0XLGe5MXm?=
 =?us-ascii?Q?AyrEd8hY0GW4URB2CuVu/ogve+f20kIkstZQMfTCL3X7PCUUScRP9yfysbiv?=
 =?us-ascii?Q?ieHq2p3RTfxSFzsa0vx8/xFfVH3WyjxQ1Ph9GFED/6hAX9A2fUTkxzZIeIxv?=
 =?us-ascii?Q?zMqWiiVJ065NL112gPuLYpNIZmvYU1ApVjbuRAWhuB0dLQd7nc95AlB5KdKG?=
 =?us-ascii?Q?WYuwKBfwMCzOr7VrTK9Wz1x7he1D9xLDJgdlPHKYwxSFtqD8LMcxS/eR8X6c?=
 =?us-ascii?Q?Hkaz07M6ZLw/EPkYighq3egOGv2XxiYO7VbwpvfuSpz1uLLlhu3K2DmIRrJ9?=
 =?us-ascii?Q?WCek/pSBUXvwIeIpKasnUDmD4mVnmLZRNLVjOEeyv3JFsW0MI6tQTy34Ug4N?=
 =?us-ascii?Q?VaqN8hdRTqEW5wJqCD6MnfXYrXqeGY+lt8Ke7fWIMyUV/qFciXedS67yzzG9?=
 =?us-ascii?Q?UPD2P0KhwV1+dIqRCMSegwKrd7brvPHLfScKrW30v79MUCuRhSfG/pYTZxMm?=
 =?us-ascii?Q?UBxmqzRP3WLxVuBBK8ppeT2/8HOVAM/yXRlGTMepjz6Zs4+LFVSyY2IYiszl?=
 =?us-ascii?Q?sY2D+TIZMIhyJPAj/JCCIQD5AufIYP8qlEAkfRDGpJMwWSIkdHD26Dvc3kgx?=
 =?us-ascii?Q?0peXrWuM2RnbYTYuUtqNBE7zW4V9szOwPIhOEfLZ7oDvHxKrBkwIXrRiabxv?=
 =?us-ascii?Q?JOIRV2ERryt3FkI8cX0l3gDBjWX4KR6EqFtBKM5PwTqtlbxQSwjZsXtiMQ6l?=
 =?us-ascii?Q?gnFhDlpYTIicoAmveZwmVYTA/9bw6GEZNBS9ZNwAhUgGGPt3cKpbALzma9vZ?=
 =?us-ascii?Q?VQg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 9nmTdKGJzNBToAjGGT0sUFXrrpPkPXZR1Ot3yMVURNDLMOUMjX8FcMY86T13oNdwQ1aCAqdJbxbQ5quUJtJaQ7KynXWeosX3e3Jl6g5+CHgwbdXso7FlfoHRbBqNU7y2Gl4C8fHCzIM1h4PdttwkTiJqQUA2iTRLDf9GZY4afeFs7iqeSvbcg26fpzEZLAkE
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:WmK7J2tl9c8NgINS7D2i5myJJyEP1bqxpzVcuHuo/OdS/eJ2xFxTZAEugC6MmB77lNtz5JyUM7L/P6f6xHSPVTf4TcHmR4+xzZ4ya0JqkXliRHxQkA+83o9o6scqruCBYXJs2mOgSa6kiXVPb0qByYo9zkcTB/QMkl1uoHjAxWaW81WQdgm9GfiX97fdMzGQnM7Ad6oXpIoWBwuCSB0ONisWYGxgM/tLh/T3FZBxWmOS6tfDgZtT7GaIPkzIquQIOsWpuoDk+knXB0C2FA33kPem0fDdXnjeUBmiQORkfvpBubcsos61n0BgmN6OGCzmphK23C9qo9HU4CkL9MBmLqZLfIzQ5qWJFMKvqWzH+Bjqt7kL12tHxFuMXGGwxDdMeRDBAPGNETgsjgJ6AEeuZe3vAt4zxx/qhXQv0iHG26u1EXPFQ9n2M5r9acu3CBGWvo6W/wMlLxEhRnvjEovo3A==;5:rIJoQYQ249v/egX56oZ8JEEpPFf3Xo0ataqDYRZcjXD5MEKTpyXgLSPTZB+PlT27hnHlfAMd4LgvRpaMnVa8hdIQ/BOmEOIc7oVWqoKJ/2OEJTCsFNpFrAICp3de0xhh48A7n4xMIwMDA0HnnD/cDdbvLXKb+zV/Gse3L/YB3Ug=;24:CIwE8WMXWBFDWgvKZkshxWfXMVQ2G9WAOGbn9hH4F22zGUgbsWWpuyfqQSdeVstEmzq7f3FKHwkO1qi0JfOnEEuAtVq5pD74Dd8m9iLDEvk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:Y/M4tvd7j55K7vDH6D96OveIB5BTFlICMea9I8qTfKytzfbRqQ2pP8ILEsFH6+M++bGJImPYu8PYGefyObcD+94ijV+wMnx/DtoNb+P2Cwl+4Hjk/9S7PjblKOZGG3eaMmGle2VfYp3Mt7Nv1llFif86qmaXLz6vksmpWT+as0UB91YtfSM79tZYx90zWsx8pYAvVhmmo41wchocY4NNB6OLr5F6rw+iEVzcWyH3vQbAVH2tutZGT7HJubnU1iop
X-MS-Office365-Filtering-Correlation-Id: 8a0b1895-8aa2-4928-8f9f-08d5abbdd599
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 21:36:56.1385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0b1895-8aa2-4928-8f9f-08d5abbdd599
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could perhaps prevent some confusion.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/adv7511/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/Kconfig b/drivers/gpu/drm/bridge/adv7511/Kconfig
index 592b9d2ec034..944e440c4fde 100644
--- a/drivers/gpu/drm/bridge/adv7511/Kconfig
+++ b/drivers/gpu/drm/bridge/adv7511/Kconfig
@@ -1,5 +1,5 @@
 config DRM_I2C_ADV7511
-	tristate "AV7511 encoder"
+	tristate "ADV7511 encoder"
 	depends on OF
 	select DRM_KMS_HELPER
 	select REGMAP_I2C
-- 
2.11.0
