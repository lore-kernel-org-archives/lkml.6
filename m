Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeEPHeu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:34:50 -0400
Received: from mail-bl2nam02on0087.outbound.protection.outlook.com ([104.47.38.87]:43264
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751285AbeEPHed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:34:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Wed, 16 May 2018 15:33:37 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: berlin: switch to SPDX license identifier
Message-ID: <20180516153337.79763417@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0157.jpnprd01.prod.outlook.com
 (2603:1096:402:1::33) To DM5PR03MB2636.namprd03.prod.outlook.com
 (2603:10b6:3:43::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2636;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;3:smpJukh/ujMzUncGWIPQcGoqiT/9N1/Xr0XqYHXP2Yp1hGIiRehJpJJBnngvX6XpGMl17ri3DH7KKVQm7yqbAxZ/Oh9aKapmmGMxkEIzI+pQMmiASAgRtG7kK+kt5vRJC74A2FKFkR8nF6BqBy5d+dTuXqrxZrwOaEun57zie4fJTo1hiyMTF1wupUrMeaXLxM8qqd7esxCYoGKtII149erGGpKQLIjjjLVbUlfuLJ+YWGM+6HqsqFpijWdtWdiM;25:CFYDKctFZIrGyiLPBTFt1XFNhxmMCuzRiA36TVlmPIGp9fAhwp14imoibQtl/OhQZJTwW7ovGgERTJBFLevVbgecFgaWN1unae8GR8LacMd3XLJ6n7Z02DXRJzvSgyhl2UgW4A+1G5KIwx2PhJjDC6HkiAkIz8TeZV1MpPLQB4yEwCfVs4PeSX67pVn523+VYyKJXa5lCxh6w67pD4339SkPKNj9Nj7ei+4B9b/5ylCKliqA2z/ogUjoAQep4Ck/pEr7dl4OoD/Lbo9R/o1P2HRNgho1NhPe5IzKrv6RxZn79tD5Xmz89pC4+v4A5cZAB8IydlEG7yJW/MDQJjxz4w==;31:ukEBsxLFRiGU5OG5XMwkGL0fsN4Ajxvqgl5auPBJDNRrzQmX/qtdCdkcNObHoey+P/qXDc/s0AcOjr5KPwgr1cp5QcaWhG7e1zJMc1/t4DWRviEEAiH4/lfDx77Y6mDB/43B6fD1/2y4TjANVR0qheGCzeLd74dBCjjf67R2K+axBwYka+5GGKjcYGzuv40ha/jVbR7U/PUAUfhwqULs/duO+zAz2GOAJUdv/tyGWiQ=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2636:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;20:PIzs7y99qmHBwtzpniZkL+g5dqaKEzLSTPRXMDTur69NqZ5BBsxKfU7FiyCVgXlfUHSenvfo8at2x9L3dC7moCe1WAJ6xdUb0eXMMwwGAGoHRa60krF0gA+YUfBfM5gZGwpPqJXg/hFn0XTNaGqxf2Mi/Iwoq+YPhwijyEPRG0KBUbJtQvGQw+jeUW/xyFAbCV/C6gN6pVn+Z+aZPRxIrM+qZFmNQrB2J0PM3GlaJpnOlfV/mXUeErssiEmVF2TZX0dIVpHvpnnKTcSfrOCytQv3khNd9mvt0jQ4t7wIYIAt+9+AP5eueGfJAs3mpl1S/ofkuKMC7G9bxYNRozaJe2Rr38M9R9YiZJOQCrLYB3ollXi2AdrVfXI4ILp7BNtylxeldJ3+Fv1xbvdnUBMh7uMDniU26MF04hPzQhmt6LCuNX6K/qZvlD0FIFT5sasvYxIGclzS6yKNetpVJ5eQAaVlp8Ud2ysVwozC4G9pX3NCiwsMzUrN28LVu4a22BSo;4:hJaHl7jnzpQFtn28i7wacUy6QTOY2lj/oDe5SuWsuP21pV5XG+QbHPbwiUa7X7Ku2Bntjxv0Wiq+UCCLc10mUenqcawDx2vaeOSp3q3dQHFEtU2Buwz6UW4jfjI3p1P5U520L0AurzfJdkugZUNFRXsKXjgMvofpmtVV4yPZMKP3DRg12CLPC5DgoKdA2OXPY7IcPn4lKpjB4fXhH0ZCNnlY3r5NbJ+N+muZFPtdVO84K/4beyzOWnFf8tmsllv9Dp+jNLHxRXYtCM8T5r1xZDaZAr5Ile2S1zYDWypp/MwoVEhUC5z/3//zSGxrAcn1gUrcltVi91wurQIS0P77inpOE2QjRXrdt1UNOMDzC4e5AZ3YdAyDKU2oCjtYqjHL
X-Microsoft-Antispam-PRVS: <DM5PR03MB2636755C87845F1EF2797DBAED920@DM5PR03MB2636.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030)(58145275503218);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR03MB2636;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2636;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(39380400002)(366004)(189003)(199004)(5660300001)(8266002)(86362001)(16526019)(186003)(8746002)(575784001)(55016002)(53936002)(8676002)(6306002)(9686003)(81156014)(81166006)(68736007)(97736004)(105586002)(106356001)(1857600001)(1970100002)(26005)(2906002)(4326008)(476003)(47776003)(486006)(72206003)(478600001)(956004)(25786009)(66066001)(70486001)(97876018)(7736002)(8936002)(117636001)(50226002)(6916009)(305945005)(52116002)(33896004)(6506007)(50466002)(7696005)(6116002)(23676004)(3846002)(1076002)(386003)(316002)(2004002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2636;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAzTUIyNjM2OzIzOm1ERm8xTnJoVmVpTjVWeWVEOXJKazlBbTEv?=
 =?utf-8?B?aUlySGlyaldsTmVnL2NFK3QwcloxL3VhMHIxTi9UekJYQmUrTVBsdStvaG5D?=
 =?utf-8?B?U2pqd2p2YlAydEhITEpLNk1QR0VQTk1iRXkyTFowcXJtY1NXTjcxb2FHSVcw?=
 =?utf-8?B?emd5by94QUsrMHBZY3dBKytLSzQ4N0VFMHB3cnhvSEpzTjhaVnJwOGVzOHht?=
 =?utf-8?B?WjQ4cGNCRWxrY3AxNG5tLzB5V2dXNkgwWWVvVFVvSnltYjBCdmczWWtWZHdD?=
 =?utf-8?B?cmtKem1ZYUlrQ3pDbHFrNmdOM1FlSjZxenloNUNDaTd6RzFiaUk2ZjBJREdE?=
 =?utf-8?B?eTlCR2U4YzdxSFk2OVptL3ZXTTZ2NE9aeGVXdGJVK0FTdEEwUnJQYWo3QnVx?=
 =?utf-8?B?Y283aUgrV3Rjd2hhRGhRVnI5aUJob0NuTTRHVGQ0UG9XcytKTElyRUZzQmJs?=
 =?utf-8?B?VDFJSVk4VkZLNHZuKzkxNXU3Ujg3cWJacHZiZk5RZmlyd0w3UHJsNVlVNUow?=
 =?utf-8?B?RjFrcnZGL1dTd2czeGJKb0xzZDZzWnR3RGpBdTFKNEw4enE3ZVhJdGxIZmFo?=
 =?utf-8?B?YzJpNGRCeE9NTjNZYkdtL3FoQkFOakVSTWd2WFZMMlBSdGpTYW5Cc1lXdkgz?=
 =?utf-8?B?SFR6NGpRR2xSeFNGaitrNGVTZXNpcXlQemF4eVhFNElUVnlTS2ZxOHVjLzdy?=
 =?utf-8?B?UlE4T1Zab3pTaUJCcjNkRldYQk5YdWxPakRPdGtjWGhxYytIdVJGQVhpbzRq?=
 =?utf-8?B?LzdrZCtpV255bjBpWE8yNjBoTzVDSWlFbVFTSnhseGQ0Y1pPYjl3dmxwYnQx?=
 =?utf-8?B?MW1GdFRKbkU5Z1ltWkVYU1djWVppMmVSWkVDVWlmSS9kam1lSnRlSktVRHpK?=
 =?utf-8?B?bTArclJLSFNBOUtMdHM1b0VqTWFXZG1FTGlDY09KbUZaM0x1OFdDZ28yNVgw?=
 =?utf-8?B?M0xad3o4dS9kSVhab0x4MU1laW42cjhCaklCMEtOSTArNllRQUZsQmd4NXRr?=
 =?utf-8?B?cDBhZWFjWHB4MTBpWXZSTmlVazdrcERXNkhSWWR1MFdBdThxb2RwL3FRWFVW?=
 =?utf-8?B?M3RFN3lyWlRtbW9hakhGZkI5a1JqUWJUcWtyMEE5Z3E4YUlpcVU4eUpxbzdX?=
 =?utf-8?B?bkZvS3ZUQm1jRExCM0VXVWVRRXMxaWJWZmJPZXltY0lPUW04NGRaNExvQXdE?=
 =?utf-8?B?bG1PSFpmbXNHc1pWYS9ULzhkQ28wNG9wc2RLTnNXK05RdGJ6bWdENmxXUjNj?=
 =?utf-8?B?bXR3ekpwMlc0TDEwYUgvM20rVVRXM2hmNlhRUTJZb3RPaGpQRFNqQy83ZFJN?=
 =?utf-8?B?V1AvRW82VDRySENLOUJhUWFwSjVxbUhwUzhVQVdhQXBZVWdjcWRqczBIWU5T?=
 =?utf-8?B?czQrdGJFRzA1SHNJNjJmM2FzaFo5aHpXQWVwRHpGNGRmOXdBM1BueG9TZkVW?=
 =?utf-8?B?UzUyUi95bXhwUGJLdUtRNXo1TmR5ZWNtK25yMjNoSzNEV0orQXZBbTBrekZB?=
 =?utf-8?B?cGoxeGFPQWpqNERVNE0vSGVPME9sMUxGdlgrcnNlVm41N1pld3p5bnJjWjVB?=
 =?utf-8?B?Y2NCTlpDR1lpdno5MWlmdnViYlphSzBYYlhqWDdHOExFNW5lRmtsWTFrVHN0?=
 =?utf-8?B?bDM3a210Y2FlM00yNnh6YmZ2N1g0S0N6cUE1ZkZIcGZHVUl6OVdpRk5FV0JG?=
 =?utf-8?B?L1dPK3lWQUY2b1ViMURKQkM1cENiU3NxeUJnRmFCTmtCSkVzNE9VRUNBT2tS?=
 =?utf-8?B?UzAvOEFlL1E0SHB1cVNhdVhlTlNIbnlpenVGNC9VZnVRT2lEYVJuS01wNStG?=
 =?utf-8?Q?HiyBELe/mRqxA?=
X-Microsoft-Antispam-Message-Info: Ki1V197B1Ob0goV/ZOxgNctvo9o03zQISxlETU/Zytypg+u0TqdkiCKt/eQDp1FDQFVmeiVg/UYwpjKnC/Ns5JStfVe5TkJrTREO8YFMszpXH0HdkFl638p83W+qM1D8XcWGAB+uSlkImV3fKMxNE0xwtTWAxZzvon6OZ7y6tU/MDGPG0W/rq01NfmIgGt1Z
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;6:YJns3kjJnws3mMTeYPnl6PLZG8GnJn4FXE3e2reIg6VQku6NuWhCuOWw6SLtDc1rEpl5forpWGqSrea8xNlsMmxzulmxf6hK1TwcuVeV1sObIskU5w70hC5548Woaxqr+2Qv8XfLzqBPPEWHrAryTPzOOOd6mP28PAptfmlbejOQhO6vI22hqlOPIv6a8awkBhttuG8CbIGFORSSl0CiK0rFB5jrzfhTU6Fk57iQff+DEW5HTWM43z9D2v0D4KsWvmhc311hj+uUDZSwxvdIHOJ+A86JgwlLhexjKVjR/S+X3Pv7zCytRZkoQr7XKRnhn9StpEf4BLAv20SSbNmdz9V+NFF+5bF1sfKc/LnMZFAA66Hwc3eGTD31fSumKscqy+ewORdZx+4gG3+uBGsrLfwv1lf6kXhCGy6zhGoNDa1Ko6ucuYpDeL+wtf0g9tKzxU6XwNMNNDfkahVyEzFZ2g==;5:wxhS+3bfIt+G/HILciveIhf/lRA5fgZ+EQQlnupyzRy7WG/h5AgPg/cdmwg5TRYVB2qDIMjJVvcIsIJ+8067djM4faG9x3e8f3Db2B6Ou8+YPAAjj2alcyK9HkgHteZNgTUbE1h9rLVzkPNXWuwv3q+qCC9p2VfgstfZvAJDe4s=;24:mo1b9DqD5aZKnNFG/B+2KTKqp9ZMkri2inTJUPi/zttoKegb1orIL6VXpIJ6zAjLrbiCI8ydXI7DFy3bo17JzOWt2rMiZIT/yUXNvvvx+Ek=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;7:u9DNbmmxKnnyS3fBNZa0vWphNFPqSMU37f10CDejLdx5vb4TlDaXHFj+MpX3O1H9Qezbi4pTdz9Emc09udq8drWyM8pn3FdeEn3o7c0qGmkBFu5RZY2JLEsJnRj5y0hQzzk2THKZ+ywpinIahIT8Ry6z0TxrGODYuNNl0CFH/zSfaeZR2x52+oPmlrkyewGJhX0dAsSnCfkqh0WG50iN50ScPC2R5bbWq6JyWbeUD6dsi8yGpfJbIqWQZp3AqqHj
X-MS-Office365-Filtering-Correlation-Id: 8a927f61-6667-42ed-a346-08d5baff76d6
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 07:34:30.4748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a927f61-6667-42ed-a346-08d5baff76d6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2636
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4G7YvtT013850

Use the appropriate SPDX license identifier in the berlin pinctrl
driver source file and drop the previous license text.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pinctrl/berlin/berlin-bg2.c   |  5 +----
 drivers/pinctrl/berlin/berlin-bg2cd.c |  5 +----
 drivers/pinctrl/berlin/berlin-bg2q.c  |  5 +----
 drivers/pinctrl/berlin/berlin-bg4ct.c | 13 +------------
 drivers/pinctrl/berlin/berlin.c       |  5 +----
 drivers/pinctrl/berlin/berlin.h       |  5 +----
 6 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/pinctrl/berlin/berlin-bg2.c b/drivers/pinctrl/berlin/berlin-bg2.c
index bf2e17d0d6e4..acbd413340e8 100644
--- a/drivers/pinctrl/berlin/berlin-bg2.c
+++ b/drivers/pinctrl/berlin/berlin-bg2.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Berlin BG2 pinctrl driver.
  *
  * Copyright (C) 2014 Marvell Technology Group Ltd.
  *
  * Antoine Ténart <antoine.tenart@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/init.h>
diff --git a/drivers/pinctrl/berlin/berlin-bg2cd.c b/drivers/pinctrl/berlin/berlin-bg2cd.c
index 9bee7bd1650f..c0f5d86d5d01 100644
--- a/drivers/pinctrl/berlin/berlin-bg2cd.c
+++ b/drivers/pinctrl/berlin/berlin-bg2cd.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Berlin BG2CD pinctrl driver.
  *
  * Copyright (C) 2014 Marvell Technology Group Ltd.
  *
  * Antoine Ténart <antoine.tenart@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/init.h>
diff --git a/drivers/pinctrl/berlin/berlin-bg2q.c b/drivers/pinctrl/berlin/berlin-bg2q.c
index eee6763f114c..20a3216ede07 100644
--- a/drivers/pinctrl/berlin/berlin-bg2q.c
+++ b/drivers/pinctrl/berlin/berlin-bg2q.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Berlin BG2Q pinctrl driver
  *
  * Copyright (C) 2014 Marvell Technology Group Ltd.
  *
  * Antoine Ténart <antoine.tenart@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/init.h>
diff --git a/drivers/pinctrl/berlin/berlin-bg4ct.c b/drivers/pinctrl/berlin/berlin-bg4ct.c
index e6740656ee7c..6a7fe929a68b 100644
--- a/drivers/pinctrl/berlin/berlin-bg4ct.c
+++ b/drivers/pinctrl/berlin/berlin-bg4ct.c
@@ -1,21 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell berlin4ct pinctrl driver
  *
  * Copyright (C) 2015 Marvell Technology Group Ltd.
  *
  * Author: Jisheng Zhang <jszhang@marvell.com>
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
 
 #include <linux/init.h>
diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
index cc3bd2efafe3..a620a8e8fa78 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Berlin SoC pinctrl core driver
  *
  * Copyright (C) 2014 Marvell Technology Group Ltd.
  *
  * Antoine Ténart <antoine.tenart@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/io.h>
diff --git a/drivers/pinctrl/berlin/berlin.h b/drivers/pinctrl/berlin/berlin.h
index e9b30f95b03e..d7787754d1ed 100644
--- a/drivers/pinctrl/berlin/berlin.h
+++ b/drivers/pinctrl/berlin/berlin.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Marvell Berlin SoC pinctrl driver.
  *
  * Copyright (C) 2014 Marvell Technology Group Ltd.
  *
  * Antoine Ténart <antoine.tenart@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __PINCTRL_BERLIN_H
-- 
2.17.0
