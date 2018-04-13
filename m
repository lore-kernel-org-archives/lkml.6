Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754807AbeDMLsS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:48:18 -0400
Received: from mail-db5eur01on0093.outbound.protection.outlook.com ([104.47.2.93]:50240
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752899AbeDMLsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:48:13 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v3 1/2] ASoC: max9860: switch to SPDX license tag
Date: Fri, 13 Apr 2018 13:47:50 +0200
Message-Id: <20180413114751.6464-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180413114751.6464-1-peda@axentia.se>
References: <20180413111927.GC6854@sirena.org.uk>
 <20180413114751.6464-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM5PR04CA0033.eurprd04.prod.outlook.com
 (2603:10a6:206:1::46) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:WMaUYvvTBkyRlXWVQk9wcUdswi/QIjuf2Qq/yVxe2jfS7HBY1TOhB0P1SJNyAhZXTo39uiGVgf/3a1lflRFYijL40Csa1RO3zSAtP41UVgwbbUW5HYOmmH8bBCGMH6kFBGUydjM1EYOE9Vbg8q7BNCs6EGPoY0jElkBHC0MkglMkMSStjY72hDXBGMzgwn9aG4hptKQkJCIcK9j7LJ56fSph0EH6oI2k+bM7Vki6bYKV7yi6jC0heWFS/Y9t8DcB;25:cBm8HXXye8p5YuNm0nYuxJg/R7Zqod5G63ws1OhLP0wpWE//UvF8cmC3XnRGVTimHqnuSzXtXaTolImlJdVcbyAFd7IkYEn5DczoJejVqAjlbf30QKd9fqNWkkoFGByQ7As8UcviUuc3Z5IxteOqVUEaFulkYwcg40Rd9hJdxSkPHkJaORJWtxbLx7sVmfyO9d7Li5FYmytTXRL3TZqsXlnhPu12EBZCFXX6J+85WnZowianqpXgBYpniKb/5M5yqxmKwb5L5FnZ3/P7ZlluGJ6KhJy/Ock18O2IXei0JvLO1q58ldqIDUB562/ZdpoGnqx9RKGuPvALWHX7qx1U/Q==;31:WYEM+3pF4S98n5XftO21+bZjrmbpi7R0UoThfCAWM5bvMA4R5XlvvgkannfsBt+869c4FkaWrAFFup8GQlVa6pTZJg34E3oZpWIF6iKNqWIkExJ11K8v9uRzIv80Ud2EPgwEagiVUkI5lArKkhPtTmT7uD2CJEJZSKP3+ZFVyqYHH8SRAAVvkOs7hJZ3XSOGluOCS/nbulFAEmjXYnvLz7cQjBPTZtlsCO0FDK0QIWk=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782E405F31EC6876891C681BCB30@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(108721460000369);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:3/jRKBvtdNu8+Qfr5EQyeN5YBQvifGrsdPEv8dPhStJtQfvbp+8/y6nZSphsZits8ZaxZ0aULHGt2vHXEAvpFrnNKxf5tLBX9phjOOVFxwL5OS5cV1z4Xj71YCBhExZSeaBNnPQ3EcIkEhnTDkqcxZCsD575uYjsgkUy7t5zaHiZI82wFulESJnJlGW3E9zrrF+JhFYaJeIxVUwtI8LY9MF2HHsxZxWZjjI99gVxzwQRE4vQuEstSGJL0/W7FzfDi/aCT53h1vi8BKZTpNTzhbDFnnPf9k67G4nc4b8FC0UxH4aAN8sBN0IwZ969kAHZ
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(39380400002)(396003)(376002)(366004)(346002)(199004)(189003)(956004)(11346002)(6116002)(476003)(8676002)(54906003)(386003)(2616005)(6506007)(36756003)(2351001)(81166006)(76176011)(316002)(16586007)(6666003)(86362001)(8936002)(6486002)(81156014)(446003)(74482002)(305945005)(6916009)(26005)(966005)(16526019)(186003)(5660300001)(50226002)(106356001)(7736002)(39060400002)(50466002)(6512007)(486006)(48376002)(2906002)(68736007)(53936002)(47776003)(4326008)(105586002)(25786009)(97736004)(2361001)(1076002)(3846002)(51416003)(66066001)(52116002)(478600001)(6306002)(2004002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:iVBJ56DXANiDxTQ29ozJWlJux58FQiqlZWDznEk?=
 =?us-ascii?Q?LVzr4pzpOnCoLvYEuX6K9jROO42DbjYDLLSTBGjgS7adDEFINn4KMCKC6fxR?=
 =?us-ascii?Q?JMeV9GnSHkWu01rpPfgUCE1rAL2FKJPBypgb9ZSt+DGSDa1i6UlLTxQEk90+?=
 =?us-ascii?Q?Zwh3DTWiU5ZgfeRREwIMKy6pPiYTCl5K4Hly9T2BINDCCf6+66L7/bFWkDf0?=
 =?us-ascii?Q?YzmgoG7uah8bCWdYqo21Xu6NjZQniajWnEzAZo8+xTwTrTxsJ25BZuqauCYr?=
 =?us-ascii?Q?Yl7lfNJA9f50CeArZQ+zCvvlsP6CuOArEArKorXjeAmEYka4l1HwPgeNUY57?=
 =?us-ascii?Q?zmZTKbkRJuTlo1VeJK2SdbrXmahO1S3xR+nntJLGZI6fq7Uk1xOtIoAltmch?=
 =?us-ascii?Q?iCuzEoQQjOfAQ9+m/1OC/s10ASC/JBfQqTPhpQsfuhx1tKaantjY3TMwUHdU?=
 =?us-ascii?Q?fQZBVPNn8QRQ8r1lRqrqTExSkgpwiYvlGKqEIYQdn/F9Cbhh9mhjx8XZHcK8?=
 =?us-ascii?Q?ig6lMwr1KW8mzpjJR7cMHDcjcsurQ/Mg01Vfoa+P95zhtVDk84tmMXtAaVDm?=
 =?us-ascii?Q?SKAej0oS9baMZUOsTk/AxZbp+X01EuqmfJlNR91HiR4Ppg72sUOQ/Nj71yHE?=
 =?us-ascii?Q?UNXWN/D3l/9NhsZvK8bMgyLfypcMaDyZGFf/37dg4B/JsTXakPwKPckXVw8Y?=
 =?us-ascii?Q?vT33krhdqp+IrXCsY6zIZHhZT/xjZOMqezZINYqkjAQiXedWvSqW7Eym+8oB?=
 =?us-ascii?Q?RCTKxxZdLsx/apY528QMdRpABHaX/ZGGUjSXCpVQDuevVhehS/nE3v+RlOWV?=
 =?us-ascii?Q?K3sG4XAkosJWQ8sMOXUQukMhKBCSymCIlHX/+XDAFRd3Mkr9+Raqnv5gi9Mc?=
 =?us-ascii?Q?QpqK2VDiXcvXdLTGlW04emRgDWOTxzxnMeoSFVjTH8a5bDDWXqK0ZIhmfeuR?=
 =?us-ascii?Q?bBBo/WNr5zR3IKKknlLFoqp7zRyFld09xGzUfy6MmuCKw8puh0r19KCfLSqa?=
 =?us-ascii?Q?2Hatq7xWj0tlMQIDBgQK24Jk8azdmK4QYB7b1/9Lm1ojne+2/pPpay0g/r5D?=
 =?us-ascii?Q?iV/aNjoU9c4fta0iSOKJ3UtlfquJ14NSZCGebqF6T+g5QybYN02zH/6KObOf?=
 =?us-ascii?Q?m+0PtuogSshkD6vWIwI/ZX/iKFhFu/1xCLL5pvXBLOF9u4ge8btEYpQYiVuW?=
 =?us-ascii?Q?aUmwvenNY5lBwydALMBWXjNDJeu17AgPU/X7XTUt0LNJA7tFcL4KBmMQSZLJ?=
 =?us-ascii?Q?Swte7Xl7gHixV+I3DQhbRzIgzJLtlUzTYkOBJrgAXoaIr8JuiadsgW2b8zO3?=
 =?us-ascii?Q?Ga0b9PBygVklLt8Ky54SU2sPD0K8Uut+Y9fqy2xcI9Ek8nV9XIxBJmgGvWf0?=
 =?us-ascii?Q?QVEgfdGIijNw3JLM2ws7Oo9+v7Qs=3D?=
X-Microsoft-Antispam-Message-Info: Cbp+iTDSp86BRzA+D2vCA7QIH2HjHMzKfB8qYOkn0IZFLPjtUxWSXX8Z556yNIHNjkPfe6TfUfXIq/Ff/ek4zDyrS5jCji9SllCfJCnCFKw8R/LUyiaqsGVduj+bCIO7WlRMMDagtgdZ/NEnpI9FG0QYV2ZNo4TXJMzs50kQ+vVUHLjdijjbq5HYsz8n2frI
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:5imSaf7/FVFnFtt2ZMJJTl2MgJTjCK8o282pSVvIVifZe/KKbA4l/hq0SO4vkwAqhRwQtyHynGFYlLGgLJO2YdAw3+HfXl/iD/JFi/vaQvRTC4ONoj1jWc1UHPTD74IvKsrinIZWvJ/W0AjARYtPLCBAAvvrsvmzqgFPIt8qIV4QYv8ef5LPGJjzOlcF0FCNkb1sq2z3VDXcY/SxO1JDaf/FSxLXb4r8bpa+Sy4U3RQCulK96VcuRVjm3JysDLL9cAh8/08qYVO5W4vZusmfsczc3RBh2pJY0+SXySd0BaRbGN/DGcKKyzr0EC9k/1dZnPsZJUeYIgMfGtjiVIz71APLPUgPw1JxKIKN0hoMi2GAlRy8UD2/jEFiYFPtCyuL7OuMXMqC8Mdaszu8jcdU269JN6cOmE4qEW0DfGMw3cC1uoAF3414LzeY/BlUmGu2WVJLnNkVCPcci6ugHc/ASA==;5:cwwnp7N+3zOv3KYrmJeH6ByEJw3fiLwO9Ss1sEAeRlI9KnCexjC3P7HFLeR59cI0dtuOkhack8M1D8VOQsQUwrbKn8tk2PSG/D8MG41brIa2VliOOonoUeG/M7AINTcpspDllAoTn14w7dr/g6MaiNI2GRMnxLvaCxFf/HMnl/I=;24:gEumt6wuVCQkvYeSRUkl3i7N9bE907Eq2jMowf+cRVCajG6UsHQSwlZl0C2liMWFEdSyQW21KaJU7x70m/Gaz+AHX9K9c7/AeG8KHMGNdUY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:hlUvc6DH2JHHIs+qoZOIoG+iTlF486ibRof48i8ghWum2xOJLZDQf9JjgycEkcPOBQWleaXkiWRHAY+CM48Bsq1cTDw/Vq3Tg3btSrOraFOPWOVrEfMdmA9TUH2poawJP3SFEsiul4DIV2UfAT/fqxt+fggJJyShoYsY0ZprU5fFDhh49VuEqW27kj8t9sACG/xE1dW5aweiGKBeMHsZmWm5QEGEFoVWWmJVGL7G/FSm49nBmXV9kg6f3H/Or3gs
X-MS-Office365-Filtering-Correlation-Id: 77486653-af68-4196-60bd-08d5a1346ebc
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 11:48:10.6316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77486653-af68-4196-60bd-08d5a1346ebc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's less overhead, clearer and generally neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/max9860.c | 31 +++++++++++--------------------
 sound/soc/codecs/max9860.h | 10 +---------
 2 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index 53448b7b7b28..00df9f4e4a23 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -1,23 +1,14 @@
-/*
- * Driver for the MAX9860 Mono Audio Voice Codec
- *
- * https://datasheets.maximintegrated.com/en/ds/MAX9860.pdf
- *
- * The driver does not support sidetone since the DVST register field is
- * backwards with the mute near the maximum level instead of the minimum.
- *
- * Author: Peter Rosin <peda@axentia.s>
- *         Copyright 2016 Axentia Technologies
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Driver for the MAX9860 Mono Audio Voice Codec
+//
+// https://datasheets.maximintegrated.com/en/ds/MAX9860.pdf
+//
+// The driver does not support sidetone since the DVST register field is
+// backwards with the mute near the maximum level instead of the minimum.
+//
+// Author: Peter Rosin <peda@axentia.s>
+//         Copyright 2016 Axentia Technologies
 
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/sound/soc/codecs/max9860.h b/sound/soc/codecs/max9860.h
index 22041bd67a7d..e07b905eaf50 100644
--- a/sound/soc/codecs/max9860.h
+++ b/sound/soc/codecs/max9860.h
@@ -1,17 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Driver for the MAX9860 Mono Audio Voice Codec
  *
  * Author: Peter Rosin <peda@axentia.s>
  *         Copyright 2016 Axentia Technologies
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
  */
 
 #ifndef _SND_SOC_MAX9860
-- 
2.11.0
