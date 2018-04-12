Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753651AbeDLVPd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:15:33 -0400
Received: from mail-eopbgr30121.outbound.protection.outlook.com ([40.107.3.121]:59928
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753105AbeDLVP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:15:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v2 4/5] ASoC: tfa9879: switch to SPDX license tag
Date: Thu, 12 Apr 2018 23:14:36 +0200
Message-Id: <20180412211437.21599-5-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:EyAgzIEVEFIAj3ZfsFBOgXrPA8zH5N7ywLBZhHMUOCqkPJe4yEBJ3sEirweFCZUpD+6JDhIz5GWjZeLwad7rFiKZUpkZ+yuoo9RtFoYhW+Py/J0o9uMzB9pMbkeJHjCFudEWMwVBelx0xrAFYnJ9FqNdh/+TIEIhQJ6+Jrc64Kr+cZtdGlDAVb4PrYXPOytorf3u1DPrLoVSQl6k4PeXHE6vnnMQmbR2kuPm5IS5JM22p2OkirXYDzSM7KrFM+P1;25:arnSn3+oz2OfGPLD3I8CNkY9R+39DxnF8ot26JjQ19UrszbVdsMJ3Pwjpuqclco4aFiOGGmxgrbHi/Kj2iFxeSkUinruvev9A80ov5/Yz7fpKpzLQJIVu3rNFoN2L9qqOLQmIGNZALlWJXIr/9cMV/biXlq3NDvrXvKw6Z51VdGtpFjpz0JxVdAGtlYhgsBgaejoEVd1zxVdWieLBU3a/2GWUuJpPZTAuGLpIIvG8tn6ekN302rJyNDeyJXXAWi19FYnQT+r8gd1eEyBT9xGbj47Qqivs/4TDaieqNMyW5NzKthEnNri1u7AcnZsx6FTCjoMHPGt6bl+1oVymQc/IQ==;31:kVH4vm7vPcOOLi/qPZYUXJB7lHrDSDQj2Fna1VjAgJf+E1OomX7a6JRFViFK3WHh4glAFyFh61hdV30dpGYuaNybTniOAULYA2q+bDQjXM7kwfDXcN6vsMohCCOOvBBX9kz74VTevaFNEM+At2scBem+fUQxlL4qp2vEMqwdS6gvGmjm9WpdzVKEh7Obi2uIWKpW0uoCGR9jqGi+lNsEtr/M9unZKiRUrO7ntDph7aw=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2770A12B63C34EDDE8C3A656BCBC0@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501327)(52105095)(10201501046)(93006095)(93001095)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:VbR0VdT6ubB89TLqezZpC3+XmKk38ZKTO82VFHd94DrB2ghIqGxbtsK58fgLmrHYhr0Nu01VkSWtvZ1bLn/fZ3EkP+rwPkQ/a4tifMHWFy062GVO2LJ414PKYHkXGYBORvngK0F0uyKYq8nPSLENnp02BM1XNxAChh/UgHPhqiDj0p0+tlbXC07AdDdtior9uY3yXtOX9lLEIuuwzikUyAt2bVsbw43zrkMu7a2+NBJBzODGDyfJ2uA7TO15wYXAciD5NxkEMcIAWab7NVWTUw==
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(39830400003)(376002)(189003)(199004)(97736004)(6916009)(2361001)(36756003)(2351001)(68736007)(6512007)(66066001)(86362001)(11346002)(2616005)(2906002)(6116002)(7736002)(6666003)(47776003)(478600001)(1076002)(476003)(486006)(956004)(446003)(26005)(575784001)(54906003)(3846002)(4326008)(8936002)(25786009)(6486002)(51416003)(39060400002)(186003)(316002)(386003)(53936002)(105586002)(74482002)(16526019)(16586007)(76176011)(106356001)(6506007)(50466002)(81166006)(5660300001)(52116002)(305945005)(81156014)(8676002)(50226002)(48376002)(2004002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2770;23:t97hvif8E6lAC7tAHa7OuqJqSgHvPj8/0Bpo4fS?=
 =?us-ascii?Q?eUS6IATNygMmj2cTMdKMn4NFtH8fxDXQ0IWTby8i6X9njEg0w/JwtsdB/XEL?=
 =?us-ascii?Q?GCb6wV2WgpWsV75FjC5GaLTi329GDJJ7UglxFVYdsiVHod19O3SUv+Drp38U?=
 =?us-ascii?Q?n5f8z4bZ5Jcdek4NGh/x+RSEz7hmYsTyMBINet861+nsInTpeIi470JBOorX?=
 =?us-ascii?Q?gOP1s5cuY77CQzDIbqpoTtaqWt+lDz2TucnX94/RvB7DVvlmo94qsmiBQVUU?=
 =?us-ascii?Q?tMpw5IJNp3oR+1iw16qC186T1y5jPj+gMh/qgcnVtagZfSawNR9MHTIayckr?=
 =?us-ascii?Q?cwd+ol7clUJWjr0wasdB6Nss0kQop5Y9mmKM4fxec6KUkf+V+sdDkxOayf4H?=
 =?us-ascii?Q?3hIpvOmRskA7clq8hgLijDxwFalqxJeFywACOWM1aw5FYOV9IQz3AJ36z027?=
 =?us-ascii?Q?tsSdoNQsml63aaxrmy1N+FGaJvthAw/YI/WwP5E1S9306fPDFoITy9wlv4zb?=
 =?us-ascii?Q?xhptg693AzsGMPFhZQI6ah37vaPtwxU0slO1J5g/K2+9U4a3xCL0DQudV+db?=
 =?us-ascii?Q?SAG0EKA2AZfGbYsY4E7kkAD8MGpG+bKx0fp6XKgEwFUfjTw1Np9vL/otqsv2?=
 =?us-ascii?Q?Mdqc3UkXMr1MhKNL6GGIsgGPyZE/KY/oBI7qEvcPbtOXPyXrlm0f3fj5CFGR?=
 =?us-ascii?Q?eOUrAZ5prUou7ZIIo5u5SIRpwaurRBTz1wSV5NhFSNo1hf2JdEu5s5VibGHd?=
 =?us-ascii?Q?sHgcQhPTRNItSkoXuw0JDdpgtVZ/DHsTLCr3CCwbUx6HO2FdRBrfAQY+IdWI?=
 =?us-ascii?Q?DeuR42AshQ+Baxdy5U0T9tIPBpLaFUGs6pQRr4KIXgvc9zRCFTRITK71WMfs?=
 =?us-ascii?Q?4AZ2kFDRKFszbzo8DwaXszeT51veOk8hFJm6RIH0qu/LZNw18Fl05LV07gMY?=
 =?us-ascii?Q?l8hW/kCWhszRgchntmjxNKdhuZR3PFLIq2/3K8LZWVA61VBIlCIuS2Fk4k9T?=
 =?us-ascii?Q?mxnkLeRDSfBURX5ziPgSmS/fFBhDrsaAc0bmOGxWHpb0+BArTEOtzYuo9AMQ?=
 =?us-ascii?Q?gt0GdYKf9EslkosqWePKx8+2f+PSp2Ox5xJ4czIwd3YQRm4eaX69Ni0G26gL?=
 =?us-ascii?Q?l0jBkoCPjpB0YmgbTRkDW7ZCuRIVxZD8wD6lJ1QKbSiIQaLGCddMQFf+pH4C?=
 =?us-ascii?Q?5WtffyMpw/dezAxuI7vidQsZkzcjcUEd0mLRkNS/Wr5tiT4hKy5RMklK07d2?=
 =?us-ascii?Q?YdFYqtcl+7fIVcbOhYLO9MhgPzFTF4Bsn6nPPmBy//0pIOJtY4yqR7+nUSYZ?=
 =?us-ascii?Q?jaCNW0bjgWJC3d78SFaNc+blLlKTWuWfSIpykeyYcMCmPN9/ViPRFwX/QSpU?=
 =?us-ascii?Q?M6qhUzbRVwCYXxyO0eQYUB/QceFo=3D?=
X-Microsoft-Antispam-Message-Info: /n0k02ajz9w4dy3nzpGGyf/yGTQwu6AaBROGDMuX5doruPZeCxbhjExbCtJF2hbrwR9s0kFry8Y6FovNH9cb0h8pTlVGvnMobY0zfp/OjCK10sqc2F8ARrdb19+UXO8aL761C/kJZuU7GRRTMSdCAfUax+4V3SLWGrlxfqDOVAjE/Adbb5MDeUItR/YcYeNJ
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:2SNjTvmM7r6W9lk0tdEoeFXr9+GKcTHS0bh41JhmVlNdEp3MAFpGM48LoSNoKhuC9oEQWmoNLCj6Fta6ZF/+OCKnxy9IemQR/eMFOz6MEzt61TYmgoj5libErbVzc99kyn858T8Dow7cTAc90/YRrdER8Y0WzvNHxiN4cBDl1Si9u+TE7ZHYtqQ6xBh0d0L0miePSsmZrq6ZGa3FfisRGkTQlEd0rIhkV9qDgA7MgrKuJfjiZbEWXnTOw90tfoB6j5aGkXuf1bK0vftWC7hMlGThl+TOm9QGFA0uxm+Gz6JnxAzdC+MkjPoJzsyXkp37iW8qli0/KmEazECzril8RzncIXQ9AdAtR54SK8YBN1aS8xOb+ThZdTtxhMToSRqCbqon51mxCs+DbxpuUzUme4DNyG3WsoC6t7oMaynFmevEiTLz68vXjsY2sdhhRfiTmkNwNh4qyYTzSySx199cOg==;5:tqTuj9THrpqqxenK0ruwqRPjQoj9vfXjfqjroKFZlKRzJzum958WAyHKeJ5Oh8s0x7hziP2tZmCJR87XIbFDnnBhiyUl4y3Cxa1PMl5cqN3qDCV6PX/FiiyZRFDm6W5p9HZB1U5GHekInq0kZSbVHJwPaF7AO9uHrwI+40YskZw=;24:/n6osq0ldiOjewDS6ioojhsbGy6VprHCqi064rxDxuk4aOmMs5RHanohIR/m5OjoTKVd4vi8WGCXNzHcaxb7XJLCKj6SAsaAXkZN7nTOf8A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:u5V971SGeBCwv7rQs1TMMW3o9pg1p4q0RcHv8offHr5m4+RYO/z4johX9IKIuviP+3Z+cyh8LzkEr5cUSteuwo50Uvac4gggWQBUwimx1g7hf0SiW9e1Aywn7XN1M8smORJ3kv+rFKpll35Hl/Q3CzAhL+zIohemzegEi66mGxoukyNS5r/KLmr87WrMJ8JN3uJlq1QAjb4afGz395FIJUjUY5CE5iNVpi7c6s6aM8K5xRDLrRgFiR7IjbqoJfEt
X-MS-Office365-Filtering-Correlation-Id: 7ebfa766-37a7-45bc-f8e7-08d5a0ba830a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 21:15:26.0845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebfa766-37a7-45bc-f8e7-08d5a0ba830a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's less overhead, clearer and generally neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/tfa9879.c | 7 +------
 sound/soc/codecs/tfa9879.h | 7 +------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index c30e0efdbe39..4d9b3f393808 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -1,14 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * tfa9879.c  --  driver for NXP Semiconductors TFA9879
  *
  * Copyright (C) 2014 Axentia Technologies AB
  * Author: Peter Rosin <peda@axentia.se>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
  */
 
 #include <linux/module.h>
diff --git a/sound/soc/codecs/tfa9879.h b/sound/soc/codecs/tfa9879.h
index 3408c90c4628..66c88d0396fe 100644
--- a/sound/soc/codecs/tfa9879.h
+++ b/sound/soc/codecs/tfa9879.h
@@ -1,14 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * tfa9879.h  --  driver for NXP Semiconductors TFA9879
  *
  * Copyright (C) 2014 Axentia Technologies AB
  * Author: Peter Rosin <peda@axentia.se>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
  */
 
 #ifndef _TFA9879_H
-- 
2.11.0
