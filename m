Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeEPJwv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:52:51 -0400
Received: from mail-bl2nam02on0070.outbound.protection.outlook.com ([104.47.38.70]:27965
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751904AbeEPJwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:52:47 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Wed, 16 May 2018 17:51:57 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: sebastian.hesselbarth@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: move berlin SoC files from marvell dir to
 synaptics dir
Message-ID: <20180516175157.3d02dbdc@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0166.jpnprd01.prod.outlook.com (2603:1096:402::18)
 To CY4PR03MB2630.namprd03.prod.outlook.com (2603:10b6:903:75::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2630;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;3:vBmCqMTp2giiQi1fP+OPUByiUMrMyNslqU6tvSgOf7pmdUzH03MfrvyYwYAw2XJmwFMlDXWEL9Bgo68SN0iDLTc5AqEOmiu9zNSKCrz3MRIgTAo7vK0ZnYX9p/pyPO7qNRVQeSWDfhGE54/z8ZsvRzA7PDTSJ5Y4Ubl5PNklGajPUtI3MvCN40nMfc9fjRPChjK7CI5o4/nsRbnu2/W5qsPBZTIvZjRq/Hfdvr0epqKDWvaBX0WYIkdVE+ReVfxa;25:4PuDoQdAgPnD3fZPubMFyddjAEwvQYWskIhQFW3r3keL0vWVH0Ee0wCx0sDTAMcJd8vtQfmBvn2X1m1oxUp41FxUz0Ir3ifMSfgNm0n1KoDHnDDqVjPmN/FjVRliqHACv2W07ru/N3G+dMmtEi4EErBoeJKChWNaKaRqidnUZ3pElVb9r8Ln4CpOtAiL+qxHqGxhWzfy3ThK8LR4y208xbtvcMHkhKuQ+8oP+5jmO6zPBatfXxhI1FCmvgyyqxzsYNc/q1DEOd2O1yapNef9ic6wrZGdtNIGfWdnasb08NscGCEv0KBFJt95MyizZ4LrVoIMI03MPpnwVjXaBlsiIg==;31:AkmDh1fhsRSNdo3Qs/TiydP2BSyzJIZlEA4kliq8yAZnGKX9ZQtTG0jhT7AhCs0AO949kSL/YunfWUsAAJylN+NPyY+rZEshB5A6fBYk1pE+GatuiPNglBQUIksyh69Q0AOlDJg33/0bQMtEJ80RT/YfxUGu4wMZsO+sVlSgueJK5OXZCAa9firKRQlutgrtkDX2PiU5KY4fwxC4w1YH282Q5hQjgW9BIwgqlhyU5+4=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2630:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;20:7wR4MUcEaaAVOiZ+pPkheUoZy6g06Xh6cyQvgFwH6dJJDEY+bM3Q2pJTz+nPXaZI/RBNrtWottEOW8QzydIvJc9MBnoRn8lYeXeEe3znn5gCKHAFVlgpbBKpZOI/A6HrpJdFh4CrDK3O2MgF05G+McrmHic+O00AtO8Vc2JNrYe1zYFo50w5RyOMDnCb/+C4pLkcFO3TIFx2Xu6voy0KNNXQNs771svzUwpxwz7cWpma0+727TFzB7zAAsZCzCNiKM5Y0Gax9tdys3M9dFgm3m7pQRMUIcCy/xgWuJ3l8bV09fNBDWw30e/r7lPaPZI4pwp8rcxYgAJkbKQWNZilv/kEPamRTYa0zBjunZu81DV3j0Sxyxb+61BkpRGNEOerCgPKrLyacZErr7ZYOc1Tugqmfp4T0esWUySJ7f98v27QaswgJG3wjAUA0OCd3gemrFVYOapzxqy9dnxktuK5tc97zuPknq0CykXHPhujwvU6PRXIfbaBWhwoWGDJ37Hs;4:1gOwgRCnBR53igEEEMFPR58HqlLrMIDSaHDuU4QXEn37Xnwe03noadrpksZeeKqXKEFTFYJa6aMAab1AsZQKeDid7ln5emRBVAMfaHATdxjVdTC/9OPlADC3lA/o/Pn/AP6bHFG6vyow66wwAHxYdOccsMHsEkLFUtMHwIiOqDYzWg6RiNzcYnpPWi1AZseSk4/EiGKxtHfHTzj97YUZBQs6PUctjQSRu4HurPIHoeUsp4+VUDM/rYF59WwIiC5ouOVd9abbxPRftUgQK/P9zQ==
X-Microsoft-Antispam-PRVS: <CY4PR03MB26309B585A5063F1463D27C9ED920@CY4PR03MB2630.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR03MB2630;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2630;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(189003)(199004)(4326008)(97736004)(81166006)(5660300001)(81156014)(50466002)(7736002)(8676002)(53936002)(8936002)(316002)(55016002)(9686003)(956004)(47776003)(476003)(6116002)(72206003)(230700001)(3846002)(23726003)(486006)(16526019)(50226002)(478600001)(25786009)(86362001)(33896004)(7696005)(52116002)(386003)(6506007)(39060400002)(305945005)(186003)(26005)(110136005)(105586002)(106356001)(1076002)(2906002)(1857600001)(66066001)(6666003)(68736007)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2630;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2630;23:4hpX2ZuP+Zv9Fs+7hOrLr2hHwIoe7LwUGK9yBGrPb?=
 =?us-ascii?Q?/TE8qn12Vib/LReK43C7rS1kkqmfZjfcncpYuYYJy8Da6QiJQo/ol4+7u9Pg?=
 =?us-ascii?Q?BfRyAxfF4xTKAhKcQ1TKTTfOQDM2AVeR1a9lLxFP0kEFrpAmiX4gk+h4NrK/?=
 =?us-ascii?Q?pWMlOnXpMI9RkNPKb9ZjfWpRTAuzETK24j7PjAYzDVnUq/t2mmW4lTG6sbWB?=
 =?us-ascii?Q?YT1FHzRdr4Y7tWMS6b9pBvR6bRjH7DHEPyq2xIruWHFa2Reus/R4VXcqGHLE?=
 =?us-ascii?Q?uGtnmysmSR8b2C3ksq9Ul6E94RP1mzst9vYIOvQy7tT2xfIcyEEgn3DmMNgl?=
 =?us-ascii?Q?CbuxBOutrYeMnIk7XvmnQM2K5enPyo+xRpbxcjNDMENNtDKtWvVURlZGUe6b?=
 =?us-ascii?Q?CM7ADYwUE2BaUh9iJ0oUuThnwYn/Caui5szxqPZu/XQo7YHrmo+MXjkYbeP2?=
 =?us-ascii?Q?cnhLgVloHfDpeCgVJl10le4f1vek7U5tAi1ozHIWE0RNcFC6Cn0VJKNwgeog?=
 =?us-ascii?Q?sZnuXOLcaayKhVZxNQh7o9/46KAJukyVMqHNgDrDhKZh41yB3LjVYt4UWk0H?=
 =?us-ascii?Q?UVpYaD79wTWQeh3AAr6hVrof5DR4Xqa3yuML/k5YkrAIU6G+T0T3Ev9mFzil?=
 =?us-ascii?Q?AFsdB9UXRirrktjRxKeBlCt9Gmq7zs2BNa9xEHLv5gEYJEKBMdrvdXcVw26B?=
 =?us-ascii?Q?90ium4W9dwbjfwN6bxieRK2DHTeX/wGMvSwOdcQhUZU6vLXNeUyIZNF1PkA0?=
 =?us-ascii?Q?tr3SavTQwg5BaQbfdYM2UFHBKlkTn58qKTfa0eVfzWRB4IpKotM+VomFxP7f?=
 =?us-ascii?Q?KKWUmnPKQYtuVvX1sig7xJt9SVVVGOSTDc/e4HRXiunazzL3kLh+1onL9df7?=
 =?us-ascii?Q?xj22c1GUEG/3hsguPUGWJWYIAy7SBLZYe/sXAORa4h+jY+kSM/5YBnqkLkpl?=
 =?us-ascii?Q?om5JWpOKxxBBx2DpP43sBJnSEJUS813UQjmqDzZQDMe9KkAm3+vwFNOMPOPx?=
 =?us-ascii?Q?cjqePFzHrKjuwmPQjyNa6b2JMaZ+qi75g49WTlMxip+4QHZoPhhg9v7D+oL7?=
 =?us-ascii?Q?Bh2vHjaMbMUPZ8UVH826xJX3T9jP+N47haDkG1XzDVHyXSrqbN47xmXcCM6n?=
 =?us-ascii?Q?O8pG+Elo1+cHMCe4PEiktNl787iu9NPRBQSUC4j923IKMEahjvn0l00qAF59?=
 =?us-ascii?Q?abrlLzeNW5EE+VSjFde2h4RsF0qievUvfJJVfv7i67ah7Nd9lO9kIRE3w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: zLa1Faei+LEc61yV8Et/qOf4y4NDgTGw6yEaIqt9B3rsRqxLM+cW9frOtUpTJ10zm/2/mNfUD/rxofCHY9Y2rBWCeR2X/4kEIurkXfac/PWCNy8jxfKoZaUHg0PqNakiTFFaFGFLo1wGSr8MOUY0wNuuwm2sovOPsm8EwkgyDqGcv8lxZ3/ENSkML4glQwqq
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;6:DI64c8xdoN2thJ4ApF+QedmOBUIFsVRQAHLvhvst+RjLhEJ51HUFx9z3SjwhnyMB91E/ynwtdcPAmumd89rNzeumD1Q+Plrz6bWOGuD590YTZfi/sy3v/dEUq0N89cnSPSi7JrE9S7AGk3CCADR2oII+SJcHhWyZuxUrhwOV7lAJ7YIrY6rdwr29Ftk9Uic0RsPgWCajUVUi+Tvr13KwQWvJ2KWwld2ZLfkP5TCr/jhrgpdCuL8sAU7RkoZCaOevQNynDHLP1Sce4whpMj/6GZQsgBv1Fkg7wDa2p5PMFRlN1j4vvVJZIp/fUnZg6WgthTiZ1iJUu5WN8flQ/IMVm9lIlWm8PggS3WDMDym6Xho1+ibWuaFSVQ365ssSohQ//hRx8nn19mWEg9AYW4l7m9vJRhlMBKzVhOfaCKU3neDEpS7A1zfOxHD2RoKS2f0GC0qeGJy2l+TrZZ/KUjyIfw==;5:GtT9EyTjDQajGb9/P5s2OJs5Op0GbhVjcubzgXcSwbjDKyRK8P3j8vB7FjSWqPU7qvb5vXeumQrtCJ5gJX8prW1b576fApLN93fob7aFKzktKU7KM3MiN7APOwjXjK2+4XgU6rlLNiwFO1HHlerrGXufjOrKNj0lsppYoN6xpSw=;24:l+gCUDE1jBCiCZolsPfv/++4LrdHO2ngcaRon6/4Ws7TaMHVO2afWvxHu29nzM5Hr5IA4+c2mE+cZv+HfdXs+v8xE4YwEilhoHF1/Z+lCCU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2630;7:rzszXLTg9muexeU4sZDO53J5BWBxTaPdQEzkLXkXjfcJNneoBlZALOKFVbBsFIYL0bvOS3EmANuqF0fs8+yYDf1IEK1tyVfyIIjU8KHUYwLSXqtK/A6eZvflMG7CiljlZP0+uLPIz2xl8UCWuTuSVtjCxllqb1wAo8mIVwlIaggJxKQ+jmNXd0XYFipDMIrNFlgRwyVhk1lN300oBPDxlquDJf93TPb21skrbOCb5QiK7WpdGCNh0BQ36+yBT40t
X-MS-Office365-Filtering-Correlation-Id: 4374df97-3cf5-4a11-e76d-08d5bb12c65b
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 09:52:43.3572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4374df97-3cf5-4a11-e76d-08d5bb12c65b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2630
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move device tree files as part of transition from Marvell berlin to
Synaptics berlin.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/boot/dts/Makefile                                 | 1 +
 arch/arm64/boot/dts/marvell/Makefile                         | 4 ----
 arch/arm64/boot/dts/synaptics/Makefile                       | 4 ++++
 arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-dmp.dts | 0
 arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-stb.dts | 0
 arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct.dtsi    | 0
 6 files changed, 5 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/synaptics/Makefile
 rename arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-dmp.dts (100%)
 rename arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-stb.dts (100%)
 rename arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct.dtsi (100%)

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 4aa50b9b26bc..3543bc324553 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -22,5 +22,6 @@ subdir-y += renesas
 subdir-y += rockchip
 subdir-y += socionext
 subdir-y += sprd
+subdir-y += synaptics
 subdir-y += xilinx
 subdir-y += zte
diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index cb454beede55..ea9d49f2a911 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -1,8 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# Berlin SoC Family
-dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-dmp.dtb
-dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-stb.dtb
-
 # Mvebu SoC Family
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
diff --git a/arch/arm64/boot/dts/synaptics/Makefile b/arch/arm64/boot/dts/synaptics/Makefile
new file mode 100644
index 000000000000..de71ddda6835
--- /dev/null
+++ b/arch/arm64/boot/dts/synaptics/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+# Berlin SoC Family
+dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-dmp.dtb
+dtb-$(CONFIG_ARCH_BERLIN) += berlin4ct-stb.dtb
diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts b/arch/arm64/boot/dts/synaptics/berlin4ct-dmp.dts
similarity index 100%
rename from arch/arm64/boot/dts/marvell/berlin4ct-dmp.dts
rename to arch/arm64/boot/dts/synaptics/berlin4ct-dmp.dts
diff --git a/arch/arm64/boot/dts/marvell/berlin4ct-stb.dts b/arch/arm64/boot/dts/synaptics/berlin4ct-stb.dts
similarity index 100%
rename from arch/arm64/boot/dts/marvell/berlin4ct-stb.dts
rename to arch/arm64/boot/dts/synaptics/berlin4ct-stb.dts
diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/marvell/berlin4ct.dtsi
rename to arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
-- 
2.17.0
