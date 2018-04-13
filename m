Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754819AbeDMLsW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:48:22 -0400
Received: from mail-db5eur01on0109.outbound.protection.outlook.com ([104.47.2.109]:45246
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754800AbeDMLsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:48:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v3 2/2] ASoC: tfa9879: switch to SPDX license tag
Date: Fri, 13 Apr 2018 13:47:51 +0200
Message-Id: <20180413114751.6464-3-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:kImIL3OgT5Q6buotWpTh6qLay+lG4+fE6U38Ib8/cOLon3zRke2HLdTxrZKYPGpC0cIznoNw9gnu9MYfSt7jEyW8lNR920q9f7ZCQrlW2Q7V70SXgOhBxQvB/nrIK/WaQoMt1q6u4PpJkDyzPVetj1ObYuVUIV5AG8dyhTCzZTnmP5eKGAz45UpE94ywUfKTPTsI6d/gPZPouhwWhTWFbYCadX3YcJDzA/pe4f0SnbMRReotVo4Lrj08TpZZOAN1;25:a29ebFWE2MebeqAmHRK8z0yQB/MnjboElvfvKmnfwtlNBVWJsjgwSjIPQ4BadzU4N1Ftcvjc+avi6hMkyqPOBT98ArOPmK5VvYF+koKHugUuDB1XBBZsXx22fh35+y/Cky4nnjF+ATmU+W4Zyua0pWvgTZeryTUIPSc7jOqE3kiC/T6XdfQoJ/qHw2bTU91EwL4rrdDpSpFD/bF4+3AJE32NQHyidEY/XRo2sMjJjt7V+XtEN2cltS2ntWU9sgpcPo2VVYYmcEeg9nmHPgraAgjCBDVRNS+Okl2nukEQdSm95HmDTgDH8ql98fywJVvW/39XWdzi4oYHRcxky451qA==;31:ImyAsfFtLHl+DwP9U/9j8x/Qw328ml9D0r5YZPCta1Rbe2jnGxICBGL3wfBJix91V8dfn7GrSStb87MzjzrcFgD1p++Ddhbotgb5XkkDkIz+QvAdV6eSUeiPRcLS6zjKy5jKaTHIwqDGRzydE8jmUlCneBbdVZs0sZKjQ5XHrHCgPtSMZF8n+0UNSgHxJ2tlxgw3d7Y/rIe7u+9XuUiqLwTm6cn8u2Z84w76YhSQIuY=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782EF1E8D9197166DE26EA8BCB30@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:lsr3vU4K6u9d4yO+dTu6TS5lg970T5LUsUtUvXaSwkbh3H8BXJ/tTWOGL5j/l7oy11701K+cT1/NnSpQM5p3tOX7SmL6YHp22Gl4suE/2VaanzN7/nABHQTxhnwEljrVijT2bJDu1qAByfHBIgQe/yEoERr8U314kF1XJYMHe2Vl1IyB/2L08ty4HpFWcEqxrSe8mfzbsD2PYCwEXwfXHnLpZHTMPVkQ8TWDlOWJlvZvyqfL8EmFIXp9TmHruadj5DmYmJcPShdrFyKszGM82g==
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39830400003)(39380400002)(396003)(376002)(366004)(346002)(199004)(189003)(956004)(11346002)(6116002)(476003)(8676002)(54906003)(386003)(2616005)(6506007)(36756003)(2351001)(81166006)(76176011)(316002)(16586007)(6666003)(86362001)(8936002)(6486002)(81156014)(446003)(74482002)(305945005)(6916009)(26005)(16526019)(186003)(5660300001)(50226002)(106356001)(7736002)(39060400002)(50466002)(6512007)(486006)(48376002)(2906002)(68736007)(53936002)(47776003)(4326008)(105586002)(25786009)(97736004)(2361001)(1076002)(3846002)(51416003)(66066001)(52116002)(478600001)(2004002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:MyyWriMv/v3USastL2fveYyRWXFSjUf9fc5DrcN?=
 =?us-ascii?Q?p51YmpZ0JYmlwUEn+7ziqgzrViKQeizwisNgXYzWrZcHCnQbzvxe0mSWBOjJ?=
 =?us-ascii?Q?uSS05ED6Qg39QxPfV5MQaqmdlZOkPbKiqs305NvJFB+mErNVt+F0x2Ix48H9?=
 =?us-ascii?Q?Av7bCVZnMycw2DPLJR1MmNnfN+lB9j7LCwOFsJ3tySHvyC1Jtsz4mMtuWvsK?=
 =?us-ascii?Q?HoZZOkJDHl9hR8ktwJKGqyvahPRyHNV9x4Yw1pyiNw4MetbQfRr32UySOqfS?=
 =?us-ascii?Q?z5PAe179KLPNcxhroMbZ8jvR1RQKKngcX1uFRZUdA8UAZANqVBeb0u9loPM7?=
 =?us-ascii?Q?cB0svNNOgZIwadJzvqRW11DGFeGdhmRrHdVn07kOAiffCeJpS9llD8E2E02v?=
 =?us-ascii?Q?aBlJzDlDrToMRrYY/NgoFkBJVTE+tWcKwns7FRail2Bh6VWDFlPbQWf2yE4W?=
 =?us-ascii?Q?OGY7pOwCGFqeE2cN7BQBYYEaPkBYM7xaPnNoMbq//6CKBbO3Z2iTTrj9BeOo?=
 =?us-ascii?Q?uanC3B+8NpSuG9pGZrzd2QCKs0tG/Tdjd+kU7u2a6a5bqC+woHDWLz0IHF11?=
 =?us-ascii?Q?dY06RDK0ZmbPfeNjx0nuHPbYYdkCG/4stkZhuFR5Gv3VfBNyIy/xN7skfMdQ?=
 =?us-ascii?Q?swMtoK9Js3x2lApMzjjxc7GyPrxWzZiu6cb9c60K8B8/2dqNWM1OFdC7YL58?=
 =?us-ascii?Q?+u6Mti8EHAkvexnC6BFyKMB6Np9Zg0WnQpu3gR0hFt+GTBHAeQl1x9U7zHJp?=
 =?us-ascii?Q?j2VP4lYt1xLpqYbnrVFPgEoERukzDaNCLy1lPZquZhhRlzhfpfmYIfQwXJaw?=
 =?us-ascii?Q?XACEo0RjNxfJ711xny4iwyHMQdlfEbgPkzONkRtO1ZIMSP2w1l4222IzPMUl?=
 =?us-ascii?Q?A1NLd38qoHJzYsRRqSjM9kYV5B4aTditd7+31EIJrAxPRr4iWuobzZjKGDE8?=
 =?us-ascii?Q?sVaZnR8+M0ZaXmldO6peH+NBCj6unsPi+462KxlHo3sxDWNWyJsiHrbxb+xs?=
 =?us-ascii?Q?1H9i8eWX4JxkoWtgwtg7IcrfAPq9NwqKoP0JjOTQgexkb2/GF235TVfii9m/?=
 =?us-ascii?Q?KaJye6yrqFMY7TgFUZuMz3g/hk294uOQdukp2pYIvGU9wWa6YRf74TQzO7uI?=
 =?us-ascii?Q?xZ6h1p0gUsf2luRuu/JCTzjnSdx7BdIEA1Jas/ubJ0BijQV+c9rgHmL9+cxk?=
 =?us-ascii?Q?mKA0sDwE0SIszGySO3PHR/flbA5IN73dBFflIIyi7lPxMgo94WS36+GQDOJM?=
 =?us-ascii?Q?wfszx3Q9RqkxXVghiSDTUuTlm2/Mxone0XSdjLP8TwrwqUzsahwvQm8fFPdZ?=
 =?us-ascii?Q?3BKZh+oMgyMY+KpcTU79TPAzIYWFDj/iGO38GOAIchBLS?=
X-Microsoft-Antispam-Message-Info: FPBluSTWY/ZwZshYCn8c/WzXbZDDqKMeOv7gFajK5RdqNNpCVtAMGqQo6mW1tExS8fs15mFWsP+S6FHt2URkWwoc2GWlFcGkoFcVF17O9X7yzgLohVuW18Z64sOy6MXlh8N6MglpEM8+jahXJiT0VnWYimflf1efVucKt4zP8rNZnXGMjhGUOBy3LhTQ+8YF
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:AnOksTtOtxpCEn+6GBvjZ19DkDuBZrS9h1yuXn6Yb7I44/j+jNofu8W63pEQ1IDcRZOEuKCA0r33D2g6oKle09wr6fwLZ9C7/MN4ErwD4/bbuq8kvd5zzJTUklSPUZHfIc+3hpTAl3vndAHgGLo2mIMV9Q9RnxzYdsXlDQdceHjA6aQ3Yg3XWP9I0O2tc9ZumUOXWWF3CrvhG5d2rjtGX5nr416Q5zkp84//O/7lGlKatOnTLBRRmyQCpfKn2Qf2/UMlODcPI05U6VimzTcjQP4fkIzph2uCjDVJqEeuvw6wchztdcsCf7rqWEFqnYWnGzlTPcutYw9Z2FS5R8jiViIru7Z1Ap/EYzt5/y5VPeJr8VAXTEMqVFVZzInElsf2T0X2lSFqcuN6F5oCUCHRAl2jUEajY+q7urOhetc3YBofl4FXVMRdeWFJ2IXQujrCtjgOoRqYzJ6Qz5w8EUVZPg==;5:xgNvQUnj65A/bI3b5pQ3hvVgUAJ0LR0cwD7zZjokEAlmoOc0MPrMWn4EpcKzX+qIPEbDfKHPDJ2Fu1nHMGBUfB742eKvhSPFXi0vWS6x3n4z/xdjHikm+FdeX0mTwxD450HIs3lCKcytIvmIHk9/LoK2UB1KVfNqRMm0EzqioC8=;24:V+UYyN7Wo/90ZocgDn3dP7vg6WpMwJFF8PwXpqRjQlqtHLhCwDhd1VPgwPP703uTUwAjuqujhzJkRYcbChSL208R3YeRgVNz31/YfwZ2qhg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:Z+08wIU+29ZZIGsipKvY+7xfdZdx/QMs8Fz1SkdHnBLaNUingmRHaTWLmy5/qBYzowneSEqARhEN+D4dCkjCtlIHt883TBCOeT9sz5f2v2nWji6O2XQGWcs58XeOLxMTFI51br05kt55zhVkMg8fl0phNE28/PEs4p90RTQiM8Gie9jT6r7hOPDEvA6DyjOq3YPKXExvtYBnYYnxFeMzl5FvnN3tz8a8XVh3Dl/YQR/o9z7I21MVh98NzyFdynsG
X-MS-Office365-Filtering-Correlation-Id: de83af9f-8ed8-48db-e7dd-08d5a134726e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 11:48:16.8347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de83af9f-8ed8-48db-e7dd-08d5a134726e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's less overhead, clearer and generally neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/tfa9879.c | 18 ++++++------------
 sound/soc/codecs/tfa9879.h |  7 +------
 2 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index 4ed020262a27..abc114a3ae2b 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -1,15 +1,9 @@
-/*
- * tfa9879.c  --  driver for NXP Semiconductors TFA9879
- *
- * Copyright (C) 2014 Axentia Technologies AB
- * Author: Peter Rosin <peda@axentia.se>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// tfa9879.c  --  driver for NXP Semiconductors TFA9879
+//
+// Copyright (C) 2014 Axentia Technologies AB
+// Author: Peter Rosin <peda@axentia.se>
 
 #include <linux/module.h>
 #include <linux/init.h>
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
