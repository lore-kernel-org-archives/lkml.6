Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753592AbeDLVP2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:15:28 -0400
Received: from mail-eopbgr30133.outbound.protection.outlook.com ([40.107.3.133]:26696
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753105AbeDLVPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:15:23 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v2 3/5] ASoC: max9860: switch to SPDX license tag
Date: Thu, 12 Apr 2018 23:14:35 +0200
Message-Id: <20180412211437.21599-4-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180412211437.21599-1-peda@axentia.se>
References: <20180412161601.GI9929@sirena.org.uk>
 <20180412211437.21599-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR02CA0105.eurprd02.prod.outlook.com
 (2603:10a6:7:29::34) To AM4PR0202MB2770.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:+pW3+L4L2cLcfFPpCqu9Nfmt7DtxhsYMR8Ykf2EAeKXX3PD5yA9EVppFAxclChZm70kD5ybU9y6muZY1JNP7GzraLzpd7AZMwpVoLIe1MuTcVDctrwf3/HTJEJcywZENj6xlkF/32HVWcLVoTlfx/ugv8en/63t86jMwGvGfBceXLfHjURRhY/AiQ3xgaHFcvqhdiAr7C7FGGp4rxLXXP3ilIJDMan9QlX3ZAY/geDF+fnnDMp8TWNegcfhMLhgT;25:uf/lfXPChWehbXbrqELBlsZ1edMH5vpG+GCGGX0Pm76kYqhYmIBt4Dbw4pF0ZllvLfdU4HvZNi0ywMrV1zgZ6gsJ+XTAy7BhqlJqoRIjwiWdkas+mpaKnUhlQOj26Evb37ph/MADOSnl+eqw5WCqYjDn/kdoYIsg0+bywAQSX2Iqinl/wi30UkwPD2K5Ngs0RotkifeNnO1t42dStYHvwWy2u4WmnHVHhCil9EGlRfnW+3CfW/l+6Is89XjzxJsgIhgyy4VRJQRt3X0oCu/moKh2qw0LGCn4hqoCnlWk+veLV3ASdRU+hnNqlWFkT7PcPlHD5cV4kjKKZ6zYpinQ9A==;31:X7LFWTt20GqdN8GuXvVqz49raTVCn6Q7wrsWpffrgOUI88koO8iskIec6lvHBmub4qtZr5tMLX+W9c1ypMsYDZC4zQYLRxn/T2D11MnoD86ktJqPE7uz/b1X8NWcmwYG+QKB65uqI2vcDpltjTUmysM192QYra+g34M/RzaRn3yzDe9zzFZNJAgx83RyGt0EUM+Q+o92Jf0+QqF54FXLKZXokD5oU0weYlmp9KJjeEM=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27701904CA71CCA48971E56ABCBC0@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501327)(52105095)(10201501046)(93006095)(93001095)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:gGJz70pT4mssi9NgCGHBRR6sT8L/7IPNx/dFGVoGXjWeE/a0ElL2uW2Y7wDbG+cbrFELbUIqXQokut/rNS/LsIyevGsLXtnv9UlhXl9UREtZXAkcuSu+N23iFXFyEyZQOaNJWlmz14RE6V+ASKjNeBQW2kxnc+0juyARSdTJFFfcF5BSPkoun+UvxAqo1y/ZtQNXhvYUwPhq6Zt8LCQu+qtGLfLXsdMGGrl0mTMRGr9jOKhhUhRyTvfRgbuosxU5Bm+FYOB3s6OU/eyX6UoL+w==
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(39830400003)(376002)(189003)(199004)(97736004)(6916009)(2361001)(36756003)(2351001)(68736007)(6512007)(66066001)(86362001)(11346002)(2616005)(2906002)(6116002)(7736002)(6666003)(47776003)(478600001)(1076002)(476003)(486006)(956004)(446003)(26005)(54906003)(3846002)(4326008)(8936002)(25786009)(6486002)(51416003)(39060400002)(186003)(316002)(386003)(53936002)(105586002)(74482002)(16526019)(16586007)(76176011)(106356001)(6506007)(50466002)(81166006)(5660300001)(52116002)(305945005)(81156014)(8676002)(50226002)(48376002)(2004002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2770;23:t2wwr4I79OfiKtXGyTJ09DnJKnsoRnOB7oZW/0U?=
 =?us-ascii?Q?ygNF+1LygsCfIErHkLlG/V7dvNypeq12jjt6dboiOc9Fohe3clYqSWbJzptg?=
 =?us-ascii?Q?6ySviJEP/3W8Zo2qfLDteKeTVPeGGGqkytjFgZ7PZk8oH3MT9OgsCAeuogyg?=
 =?us-ascii?Q?tjKnDs7qSdlwlhEYq33tl2aK5mbij3ZjdbV8Bak9Vo4s1iGDRWeXV/dPPkCB?=
 =?us-ascii?Q?0NeENSeBLICU28biok8wwgjmTD7ukbkIxVDkPYsXL2hccjFyidVoLZ7pnAE0?=
 =?us-ascii?Q?t0Aw8e0FRDZl/QX1eqe6NL68jDRixWDo4K8g2negyUA0Sm2PiMzdjRdJ/9oI?=
 =?us-ascii?Q?3wV6/yRhRMk+v+0K5R1aSwpg4524UcJdj6IyLKTbzkdR+OitJJkatNdbJD75?=
 =?us-ascii?Q?Xi9n4s2gl6eKML0RKKE02VL4Q08oLgRMyJUUF8Hd/m0U1PP+zfMMTqeT3MY7?=
 =?us-ascii?Q?75HOpRXopefrVUjZAylkG8QA87fhEEMz5XfLsVset5c2xbphPR9zS0Ox1wIw?=
 =?us-ascii?Q?Uy/J7rkTmm2P31Y5r177AtLbRpc1q+C4wUN/mvKWkNOn7vSy/QmgLQKiLyDs?=
 =?us-ascii?Q?k3+yx7IhNH2H5nZARkcQbazNwKyvCEqitc75AhLlJiAtgI1mrTMSvjOMkrt0?=
 =?us-ascii?Q?iCuW8B1c0ybn7ftSrOpN1HhyrW8T7SdCZbHJKs83aw754wpVd1CzOaQKUOQp?=
 =?us-ascii?Q?eZbTLvsrUjICfrmtevqqvloEgZ8fxEwF5wI5O8u0IfXuGTrEFYDDsR2i98va?=
 =?us-ascii?Q?Y2VH94xIXz5KCOmt2wmmSzxkj+AJPpfBS+iJDXxG+s+nFAytJvHzpz3BZcnd?=
 =?us-ascii?Q?Y5ZfBg9MhD8vHMjMeBygArf78yQT/NyspG5/JKXOo1JZoq8GSfkiyZOaTDVT?=
 =?us-ascii?Q?uSY/mZr83Bl4BWbmfsJYACc+Ot2fEzFdPdmdxjp7mVnFJrdkm2w43HLJ56UM?=
 =?us-ascii?Q?Kvdlgxwis5/1W2Y/pSdF4vVazVHJE+FsMIDArTbh4uic5bEabKCi8zhAaRZI?=
 =?us-ascii?Q?V7+KApumNZn0IKIYGv7wC/3h8k6KKpleYPykk2lzuKR9/yLzb8wzOfvmVyi+?=
 =?us-ascii?Q?cX/MpiLJV6KFKg7h0yAJT8ysBZDq7DjvCMsZ1/aeNOt6qIuKzgif48Q+uIpl?=
 =?us-ascii?Q?nJtg4QMG5e6rILLoZ9rBi/4OcY6niaIMaUNrA9dLvtMJGBpsYWI7C3j+eAYf?=
 =?us-ascii?Q?qPiQLlptzNJ3WjSa2NlMJGSGII/oLVQHpe0flrLkCu4xRLeLKY5/dWCdhAD3?=
 =?us-ascii?Q?aNZfbYe7iiOBXy+6ciKWWhTYlfk7+0idCSLq5gKnF/fKcCsN+Juw0n8h5R+/?=
 =?us-ascii?Q?ns0OgVUqyHeXO1hX9A2ejU27ZscGe+2hpC+xlN0xN2Der?=
X-Microsoft-Antispam-Message-Info: yyCPAscPabRLRLMo9wUq+wDBEhBgBqgiPgxP95y/xub6EQoZaPBMae2Hz1im9QIIYfOxBDdOs++r7tmupC4OeMTBIMvrboAqH74kVK07zj4hYl0AG4ahGLayZZ3bRR18sTBGcp5ELU8fnppmIFKDZJsVsMLhu0PI0TrqbKF4AVel7/YbojlqTYaP1EYL/vC8
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:xnsLcWjuEfnMOqhu1M1QTJPbs/RhnKUn5Q885ltw+ZaJEVOf1aIeMIQDNeMElC/c9tBHsP96eTpQCzzw6FO49dkFJj/TH8YsLUl2XSlKXse8v08vVI53SAgKBrWl9Dmb91DfZCdLibaIQA5bu3x0XX6zC5I/PxUVApLx53nCnlSBmSvHFDiKg/jTsNHrv4iUzUGGG5RZjWr2EdHl4AX8ICdRYnjTnam/wL0Y1ZVKb9TgrsErvNPE5djHCUT5+EixH9CKy9OB6AxCBQ5zxXhikIC6UA7tW0FIFzV6/eE8TuGQ4atOuYOGCagI3aD8vQGzy0CTouBkrAS/zyLWoJYe4witJfoZrLSITF41SqI8cXUmKzU9dqbV2n9COe1ICw2jZX+YOBHFWnqzenLohGeCHGYowZNxPnmaomWfIsGOENbH6a4PVxdfdxfBJXnieFsmjy/SJEycSwuOpdfW+DXPzQ==;5:FbrS8vZXX80kxPIT/tA88J/C5zZyzftIJrA/cIN2iZEqblbBwp370ENj0NrOhEcrIAsBDGcGAwClkGy2WOAc73sk55IYJVlivGUeJqN2+lHHrVLziYAUXBOpCjt/oFfhh8PmUGzubRrdAPgB9LqA4S/7CWVmEG5CQtgIWEbGv3o=;24:2O6JTfOZ4SJPyoWZqNA9zcy6IBgOXHvnatr9GaRhcf7u3sGVWwqRIvyduC65rn7CVieUHiBJHoBrH4nVv4BheXhdjdHAxKmYKahqE0tiYSk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:BTYDBKwFaBPRD0VwKmCaOECj33yxhQiOsWSrsybDbzpRp4tk/tb9R+gbiNZ/NA1B+UNDwCx/4AhdT7MRlzrDQ69hY9qrrylOGjLGR9EeLX1dT3jc61X8ABp8+JFfoyfu3RoJ7I05S4Qglm4czAJz6G+4eLTQt0qDzgx2SlWECq2IBsvpd4b+J45ShWn4KM3iFDP9UZ98TrOYd91mw9FR3Ugxjb7G6/zVRfFj6QN3crfkkTIKZYvIoJDQCABrnndL
X-MS-Office365-Filtering-Correlation-Id: eaaa0e84-ee02-4ac3-9184-08d5a0ba8038
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 21:15:21.3501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaaa0e84-ee02-4ac3-9184-08d5a0ba8038
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's less overhead, clearer and generally neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/max9860.c | 10 +---------
 sound/soc/codecs/max9860.h | 10 +---------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index 53448b7b7b28..21c70cd5dcf6 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for the MAX9860 Mono Audio Voice Codec
  *
@@ -8,15 +9,6 @@
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
 
 #include <linux/init.h>
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
