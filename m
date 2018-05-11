Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752465AbeEKDht (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:37:49 -0400
Received: from mail-by2nam01on0106.outbound.protection.outlook.com ([104.47.34.106]:25728
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752562AbeEKDh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:37:29 -0400
Authentication-Results: spf=fail (sender IP is 64.157.242.222)
 smtp.mailfrom=nxp.com; nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=fail action=none header.from=nxp.com;
From: Yinbo Zhu <yinbo.zhu@nxp.com>
To: <yinbo.zhu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Catalin Marinas )" <catalin.marinas@arm.com>,
        "Will Deacon )" <will.deacon@arm.com>,
        "Lorenzo Pieralisi )" <lorenzo.pieralisi@arm.com>,
        Li Yang <leoyang.li@nxp.com>
CC: <xiaobo.xie@nxp.com>, <ran.wang_1@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Changming Huang <jerry.huang@nxp.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>, Zhao Qiang <qiang.zhao@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "jiaheng . fan" <jiaheng.fan@nxp.com>, Po Liu <po.liu@nxp.com>,
        Nipun Gupta <nipun.gupta@nxp.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>, Sumit Garg <sumit.garg@nxp.com>,
        costi <constantin.tudor@freescale.com>,
        Bogdan Purcareata <bogdan.purcareata@nxp.com>,
        Meng Yi <meng.yi@nxp.com>, Wang Dongsheng <dongsheng.wang@nxp.com>,
        "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS"
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
        Tang Yuantian <Yuantian.Tang@nxp.com>, <ying.zhang22455@nxp.com>
Subject: [PATCH 7/9] arm64: dts: ls1043a: Add the identify of the platform to support to set rcpm bit
Date: Fri, 11 May 2018 11:35:28 +0800
Message-ID: <20180511033530.7931-7-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180511033530.7931-1-yinbo.zhu@nxp.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:64.157.242.222;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(1496009)(396003)(39860400002)(39380400002)(376002)(346002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(8936002)(498600001)(81166006)(2906002)(305945005)(50226002)(575784001)(77096007)(48376002)(76176011)(356003)(7416002)(5660300001)(81156014)(26005)(126002)(44832011)(53936002)(486006)(50466002)(2616005)(8676002)(11346002)(47776003)(6666003)(6636002)(446003)(110136005)(105606002)(336012)(316002)(476003)(97736004)(16586007)(36756003)(1076002)(54906003)(85426001)(8656006)(106466001)(7406005)(4326008)(86362001)(51416003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR03MB398;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD009;1:qTZniLZ4uMB8iH7/QqO7hUwS7tRCk0heEIKi3WedjDrS5IxZE0vnQO7oTTMeNj4hlPg0OndWQDe0p2IxUg2QkTkpdkOjAE0RnHwVJ1YkGLNn/lo7Ka5+n1P54HK1SwAL
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(8559017)(2017052603328);SRVR:DM2PR03MB398;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB398;3:qn6ajo7Uhr0JzEw692g+/R76EsKAHKDqWXYuHeilqX2Lbqy5Ih20KUvbSxFQhVZdRhgDihye3AP2TvQLanzbWh/AJyQQFwkY+jiZFY3EG+HsXV+DGPcz724tp3ghB1HXjNwqpMg9VDiK3l4puwOp3+q1OFveSrc/R938HS8g2WVtHDBzMGbXjOTwzuPOt6QwEpa6gjdQdeMzLYHSEugOxB7A1PG5Udi87JntRugJuI5MgrDBAnC0fZLjyoAtT8ptce/4eGMd4Zq0hBau+SxaHcbBSRJldH6Z63rMbXyyHrb5TAbdyLeh3jSXJ5A+m4uHDm9A02X/xn/ZPkS2Z8pwnCMTZCT7X/eTHXgXBp91IW4=;25:RhYFY8CtrzIaPdJmvbM7euPvudv35IZdWrEFgp8o3no1yHj3/E0uklLB1f4sd1vUL+TcwvsYIBUBuLPKR5qHOzffNBjQY2odVo9at4s1qN+CbrLTSaYXjJqq76w/JzqG0GAD2u/wfDUnbYAbYXdG4wsGZq9g0wsc3aDhqC+I7d0crm4lrOfqQqCApmW/BnuQq+a3Bo77uOhdXTmeCyHs1rRe9sWwVwO9XNIC2wofEyBfUO6FkmVi4h6ZaKyBePHzK92IIa5526gU7PnNUapo/2i7xO3pBPSp5M0stMZbKYZiGuqvt48bfP2vyaSxF1bJ22kvxtJY1LIhVs09dlSHgA==
X-MS-TrafficTypeDiagnostic: DM2PR03MB398:
X-LD-Processed: 710a03f5-10f6-4d38-9ff4-a80b81da590d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB398;31:K5jTyqTV4BociT/dgy33L43kpAgqodr2XbxzHPlMhkHjm3ZeJnZLdVOlUgy68pijkURVMCq8enamtoonpdggs/LgsK1KZovMaLXyZB+ggYjuXj4kVir1jjkBpZtaZ50HDpqzEnRtwmxPZ2vBwgnvBIIJry97JhnkwmRDZ0fLSxG8rEQAs3lTMhdQzLvxqdW9BAGRv4t6YsDg3I68+yJI26xpdTxA9uSh2FfKdR6Qi3g=;20:D4V9VxRVsYUs31c2Vafif+5M6GEAQ5BYMeqsMA4LNJsZcyQqCGO1cW/Ba4tAeD36CH0PHqGFzn4nBA39/v/cNRoO9ytdJJ0d5IRqvYpeUg6gMeYqsTPTb4i2m3OR4aE99ZeteRAkdjgz0SnDAfU7dUT0EiAwk729NwsKzys+xvIg6/R/XoQcXi6dd0b9DX9PpJcbjZaw6YXJpW3/rNkKyeVI1y+taTlFbHc1gbfxKaui7Vi//Axvr7MuoOmydO8AQg/RgFA+z9gvew9CZ3PizaZr0UM32yp+o6JwG/bi40TDZlMojky8TLc9VHtrYc+424zZtCQyrp65bBDyTJJarDd/ETrvKce5ba3bbefjnNPhJtTsYa0EV/wBoq2Q6MT4ZYApp7KhYbhK62d8lrIED9a5kfFVXD0elcCx3ndWf+wHkVTqYvT6Yf8NnvDJO88DLLGUp+mEMeJs7hBgPK6WvzC11u4UCUUMCpEsHjjVbrTD/dbItdkh/rrF5RWHVl21kCx2DHYw01wt34soOirSU3/WjWu++rGX7s1YF26ll6nsFbdwuw/Z6S7NiLwM5nBu5wWD65kGO8ONDZ3Y+lSpe/G3ARI5J4FPNDuEw3q4I6A=
X-Microsoft-Antispam-PRVS: <DM2PR03MB3985687754A4E78008F7E32E99F0@DM2PR03MB398.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 0
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93003095)(6055026)(149027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM2PR03MB398;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB398;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB398;4:Qp2yrR5nLhYdbw3i6XdqPBXczwUfq2zY2o2S4OYv60fUzIHtwCf5abg4YOSBRFgN20imI3Shcu0aQDD0JhAV4sYpyiQjBrwsn81MSYBwTFA2R0748hI5JnY6oMBKi4JGdYQYc55KTiZ5BGQCYvCWa9GQlzbeHTjKtPbgk77SJGSGL4/S+jdK6EBwlaCG480SfbBEPi1pbAVjHNt6I+o1qVGDJ2EYjo0actfPP9dI2Jsl1YscKcA73VoQ7x9R6XKBKRny8gUdinXncLVDGDQG/NAXZ38UbU+CPb+9xyXvKepa5S1NK8hX6JSdumWHyTeM
X-Forefront-PRVS: 06691A4183
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB398;23:E+ZRT4ACqyznxA737qHLgzBy05wwdebPiQdvl7BUNa?=
 =?us-ascii?Q?u1ApUnSWkeBNgTTyLgeqyZk6j6tCO+8gsAYTQj/SYvzW9YE7Ezur3B9MNvXp?=
 =?us-ascii?Q?YWgJFQdWkiKxSOOat92w3DC/7OYNnVa3CBZHCz08B4HBpijp8+MIXUlvmCV+?=
 =?us-ascii?Q?kFvyxp2zE4hsk1Tv5E7beN6jI45806eTjunFMB0m+sV0QnKlQx4vApoL+3vw?=
 =?us-ascii?Q?+K4sAl/yxzToFOkBEesCkofFLsMBIneW5dcZX20Ne7f+BU/vr6ziMRdy03zj?=
 =?us-ascii?Q?n44L9Dp99Ib5iVEtLOfTtx6pEcxfzpD0j1XwJAJfVQNn9HfU0rSgOnxoxMFK?=
 =?us-ascii?Q?e1CK6KtJb4oPOxYaS8ZY4JyHVpPpw7V9PFGb/45jpNrITmIlImaJa9KKYGuF?=
 =?us-ascii?Q?yl5knk8WW7xDqsHJRejnOKHynCC3qeym9pJyBDwt20LPkBbeBtI7EvMrP1mc?=
 =?us-ascii?Q?74+riz1ZJ6C8Y5xFCPjdgOHTHLeDiytbQaIzB33OyaW9zn4umpWtn4aH31Hz?=
 =?us-ascii?Q?hZUmNPoRWTC2sXl8XuSft3wJmn4HTNIAKmfcbptfV9LAZARFva3+QiYl73Z9?=
 =?us-ascii?Q?+iOhjSVD90ZeYDX6S4cepLK1Cbc9lM/BTdwZOZBpIcdiGj+J07Picwr41G0o?=
 =?us-ascii?Q?xNmQeFxRZIer8Cr/WW/Ut3BdViEVD+spl7gX1FgXe25vAsSMGxJnKlzBZbLE?=
 =?us-ascii?Q?fqgbEVCQs8Hxbn3unNamKoxHE+s2b2ocUsnBe9HqAJOSVFlhgei1XDlFc2fm?=
 =?us-ascii?Q?ed40S7mmesGBLyiWEndyg6akukfZ3dSMB5omH6IRHHtXQ3FG68NjI5zsFUn9?=
 =?us-ascii?Q?Hk23yB7kBpkqHa927IGNFOaaJmsApFqdxlg5CpOpsMbM11JP5O9lu8HD+Pmb?=
 =?us-ascii?Q?vS1ZCzrAD03HGP6+okGdVKz4yCqfj0lcy5YEx2YS4ytQ7APqkXdag/DXuXj+?=
 =?us-ascii?Q?IdM72UdxoKMKGZIw/n/kISzeu+jWWurk4Ha9GSJH7opSQJGgF/vCoGFHvBsf?=
 =?us-ascii?Q?61CXQ/QGDiaWahCcwy58K7sXIFoNeshlBz9DmdEctL81N0IxacjlqupgHSn5?=
 =?us-ascii?Q?okQaxS/aCypvmFzqBJ2XRq4ie32TX6Thdt41pwmg25zfIiNuxxMDR9WXEaBL?=
 =?us-ascii?Q?flAbVH6W6uTTmMcwdoZNRDwbm6rcaujt3xNFJrVkVK7AvtTaYFJiaOwbIFUk?=
 =?us-ascii?Q?R3Lw+tN3+8ERQNqCkSK8ltoL052lBt7oz1yX/wHg8mJuxefyKZ5ld3Fxz9cd?=
 =?us-ascii?Q?mfP1J/atzeZjLjhf0=3D?=
X-Microsoft-Antispam-Message-Info: oyxqT5BtnIk1NAK+xmdGW/Ixt+YJq8hJo6TPwPnNGtYo4PbaCshjDUK6t9aj2Oy0q9fkzgrd3Lg2BSbGdfM4J/L0Mlvvs6sL/Jty/gxaQsb8APMaGidx/RwVJzUgxpvJr2VEKu9lYU/LzaRzKSByoWJau6sZgpJBMmCy9E2vQ98/Em2nOZsBUQGZvhFgTbHi
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB398;6:ucW0tiT3nkgautECK+dAW9tP1E/ihEdu5XvCWuvlB1xpste33iKAmaYxtzEkDl2Vg68nYNFyQHb9ij1jcoK6kIJ/Liz+xuOjj9WxwRQoGSgyI3IyYaUUZTjCxwOOpuTNFwF4Jb4yoqqAcnTfi/yBDTa3+eZYbETwyGvpHxaTUeHsj17zY91zJl9xYCvLDWrV1pm/3WNy2QXdF2Hjjz4s/MWaOG39EkYMHEaeR8OIFY+vex8udqLv8WxXMrdE9cmO+mKpAWSzwJtfRwSHeLfXXS5/GquvXcbW5WNT+IjhtWJ0bpOtLYQd7zHzpnivSNYPNmCc+aWf8poNZziXn6tt3Mk9zEoNQsVPuE2CQp7KTYRB8E74bm8VuWnO5f8L+nEuq3/hUk/l+BMRvqVrVQIynUTuQ+rbMUfBjhxYsAH/iCryu3GNp7HsBWFnk3EM++0dLUMBqHh8KxMPNP3te/xu4A==;5:Jg3Pmvw8iishfs7Esu9Lg62yawhaidPMxZ92DbzbWNNBsEm98vHOmXY0USqZX2udFYLLG9hCBKG4EyD9wCZwulgy63vrGcAvg2vpNOl0tb4FHqfI2tFw0rfUY/y7oswtlwF8KPwNN/3szI9Lc4PYMUsoB4x+lswlCI65TE0ZYbk=;24:DLBMzBmytViFwFZBIesWtKQxQ+CR1QSiG0C99cZuBX+tk95x0X29C6Br12K+msgcfD+dqNgy+YnY5LZh7OEXmbo5bRQn0OQ2cu1+xkqCgq8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB398;7:06xQhtF0U8JdBDtDMOip0SWqfr/nYinWrLH6r/1rJ3AhMySPSutqe0NP6UH5vR4PO9RHOOd1jkAlgpMZrtgtEeqwtZHytg3004OCucHYmyQq9bFwf1jmUSxGJ7MSNvCrRirsRh//qgZw/sVJO71HZt1emkOYLXITKLrONM6OZom2x2SPG1TwoUsUp+D3LUqem7jeWc2njRHQ2qoVKxHfc1X9RTpDc1n1fM4dYQrOPYd7cehA66N3maN9LhZxMCR2
X-MS-Office365-Filtering-Correlation-Id: 13654a17-5620-452b-e933-08d5b6f0828d
X-OriginatorOrg: freescale.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2018 03:37:23.6701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13654a17-5620-452b-e933-08d5b6f0828d
X-MS-Exchange-CrossTenant-Id: 710a03f5-10f6-4d38-9ff4-a80b81da590d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=710a03f5-10f6-4d38-9ff4-a80b81da590d;Ip=[64.157.242.222];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB398
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Ying-22455 <ying.zhang22455@nxp.com>

Add the identify of the platform to support set the rcpm with
big-endian or little-endian.

Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index ffea97a..754ce0d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -679,7 +679,7 @@
 		};
 
 		ftm0: ftm0@29d0000 {
-			compatible = "fsl,ftm-alarm";
+			compatible = "fsl,ls1043a-ftm";
 			reg = <0x0 0x29d0000 0x0 0x10000>,
 			      <0x0 0x1ee2140 0x0 0x4>;
 			reg-names = "ftm", "FlexTimer1";
-- 
1.7.1
