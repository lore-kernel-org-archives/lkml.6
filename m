Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbeEPIFf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:05:35 -0400
Received: from mail-bl2nam02on0086.outbound.protection.outlook.com ([104.47.38.86]:50112
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751319AbeEPIFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:05:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Wed, 16 May 2018 16:04:29 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: berlin: switch to SPDX license identifier
Message-ID: <20180516160429.6581d443@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR04CA0020.apcprd04.prod.outlook.com
 (2603:1096:404:15::32) To DM5PR03MB2636.namprd03.prod.outlook.com
 (2603:10b6:3:43::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2636;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;3:Iq31OoUhqoG/N6fP3j3ArxKws+y0R51Bx6kcnkGGhOzbgdewRMs0H1MyFRSKmZWsmj9X1z4xmM0XVcpqJuX3R4WnZm2ICPtN3bjdITXHO9cX7xw/bbH2HqLgurH+1RhMNmRe+RrdOid4A6JtArmRRi2YSlW8M2ozWSkUoc7a1xVi98w/HUE+m2W22XYvYaMdFvLdhJ8Df3aVEHEU3lc1oDa4/BQS0hg3Gn/aRofuv4uHZW8jYN4SDCt1/LKUwhoN;25:qtMyg6sHE0JTCI65bwAdU9OUGuVL21eA5e4+VdUVcBE3HDW/QuEvORc8JNwtUnXPwLNmbSUwDLf3e6JoPq+Ka4RnRpNyDJMOPbz04S/5Z6+Eyzs3Xe9DpMV6YJ4z+PwDPXT9lHffmhwiMguo8Re8k9tpaUseRw5lVvCom/rPjm7Kv7H/d6j9bxjm0PI1YHSyE+xGh8BGygmMNpZjTrw1N86ZQh2nAO5qeSETuiKiYXX7TtR33nWcZE81IVsVcB9BaT2v/nv3iqw1YbKrCHhUfojscFJaQDFpP7JKtDHJiZ3/TBYp37LeZTdphnNkVsDn4kaQ/qfHIRfPYYMYnYZq8Q==;31:bnI1YFkwZTh9OEaqRBI2mEo+7cqPFI0j218n1mJfUGyD/XyI0syZxMRsQZOBKo1KpytGwBrcEs3hmAxsrLxYWI+ZrKT76oaWxvRnEnPG4w8GU95VvRShQ6fFXe65YeHaoAGmnO3RTVRLbC9ejkh8SVh/tv6A4sGQoYQ6YUS6bCocQCShHenfvc1m/rQ5H7O+6/yJYKl2ijRppJOLYmPJ2GBXE9+rYogaUOzhJ3ZwJlg=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2636:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;20:qp9gC6kJyWecH0a7Dj9OgNbNLbRTxV6kv6+xFt6Kwm2HE9G4Mk6drEICY5xy+VY4sMIoaRVmGbm5db0AWvuNHPafb6hBcfFwzxZbONQRJ8gRNEgJR7ooiOzbtKEEMMi05cqtqhhBKDNnOZRQzJpQSguBPJROxa1RNbR3b6hujwiontS311R3bTc/yR5vuflWkFSFPx1NGv8Jis/w8GeOO0Gr0nRxN/W8ch5ABqDHubhiSfSfflA0DX2rGJZt4fFJurJbQMT6VSTotX7blBBpLwcak4hLskph/jTsoolVsMYMm3ewYJ2A7c76h6OfU+n7WUDz24YYUslBZLWjMe7ZAKNnpci5eveTC6yKs4kRmN9/4+ze1H4Nm3IJz+UyHVIFXjpsI5UE+TLJiO+EnRDMM3x5bx6oJDAgkue7O7KPcEqqet2NyKXpcDxWjH5a+Sekm7BcFypdRt77BctVM4cYThSCD8S2YTWYoeCQ6AzxsFzoJkgGvaetgTvFa5sIIMKv;4:oFoU2Aun1IqlBtwISWQoyNiMuiP12/RF7l31IE8S9GVsmb+LRRVuCldNKdXd+XaMMPiGZ069P7BAQyyqKRj8FAgKVr3cTBSNySa+cIMUctJNzqpiv1wtKFF7gQVXQtmfSsYP8O+6HOcenFJ9RJONDedOlapBSpzs8ohhCM7kUd+KJCtW8EqzHLKW7vRdZRtHwznNkAJds43VmoxXDcakS0dstEY+TbzzpbfuwmyNRHZ/1cL5DC9WZFO/pQ+qvTrX7Z7lIspH7HrchxMnvJnOy2hbexa0wovJCIyj6S5yE/AR4UY3nOFzd66j15DdfzsSGAWi37RT7e+R+lXBpUQ4AClGXDkcGFAHuWCuhsF8EOGECJoen2LhxLwvwf++sSL7eNT+deS6ADgGjfTB+E2N3WwCioRkrxxZmNKKzNayAAc=
X-Microsoft-Antispam-PRVS: <DM5PR03MB26367B33266922E6C77C55DAED920@DM5PR03MB2636.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030)(85827821059158)(58145275503218);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR03MB2636;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2636;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39380400002)(39860400002)(366004)(189003)(199004)(5660300001)(86362001)(16526019)(186003)(575784001)(55016002)(6666003)(8676002)(53936002)(6306002)(9686003)(81156014)(81166006)(97736004)(68736007)(105586002)(106356001)(1857600001)(26005)(2906002)(4326008)(110136005)(476003)(47776003)(486006)(72206003)(478600001)(956004)(230700001)(25786009)(66066001)(8936002)(50226002)(305945005)(23726003)(52116002)(6506007)(33896004)(50466002)(7696005)(7736002)(6116002)(3846002)(1076002)(386003)(316002)(2004002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2636;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2636;23:wuSJCyBiR8QkfT0WzFkBLr8OVwwOehTXwjwDM9N3V?=
 =?us-ascii?Q?ltQ11pc3Qclht1R8TA1u0KnKcdmoxr5EcN8Z0qedcNifAo9DZMaFvhrahFEU?=
 =?us-ascii?Q?H2Af3b8uoKvYzWtGHYuH/Xlk3CqaevSK9FUTGtla5bF3a9rctp5lzeiXK3EF?=
 =?us-ascii?Q?pbl3nhVE31VJyfZaUUFQffSajxprPb8YEVaYbnA+ekV0T584+PKdG5QJFMSS?=
 =?us-ascii?Q?Kh+HKi6McHu+GV8rrZPmBP/ZqJqVqrvNakQVJiSF+wrT2CIsS4EJ5H+fUAWB?=
 =?us-ascii?Q?HcNyQKUBu1Sy+3lurwaSreGse5Qy9iZtqA945q/2GetnJF/B9RFhN76rws87?=
 =?us-ascii?Q?pHkGp79EdzvDXYiu99NHxz+Gy5p0DhwY9JZ1zziUL+ISBFdKS1/uyT7j+tzt?=
 =?us-ascii?Q?Vp/BbWkHHSo8B3aX+Nhl5hSgVfgOuMw2gYt2HydMy1LuoxhVZTH9UjsDEN70?=
 =?us-ascii?Q?uak5ZHJjyN7FQh1sGkPZg28vpky+bKmI5gFAcLIa/coPdTxdEupQCnM5Ywf3?=
 =?us-ascii?Q?/fOyH5QKGBSQSnQJ6y/ovvpQ4qH5K6xHGPtA0MPWrNgZ9jl2GOOHp+Ro0e/a?=
 =?us-ascii?Q?3nEPQ1+hAOpCLRlEUqOLcyCrr8APMi1be27AMtsk3PxvuLDTdYQqZ/SEKET7?=
 =?us-ascii?Q?nOT1ANGEPtCNNoLTJHqUR7BN9SmZDrhBXCAK7tGBqDmJzUAnvSERZV/yY5IZ?=
 =?us-ascii?Q?BQaI9hRwxQNZ+hQp0C8YNsbGmRnD5VACwoZBhhSDWLl/pyUPUWw4zK5Ar5c6?=
 =?us-ascii?Q?+U6Ni84qJrjAAn9aZG1zm25JMTLKAHyDS//pJ13qBoO3bhcw/VLZpiG6hv4z?=
 =?us-ascii?Q?QBZXt0YAEK7pn5Lab3ppo/bs9kM9SgqdVbIX3Ct868VnswuP9eB+jPJUjHU7?=
 =?us-ascii?Q?uyraboTjDPkL56jzgIgnMQUdpVpUz7EadoB2rWhk4G/Q0fnZTQnj/87Xe6fV?=
 =?us-ascii?Q?Eve66W/BJnDxAp3yA3o8dQ7EEk3wStjneMTvAEq1oSNoPs4VqoIjChRJxW9H?=
 =?us-ascii?Q?CkJNKjGPNg5HXF9/eFPM7vzXbQM4t+NjIvpWJoUjPCeVscoMOz7guROu75TZ?=
 =?us-ascii?Q?NXRiaX759qxddBkGKTu4eKSO0bzHOViCGRBVTkVwzuy6QG1mRj3rbtmeIyrx?=
 =?us-ascii?Q?bzbx1s0ChykhUgn4F/us4fBG+eXuW72uKHMUhoGYqXeAXLFjcicmGtIT+gpe?=
 =?us-ascii?Q?xceax6/om92OIAVEAr43CM5JrafHCOdNpcmp5fwwtb+kDaL8CEzLoLnYIvNq?=
 =?us-ascii?Q?z89qMXidai6lwMhRmVEBT20tDvR17tLrI0IT/Hs?=
X-Microsoft-Antispam-Message-Info: 6zhDy7rUXuZrZiGX6FGLeNB4fMcrhgTp68lyvMpngHK5yfAhiBh2SocE7JBqae0DD5IcrSv5ne+ZUiyo99z180jUR6zQN2YcMPQ/zfXSxL3qvjfwku/PQ9qI7Co98d5+fjjyrNvxuhtQaKY4ck5TkV6CByI5kAplEChjl7qI5NXtNqZXA7dEglJqLrraqEoJ
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;6:Lqc58ytbF8JUipkNod2FDTOnfdEcuhqbY7wltzE/LUam5tmiIKR1rpLwWTzEdh5stmbJRXTzYNDszgJIBUHbMNHfg5ugQY4bV7wQrPxlIT4h68Ecyje6gJ/zhJqc1UOI4/UeO/J5WdYDOG6kY4WTvBl+OIIADHPID7VklyR/pJuBhAZEkLCal4miWD039Bun8CwQLUMb7DbmZ9pAIrffV4f9e84ixBCCPBVp3kGLW9+gOvIfPalJX5SAWOwuRUPxYgZaLIMNmle+4jNgjNGq/PcAXDt4ClS/812wJQRl2ftvEJacq4Oo0zyE7vj0O6xytYoq4S28UqvEeMysT+AT6oZyzmwQNdwN13nKHmjznOH/kn3keYiGuyzmP0ANQRffOdEc9qFVBuuT87VKw1aqJnzqNtd4iO6/7YtPjTKVzIUxWkIBDJquae3FEoexJHSdW/Wl1RrHGn88yF8udjlRmw==;5:8o8/1+g/AAFP2XX9ZFLgAv/n5CKeOZRX2ce0L1ayzJIn291DZWbf7NkqJRkFYhaittxfO2+/FxfhXhmr0GJG0vOypfz28FYI+6XT6bPTiI5J3/CxdEzutOw6CP4GU78Los1uXlwQ1F91AlTKaO7l+YqmkEQMI+OfH4NByUsYvwA=;24:hfUtTVnovAlQiHX6bfIA1hs1287Qxq49uj8kYlUyslOEr1Pmocp+WhryB9+NogEleOfVbDOjmbFbRPK2/0WgSGys5MvVotX5eCbLv5VGPqk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;7:cakAzCSX0IjKXdioCg/9+ggzAhUXI1lQW9ZU7Prn8+Q9xUQvqCIyGzMqONUncBN4uA+DucgWW4vRkIcgdyiJY2/XTc9eGd9OAqI+wgwHoNKW1dIkqrG9+QgxLNsVuaJLz3gg78vj5eCLIrxmEo8wnXTobsbioilNuNXBdMe6RXHEdXLsqmh7I5EswVnpYNUnOdvr0M4OCyc6NacQDcvHLUrX9aDDL3+PAwv36glVcVXYsimeTs2iDMGEwoJLcgRm
X-MS-Office365-Filtering-Correlation-Id: 897c1974-2d3d-4086-1cfc-08d5bb03c455
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:05:18.2720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 897c1974-2d3d-4086-1cfc-08d5bb03c455
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2636
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the appropriate SPDX license identifier and drop the previous
license text.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/clk/berlin/berlin2-avpll.c | 13 +------------
 drivers/clk/berlin/berlin2-avpll.h | 13 +------------
 drivers/clk/berlin/berlin2-div.c   | 13 +------------
 drivers/clk/berlin/berlin2-div.h   | 13 +------------
 drivers/clk/berlin/berlin2-pll.c   | 13 +------------
 drivers/clk/berlin/berlin2-pll.h   | 13 +------------
 drivers/clk/berlin/bg2.c           | 13 +------------
 drivers/clk/berlin/bg2q.c          | 13 +------------
 drivers/clk/berlin/common.h        | 13 +------------
 9 files changed, 9 insertions(+), 108 deletions(-)

diff --git a/drivers/clk/berlin/berlin2-avpll.c b/drivers/clk/berlin/berlin2-avpll.c
index cfcae468e989..aa89b4c9464e 100644
--- a/drivers/clk/berlin/berlin2-avpll.c
+++ b/drivers/clk/berlin/berlin2-avpll.c
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2014 Marvell Technology Group Ltd.
  *
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  * Alexandre Belloni <alexandre.belloni@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/clk-provider.h>
 #include <linux/io.h>
diff --git a/drivers/clk/berlin/berlin2-avpll.h b/drivers/clk/berlin/berlin2-avpll.h
index 17e311153b42..f3af34dc2bee 100644
--- a/drivers/clk/berlin/berlin2-avpll.h
+++ b/drivers/clk/berlin/berlin2-avpll.h
@@ -1,20 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Marvell Technology Group Ltd.
  *
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  * Alexandre Belloni <alexandre.belloni@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #ifndef __BERLIN2_AVPLL_H
 #define __BERLIN2_AVPLL_H
diff --git a/drivers/clk/berlin/berlin2-div.c b/drivers/clk/berlin/berlin2-div.c
index 41ab2d392c57..4d0be66aa6a8 100644
--- a/drivers/clk/berlin/berlin2-div.c
+++ b/drivers/clk/berlin/berlin2-div.c
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2014 Marvell Technology Group Ltd.
  *
  * Alexandre Belloni <alexandre.belloni@free-electrons.com>
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/berlin/berlin2-div.h b/drivers/clk/berlin/berlin2-div.h
index e835ddf8374a..d4da64325190 100644
--- a/drivers/clk/berlin/berlin2-div.h
+++ b/drivers/clk/berlin/berlin2-div.h
@@ -1,20 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Marvell Technology Group Ltd.
  *
  * Alexandre Belloni <alexandre.belloni@free-electrons.com>
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #ifndef __BERLIN2_DIV_H
 #define __BERLIN2_DIV_H
diff --git a/drivers/clk/berlin/berlin2-pll.c b/drivers/clk/berlin/berlin2-pll.c
index 4ffbe80f6323..9661820717a5 100644
--- a/drivers/clk/berlin/berlin2-pll.c
+++ b/drivers/clk/berlin/berlin2-pll.c
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2014 Marvell Technology Group Ltd.
  *
  * Alexandre Belloni <alexandre.belloni@free-electrons.com>
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/clk-provider.h>
 #include <linux/io.h>
diff --git a/drivers/clk/berlin/berlin2-pll.h b/drivers/clk/berlin/berlin2-pll.h
index 583e024b9bed..3757fb25c4e8 100644
--- a/drivers/clk/berlin/berlin2-pll.h
+++ b/drivers/clk/berlin/berlin2-pll.h
@@ -1,20 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Marvell Technology Group Ltd.
  *
  * Alexandre Belloni <alexandre.belloni@free-electrons.com>
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #ifndef __BERLIN2_PLL_H
 #define __BERLIN2_PLL_H
diff --git a/drivers/clk/berlin/bg2.c b/drivers/clk/berlin/bg2.c
index e7331ace0337..cd2905364261 100644
--- a/drivers/clk/berlin/bg2.c
+++ b/drivers/clk/berlin/bg2.c
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2014 Marvell Technology Group Ltd.
  *
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  * Alexandre Belloni <alexandre.belloni@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
index 67c270b143f7..9ca26f3bc6e6 100644
--- a/drivers/clk/berlin/bg2q.c
+++ b/drivers/clk/berlin/bg2q.c
@@ -1,20 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2014 Marvell Technology Group Ltd.
  *
  * Alexandre Belloni <alexandre.belloni@free-electrons.com>
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/clk/berlin/common.h b/drivers/clk/berlin/common.h
index bc68a14c4550..1afb3c29b796 100644
--- a/drivers/clk/berlin/common.h
+++ b/drivers/clk/berlin/common.h
@@ -1,20 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2014 Marvell Technology Group Ltd.
  *
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  * Alexandre Belloni <alexandre.belloni@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #ifndef __BERLIN2_COMMON_H
 #define __BERLIN2_COMMON_H
-- 
2.17.0
