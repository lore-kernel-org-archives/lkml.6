Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeEOJR0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:17:26 -0400
Received: from mail-eopbgr00057.outbound.protection.outlook.com ([40.107.0.57]:65269
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752323AbeEOJRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:17:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx7d: correct cpu supply name for voltage scaling
Date: Tue, 15 May 2018 17:13:29 +0800
Message-Id: <1526375609-17676-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TY2PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:404:a::17) To DB5PR04MB1320.eurprd04.prod.outlook.com
 (2a01:111:e400:51cc::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1320;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;3:/ZOemDWkzDvSSQZtecN1GZDn83KxKxL9PGAaXY1287RizVKinxPCGfZICFNS8w5gKXyIckkajKUhQLj3ARpamljcdbe9MZ9I06fmKzUNJGnLbUUCRhH/3UIW/5CYmhPRpnZ2mt6k/rACEUuaSVY7HchjNC2WNZUVbjUZ+ltBiYa+/O7QNDsA1RO3VtIv2K/WMDN3mMcilfRPstEJYEJt0rzRTyMbyFFp7A0nmvg+FnAvnN1Sf/ujU/vuXYAJUtaE;25:eYQdweZFC+WHabMyFy8hTEQcA5eAMgGFw9KIXbHE71y8qbkn4UHVDoB0JbxCDoPwTCdiv89xxa1lchS4ldNhoHf6sT3rlsm+MqUh9KXZWsgJvkaCcFhxfYRZmZ2q/hSs/PoNiESpAjmXIYykw01+HqVSUiY4c6qMtuKHlsqhId0taql+azfBhUtEYQbQQZh7jvDybNCqeRMoSpOMExOukA6buaOMeruFGpfFqCNOU6yLZpIC1krVXtBQzeJCrOa17EzhapOaUzE58bXWrjgOKnM2Xy1krUtSisf9zmWKqvrC6xioZSBMqWEx/0XAuL6Jv+7lzfJgk5lys21IOyKy4Q==;31:WPbJxhoXVdNwYj8K1qPM1hf5Zv3ybhCpo6nZXIDWtufCQwketf1ERROD8A+7UBZzpg4f6H6Q9Wy5nRsxzg+HUzTLh7M/xie8PrPnbycB4yVWaa9goXRZUjmu7Vzk4OrvZJaDgGh3henGZsjoDnZPpm72Zcyxr5K+jkif5X35iQNvamG7xM2ZBooSFt1sZ2gJ0rInrV7/YSIAxIHBJ1SKoKMgjKjz4dE6rv38c7GlSGQ=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1320:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;20:JhtHZoVpq4U//C3Hn35pwx4/2rg65Zg6R1gcxWRswEX9MaeTG9Acn74Y0HEAlQi30ebdI86KohOnOgye2Qa4qUFmQ6UDvwizvinxAGonfCnHmsJ5aA6eYkfsDUkiN4FOE3ptaGm0GXYuynQYBSS6I6qnfXYIhbAgKUeVMa1Iac5j3Z7tM9Ro26g0RKUp+XmhwIVgn2tI04kffKaHA3FdWzBku6kffUQHwBSz26syNmaYXqofj/q0GeQRHZ4X00WZHfKzh96FEGblmORq1tRJz0dwf2+IeEobxXp2d8Dei2JLD+UvFBl+17xD9pMwyfwzkeSGS8BdMvCH35MQCv/QMePnBHAJmggPpgGOCB5O1qqNj1SddZ8SWfKNeuCwgWOTpXI6nbf99dQyqQuujOagi6nIwZ/usyIgVVpa8wRDrQFK+bdQAanTsovqz/XmXcIH3LtO4CDXRgn7EAnHacsidtUlhqnX0l2DBVI3hjQE1ZcPKQzjrBTcZUpBkA7o+1km;4:6eVPNTvrAqugd3Em3rh4aOXrDJ2IlRrlxkXwToVvoHAUBzOMTuRLiSTKyyJBvLzQCm/cp0CfNNEMj3wd4P+eyJEd9M85vtYLY3Dcl4liSIpeRNJKJATTvm/AzBubC6zxnOUmohFVpeg/F3nyklYI9p2Ol1hRHjh06CQRzNqq5OInCcz8YG1g41zCdbXbUgXTQ7xCxvHFrtN2VqZFHM8NCdd1vTTzR/sa7HwjBqFMAWXyGFCuOcBoRLP1L/hUzYjxo9CE2YIUnfYVPYnos0gQouXETR7ufTaG0ZRYH19SyqJB6KhRlQWXBkmgzhNEFrKX
X-Microsoft-Antispam-PRVS: <DB5PR04MB1320356FC90875FC301EF214F5930@DB5PR04MB1320.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB5PR04MB1320;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1320;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(346002)(366004)(376002)(199004)(189003)(48376002)(5660300001)(16586007)(1857600001)(68736007)(956004)(2616005)(53936002)(7736002)(16526019)(6512007)(4326008)(6116002)(186003)(3846002)(106356001)(81156014)(81166006)(36756003)(97736004)(6506007)(8676002)(26005)(476003)(316002)(386003)(305945005)(52116002)(6666003)(25786009)(8936002)(6486002)(486006)(478600001)(50226002)(50466002)(2906002)(47776003)(105586002)(66066001)(86362001)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1320;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1320;23:X7CwPKMNe39J5791zQohVQPRSilP/W7k5Yy7+1sVF?=
 =?us-ascii?Q?PUgBvcKGl8x6W/f02G/i+c32wkmQtYOjdteMMMHYJkKHsZGivU2exT4ypkzX?=
 =?us-ascii?Q?THbQro1msewZsqPGgeAhMWX8C+PA6uujUw2pbcfzG73StdvG8iMIs2RQ87k1?=
 =?us-ascii?Q?q/xVrGVt5+3i+5TyamzY2Ltala4bi2tUMyP1vDAGH5k8gx9Asx9Bch3LUT08?=
 =?us-ascii?Q?mfhnOEbLa51VzFDuFpgFqnhZZAuP4WlCtxD1s/m5Nkx1rYIB4Zr3MPz87FH5?=
 =?us-ascii?Q?Oe13GdahmrE+KTpLCBbF4M7GaUuP/one5DthxuZzbBB9xByxJWXj+6gAscjk?=
 =?us-ascii?Q?0hWti6hyW6HBuqToZh7jGo/fpaCOf4zuy6FzJFCwd1XCov55jRy74FO11qzi?=
 =?us-ascii?Q?jAMon/LExgNuehs/b+GAdBlEtTs2eLtCf0DGiIZGYaaiKPlagzXqRvtMAFsq?=
 =?us-ascii?Q?kvxJb9MnQ4iTfoKRGLYX6Mel8H5NWQQKVh+I5zCglA4r4LWCe5iDjoY5Q0IX?=
 =?us-ascii?Q?6HAgnV4zFQta1y+LUq7nBAb704/oFcxwAAl8mKnzwgqwz5JCE03dVQ2GhVyR?=
 =?us-ascii?Q?fDYhwgwp53MOWr8kve/h4BZafeZJy1g/t3WqtOxLPbGL/VqtYnamRm0rDEvU?=
 =?us-ascii?Q?wnnBLKj4GWZ3jVW/ysm+MMAZ81opFOZXfPNF/T5pE3JKET9n5r2rVHrkwyZl?=
 =?us-ascii?Q?481soIRtb7Ls1WEg13l7IB4/JhhzXJIlxEahtWUQc4eWHFPJ8FNOgEkdh1qj?=
 =?us-ascii?Q?BVkA7Kmcyy9DaXCMnGdZQWycZhZdi+Iu6VxE4+PvyQ/TZKSfTjjFVl4dmNyW?=
 =?us-ascii?Q?bKL3JCNpKQT9azUUzzYsrFjxuUSVMCscSZkn1POWmt7pW4RzDjgZ6MrZONES?=
 =?us-ascii?Q?QxpZWx2edTpQ+ab5vVdfpLuxYqlT1cHwbmMQxZcJsKO3PZClw7jIOu+39C1e?=
 =?us-ascii?Q?RxbSWIlVKbWxEJBdogzRSccBWc1z/6HhcClIqoy5Wa5IyvZSfaGbLxSOesSU?=
 =?us-ascii?Q?ddMqxVP3E0jhEwbKv17snoc7Qiz6DDTXt7vdBsH4G9/H99E8r3CjQvbp9ym5?=
 =?us-ascii?Q?4PU99+e9FIRh9m1TJK/v5ROlA1jkDpMLNk/TdD3ct5fTpTMpxf0fPOTVlKra?=
 =?us-ascii?Q?ISXlzqC+bs=3D?=
X-Microsoft-Antispam-Message-Info: 7dqnAqciY4a0CaN4Qx16MEylOD5jchbtpi59Zkt7obJzhP104mDf1UyxSrBAi4LbrVOjziJuG0ysKDOGP+j9vpBGcg2KCyIGgR3pJR9zCAl8a8FYwZtrtRYWn0rU9dCEwwo0ji87Xw8lwvtSkgz5M2G6L/rkbUBaBNHYOsilMky0ejmlkoQ85h+wgYIeYK2J
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;6:IKUAA0fDG0VJvj44JvpfhAlpU1EZ7qV1gTikORc721L1jO39CF2kl9Zlv+SqqZTOvX6WWrf7g5LhEBhg2HhHgvC69vJhf1uULVkljLHpNmfQvZPdlfDvfellzw0dPa/5vl7/xOxbA457ViT/ZSRD8MRQWToZNW/G6c0nAM1uLnymvdw1AvDmMy5IDEYbafLUeOk8fjMll1BHVeDxbLXPPup8B6kXASnuc/YMfCuEP1qKtj+YPBkHBr2y+d8Mzl50MwOPZ1a1ELK3aqJ4O8ogFrtGCfZxu3jpj82dM0x8OViaBtirKTjrs3LEZ4ktzn3TKxHeNL6PwrrReGh/6keVwBYXfb8geDKs5bIAv/m3tiPUUqYLM522cfnMjjVpYhbiLE7tLKXfduoJ7jNiAcRtC3iYNJvrFvyn2aJXZ3dMKPkyAqKs5Z+RYytuMcw2i9Z2YFSUxvUdve8lZQy3XFkAMA==;5:bRp1vQJ2b6fRHObXc5GtOdvC8NywoNfg3Ii+ORTgh5yyTG0xkHAiyjKe7Ys7R2pPQu14N1hNXLHDiPY/q6l15s1BAaoxFCiNCXQFkSZZluTQNocfs4X6E2EcyEyAnVm50IJGypQi/WV3dJQxoEEaMB3YuKPMre9/pg1gMS6yQnA=;24:LYg2a4OJEjiJUdX1b2thHaZoKWxDSLmBJNCXkkpltMysHrx3CbVFjM9WR8/JS1cryzrA4x5t8yNtjUySNOLXnpSGfbKT4EaR6iKr3JDntms=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;7:6LVn0YEU3NJXhxHBcHIOFxtslPltGaNtr/ZyIyEkiNlh3+kdC7sgOCGB5k7v3HP/IwD2wa87UM1Qy5WEZciS/CTXcuFT7WE5takaLKCZpNF1q1MeskKEdA+264FahJVOHGoxBepPKedjZLTR8WOhB3m29LACrxbO4OTQUFtFZu/j94TrYRONZ2q6nM7qMwRPzztKhD2xe8XwobH8olYUThC/VV+t48OrsWpYa71ahN8SqiDsOKxM/FaojkJwYM6N
X-MS-Office365-Filtering-Correlation-Id: 0500d9c2-3bcb-4577-de6a-08d5ba44a717
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 09:17:09.0128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0500d9c2-3bcb-4577-de6a-08d5ba44a717
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1320
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct CPU supply name to meet cpufreq-dt driver's
requirement for voltage scaling.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 4 ++--
 arch/arm/boot/dts/imx7d-nitrogen7.dts   | 2 +-
 arch/arm/boot/dts/imx7d-sdb.dts         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 7f64568..60deaf9 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -33,7 +33,7 @@
 };
 
 &cpu0 {
-	arm-supply = <&sw1a_reg>;
+	cpu-supply = <&sw1a_reg>;
 };
 
 &fec1 {
@@ -284,4 +284,4 @@
 			MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x14 /* OTG PWREN */
 		>;
 	};
-};
\ No newline at end of file
+};
diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index b8e73b4..70c53e5 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -144,7 +144,7 @@
 };
 
 &cpu0 {
-	arm-supply = <&sw1a_reg>;
+	cpu-supply = <&sw1a_reg>;
 };
 
 &fec1 {
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 722a45a..9408491 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -141,7 +141,7 @@
 };
 
 &cpu0 {
-	arm-supply = <&sw1a_reg>;
+	cpu-supply = <&sw1a_reg>;
 };
 
 &ecspi3 {
-- 
2.7.4
