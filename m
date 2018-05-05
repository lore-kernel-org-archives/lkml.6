Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeEEIdb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 04:33:31 -0400
Received: from mail-he1eur01on0049.outbound.protection.outlook.com ([104.47.0.49]:46912
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751085AbeEEId1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 04:33:27 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, haibo.chen@freescale.com,
        fugang.duan@nxp.com, aisheng.dong@nxp.com, yibin.gong@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 6/7] ARM: dts: imx6sx-sabreauto: add debug LED support
Date: Sat,  5 May 2018 16:29:22 +0800
Message-Id: <1525508963-7986-6-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TY1PR01CA0199.jpnprd01.prod.outlook.com (2603:1096:403::29)
 To AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:h1Nu22GWTKph+AUt1wD3YxiKrVviMmR7U/NoX7xlJ6hZzSSwy8KCLx8TAzH0RJ4h0EOLqiQSHKkVCl4dZWuuvryUzbA2Zng2V2CKLSXD0+sJQjsOY9mzYRLUjw2lFaB/0rwt9RIP6nSwD/ZD3dvmLQE91MQem87EeOooHaI2Mlo8mq2Drg9RSOxBVY4mEKJaOMMUaeMETfI2bQ1lt6cuV5/eKnpNFpH0NLgQxvU8E/SJ6XocvpvhId3V9aRqa8U4;25:qxURWi79rUHxCUr6oM5IA7oMPuorxmCz5jtftBOSEm0JyoEtI4o4a44d2sb1GujJ+2kuboz3jpq7NF3LHA3YHHScCeMUyjkFWgRrBiZS3t4U1picEusbxM6xZKeXvSfKHTFlm7RoYOoiHBrE5y5iEH9rSVp8YMoi6LqAoFX0J/YTGf+zz9UTWWHq5Ei6UZx3x/19B4qFD3nkKpOsAe634NpnP7ulprjbK0nNcyARtKt1FVU10a/rzeikbjOkEvpEQ48lGJSbq7x4UmN7V+NodgfoLHAX26sWsSs7rxNSboo83P67vsJsgFF1/rbp2F6Da4iLfANErhIZ9UeAdgZR0w==;31:kH5d+Z9khLlvAwED56TCgK1LuhDLiIanY9pBd83qprZmWfJ6Gzc92a11f71W2HloPgxt6yhEELOk0GB3VEwjWNFwtf1xmbtENZWlHvFCA9bBnoMUKRGGUw9J81xVNe7ZtFlLLc9vZIAKUNtjokh0ojhwVU1D5IIkNpPVVwwz6kfyPpracIL3Cd7acOGpsJbY3VABIiNXRnbNZSpShDLR9fGmDQgnd7k8/FS4qt9ow5g=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:ow9x7F3wNZQRq4SV7sSmcRTrTD2H2e0+6YV0Ju5H9t09plYpY3k7Gdm1jgf+utq5mCTGUN+YRTMusYe92RHLBQbUhJMfZwO5ISQugaYykc71AX0dun5HlBzhf5TyKDyKaeNWphXlH5m6B2P5xAt/2Xpw/fNFzFd1y3N49Wygd/IBAJnu4iaXfTMgzHm9WFDSFatT3QsJNyTKo+r1EkWSsi+GO2if2fP3mXhcMhrDtoctx9hWeGz7hWLbpWiZ293VtQDJzdL6CsKmRGctPPXK6vE/GcDaXlmAtqRoTYN0DyX+MP8AFQqpR4XaQx7jTP6W17NUf8ykLQG8V1VGi4oELVR+OHhNXG9W1aAXA6G8AeZSSCcMTdb1xy0lW0LG5KYHL8tx8pfGuaDtE+gSz+G401Zbvr9ziJ6F3AJ9q5pkSBGrMaJz2vrRa7IejjVQEI1kwWUCR5WA5W0Lz3PAjRsiJx/dxT1p3mJZu8Ll4J4hOvIgaSi10pnkFlmiUlUJLk4l;4:5HvRS089ZxxeloPwdg5a3S5ZpejVyhyVmGsQnM8W1G+dTK5Y8hu2e/BzKDjboWxwjqDVgu+begZGcM8P3nGyxyvYc2NNrLUjYNoI3iASTa+Q5eCLF6ESLTVGnFUnhM59nOXpLmA5zfnfiE7F0xLejiUWRAUhc5nGU1qjLUmUPBL+bXOstglAn41gqyeihFebWEfSVIycXXETMXt94ndBIZVZxt4J8y8oIGuM8Qr6VVUqevp7mbzTOuw28K41n2mPU1KU3OvLeFJEcO82FreZe5CQIQ4fLwlpCdN1cOK+cyySf7xMBn7gqeTJqWTU/HQm
X-Microsoft-Antispam-PRVS: <AM3PR04MB131512081A79601870E8F73BF5850@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0663390E1B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(6666003)(53936002)(81156014)(68736007)(6636002)(7736002)(50226002)(4326008)(6116002)(16586007)(6512007)(3846002)(8936002)(575784001)(186003)(86362001)(97736004)(8676002)(25786009)(16526019)(66066001)(50466002)(52116002)(51416003)(478600001)(106356001)(105586002)(26005)(956004)(76176011)(305945005)(47776003)(386003)(2616005)(5660300001)(316002)(81166006)(48376002)(446003)(6486002)(6506007)(476003)(2906002)(11346002)(36756003)(486006)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:wmsJxvV1G/XkpN6W0fzFhv3fPZwz1sr6e75VFtj8Y?=
 =?us-ascii?Q?MrXzD4gO0F5lYQlAd0r50PRskoqPmGRLyVY3e6zZCdiwmGQIkWA3mjAlVgq1?=
 =?us-ascii?Q?R8jAffcL6PxaVcCPqTAH0KzWY0xKjbn/6QgpytWiSyFPPcRoDlOEwADbO0hz?=
 =?us-ascii?Q?x+qLuCSfn0h5M9esPU+4osuJ1n3PadpA4VrkVYZ8Jaq9EgHGEY2FsSKsIrgi?=
 =?us-ascii?Q?0wwJglBP1vRnS2phft47rSQbloCt3akA4wbLZRr2SVuAcCw8YaYlYWDw4f64?=
 =?us-ascii?Q?EhYoHXmdV7lSmSgQlpt0A74+zvLPLOZ3a/MKaMLi0AXX4bivF8uoGTDZhSQL?=
 =?us-ascii?Q?6TUhaRaEiS8pePVeOCRYJZN1BV/VWJyOTeWLjcgy3Lp++ffpJOTbKu+7kVWh?=
 =?us-ascii?Q?JzbJDc9PKNpFZLjKVHWIfSbJVyPHn/IK1YoYfHsJdeqFULrIlzc810DCB1aT?=
 =?us-ascii?Q?m112m/09ABobDQ+N3gi8dYfvvoWzAwFHEAlltNPn42+K1YDPFJhTPHKWc9MG?=
 =?us-ascii?Q?nDcnSwNonl1KjjFbRDN09f/G5wTDM2w9hRMDh9cfRMgqImO2UgRpa+cieVPU?=
 =?us-ascii?Q?HV/hLKMWRjKxSxOAU3xtoNyguW9g+qpuOiv7rfW2RI78cY2GYwW8JVJrw5vR?=
 =?us-ascii?Q?2udQXdVEDxYLcedgIapjtoohcQesO6rGVjr41IOsDrsErMV6RwJttBr39Wjv?=
 =?us-ascii?Q?SIYPTkArk76jskXz5FJyAiDp6rPtEYjBcgOEC0XAGAm65B+Hwe6LerzVHJkn?=
 =?us-ascii?Q?64RI5aXoGMX9n4RWX4IjRpE9ger59WccrbqERBBRaxuS0WgJ3wAU7GR8qw6C?=
 =?us-ascii?Q?7JjyGuaJphEXUJGWHHx02Qe6H/nu01Cc+wduMPn+OKlFbh9hAcTA1bSW3FF4?=
 =?us-ascii?Q?8E8kQffoCS2+LGX3kXHh7pqOcXnO0zQN1eOlro383q45fxWV5A8fWuBwTorU?=
 =?us-ascii?Q?DxkqGOZ9nSY+kwiymusLRHXOCGgYvCm/dc8xP10mx66cpzNsCp38dUldiA5a?=
 =?us-ascii?Q?n9QRMnQvlQEUg80EoPswerpHXtfsENmThf9pQu4ORgQfw6IotTY6ulhtCwv8?=
 =?us-ascii?Q?jjUKZ3GTuTe30b+dhE4qdfp2x6AIAatTYF9Qi1jIeFcTdWjfW620lBGsdaib?=
 =?us-ascii?Q?6sGta6SlB55q/TerBxUYGlplvPBdFMRaGQzH53/DM0Q1Es/IuD2wrvcINK9M?=
 =?us-ascii?Q?dH/UOkrVcVLF0K5KHHuv1LDCbqpEdvGHm38BhofeQtOACKZ3Q6NqgWAunnIZ?=
 =?us-ascii?Q?FIEvop7x4Y0gq64cRA=3D?=
X-Microsoft-Antispam-Message-Info: MoQ9ahHIxIkuGAeOXplK42gGTXal131EVtfiGIHaoAo8P4lTqW69t4pMsZwt2Qrn94PFGu5n5h7/Mp4Vpg1PV46B0oEMeX1Hr/kizKb+XRGlZA8RgGp/JQKZRJuSXqW9AyxzfwAonN+r0UN53RMwSKfxahvVRULrkMU1MSoTo5lkyokGSAhx6h35Ub0gGTfn
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:GLlAomEsj2v3a+47j/EEYP6ObHNGx6iVIdgseqa+0sMihVWlrK3E4ARM1TE3AnmNTydb5RNJGQ4R4k2XMHly1Nb3Geb9Hr7VjFL8wZA2I1/BKEbGXBubF6lQnhlfGcMnAqBU7n9jhzeNkJ0BQzAxBx2qyEultL+SJbfCcuOuKZWm4JZTvlqAISJhs5smtLBO0AaShqPG8M+TRIl4EoLgI+BW6lsYN0VE9Z3+RL73445HAdTfaP0e4k0SULOz/zHFA8ZNYLv9ASYLAT15Oo4RrJZrAXoyinY/Ntf6HdsB5bLdIl1vicExdWPqyI3Om67gn4pEG5h0TbJhbHkPSLzK0/MU10Q44Mr6TdbgSkdKHLGdypvhjdJPgeFryF4ptX94P0Rm3mdu/gVHBYDdsv8kkDI584UUrO6gbY1FCLPcD4pUTPR4cwRUolqtrXHeASIKOI51ezi+vgxpX6cZ0R7UCg==;5:o8e+6MdAsGlGHW2CkkjtJHjDNpcXezQk74Mr+8N+rOLRKa1WtPIhYUJ4JAzf8CBeuiBLARBeKDXmhtel0vevMwHOP54lYB97J2scd8sA/3JmqghCgl5ZK0hzuZcXOGv10NiwfWzDNfYIhyucE8IoOR/6gKM2+FdjVhTOLPjHo94=;24:0Lt5ravBHRjbUfFgnMNVLBXLbcDfdoATwcmB3sTrO71MnTxAE2Vd2lhQX8IY2ZuTXU9Lpp0HrPkAKmwWn7H932mRcbdjD6aCBmOXK6WmJa4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:xRXZycGXJN+q2a8zpaK1Ap3gEgdj1vur+6yIBn4nEa/YVhk6UzSMp1ePp+mq5FV1dX+vnND0xaLfCUlJaQLC51Rf0lFDcABo4pBl2zKuZOu8CRuIBFhmiwnTvbKTmtNDMbIT3W2hfOKAP9pw09kENYdGs667FAVpxDuk48YaJPY4671wWz01uOAUWldzTVY3604Qw6AxeDLXJLUt5TcFUUuBbWqUAPjS2oF698tymnuVyLBAof0gKgUFcCRxayDS
X-MS-Office365-Filtering-Correlation-Id: 094b6832-b389-4e15-ad84-08d5b262dd31
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2018 08:33:18.2222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 094b6832-b389-4e15-ad84-08d5b262dd31
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a debug LED(D11) connected to GPIO1_IO24,
add support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 13de77b..1dc5b58 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -18,6 +18,18 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led>;
+
+		user {
+			label = "debug";
+			gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
 	reg_fec: fec_io_supply {
 		compatible = "regulator-gpio";
 		regulator-name = "1.8V_1.5V_FEC";
@@ -160,6 +172,12 @@
 		>;
 	};
 
+	pinctrl_led: ledgrp {
+		fsl,pins = <
+			MX6SX_PAD_CSI_PIXCLK__GPIO1_IO_24 0x17059
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
-- 
2.7.4
