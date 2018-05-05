Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeEEIdG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 04:33:06 -0400
Received: from mail-he1eur01on0077.outbound.protection.outlook.com ([104.47.0.77]:48522
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751057AbeEEIdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 04:33:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, haibo.chen@freescale.com,
        fugang.duan@nxp.com, aisheng.dong@nxp.com, yibin.gong@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 1/7] ARM: dts: imx6sx-sabreauto: add PMIC support
Date: Sat,  5 May 2018 16:29:17 +0800
Message-Id: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TY1PR01CA0199.jpnprd01.prod.outlook.com (2603:1096:403::29)
 To AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:vnGFnbH1DnFngmyG5D7bGOwu7dxjZkQnPcPWfuMBO0C1AIhlpG4LTyhZgog3CRYOLo8I/tPnK4lq5c828jwpYGZLPVlQIjx7NfUmgVSonFyxUPaGdhgH6zmKTmfS39tQSv65alrJgSXjyZlW73l4qQPk5/E+boRJeea3rYtCEc5OtJXMFAXCbv46rACA+V0gnQ8QmvbA3CiuCD3usZGI9w6X5YEGJlK9FNs82h+DMzta7XAK2ffa7GmZNmzPuYPc;25:fMWTYY76iHVfSYiPvrkBaj8HLyompB7tzKt8rABYr46kjKQhZ62+TL4LAe2Js5qg7jSZg5SzENRySgAPhKJLP4FUSMCrcS/Z0qKv7wo/U1heaRlclSJm01OOrST1Izm5o13tID/MkVGAt6lm5dn99N2BYI21OnHZhJ35cvwNRzuuiOdZ4J7hQjyJbUPeTmJA0MSjo7VRtETwlD8DmvvZCLlBHCPjBLacFsKCn1jIkJIohShrDibp/o1EBsJSf4Dz5oRL9qCoQwzkakyDw8fmULASMBqJ5a3CjgQeCu8deIJMmjG/kCJhj4ED3IFiaOVz8AkwqObICjb7qKPD2A/WOA==;31:IdXuzxN8KbPmxEMhW5Izoi+D8RP8GSJB7pQ70eoHNyLUpUPyw8im9pmAfiTVia5QRh+uUlqk5E8ZQ2bv6iBb6BJ4iF5ENy6PB7vMyO1LeHaC+AXTpy0MDpP+x+QnGSWx0dAsvQN53bbVr8OSuYULCWUJOhBFrgKPcVeocQqMJYGPLz1+vJkjICHuIaCROE6I6bEnJYYl0WW95K5i4vlNrFXm5khftu8TBfzGVAGNEww=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:TOH9tVodn7tmClpg6njfPWGPHsXEMNEP2O7AKg37MMXDk17M/NQDAnMkMr52HVGx/OSMI9fjz72bPdER0inpvludXFNiuFn8dzLMTXkXewFcFVvipsaZLkVM0wbrNB1FCk7JYV2LuqFDuB765tABBVxuhedd45lQ5I1HaylKcWwhDdpFFZqf+VCikIW2vjZRNz3LzGMwnm2OMGERvUukSo71kGchPMKX/ROIUmzIuFeEZpDbplNeuktnfdEqM/dYiIeHioRGW1ya/RhidIBLgCHYgj06p0HEOvDSDsed24aUcxNxgvqdS4VXVbLVz9CG/e2xt50MNT9m8tzgNs1mE6weksYglqFAoSatINaoNwRCJTabXK3QJTze92/cwnTjwrU8CjwQZUcWiURiuiMc2fkWPxeKRvh+yfaEq55ibC9qvdC2inxHjVgqPTphFoMDp7JNJUXXpohsk3jd17Ji3l1XNUJRq+rcuBUla2sT4AWLLwnQ8xjCBqcneAdjYizt;4:NBf9o1XXtpUOQeNanwbd/XymgJYLdVdtvuV1JW2QGv9x5vA0MO36FGLUxWQeNedzFtf/Nb6xqi9wae4RlWsPnoWkn5CvaakqVjwrSdZhdPlZKxo8A+UKJf0o/w+2cJOzQb7PcS2YqLG4doU8Jo4fptz+kDW0munyluDtlM0LTx1UnAqtsEYNw6lComaNiUP0tx7QCtUaqCYpOvpiLlazp1WllLY72TDHNMXHooYMitUJuRHtmDeNo713bJ/HeWnzu3U2WUdYFDpp4amSBORTPgjSicKyzdG8+3OPwHJp/6x1sA973xqgWYEHI7IN9K3m
X-Microsoft-Antispam-PRVS: <AM3PR04MB1315D547F9E6066837AE87C5F5850@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0663390E1B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(6666003)(53936002)(81156014)(68736007)(6636002)(7736002)(50226002)(4326008)(6116002)(16586007)(6512007)(3846002)(8936002)(575784001)(186003)(86362001)(97736004)(8676002)(25786009)(16526019)(66066001)(50466002)(52116002)(51416003)(478600001)(106356001)(105586002)(26005)(956004)(305945005)(47776003)(386003)(2616005)(5660300001)(316002)(81166006)(48376002)(6486002)(6506007)(476003)(2906002)(36756003)(486006)(32563001)(473944003)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:5aW1eBcl178UZ7manW6sfMrGobDCsA13WVuHGI5Zp?=
 =?us-ascii?Q?fve9KV5Pi9/FCmf2iFSVb17olXHO9f1R22NelA/nUvkepzXxllsK9esItIio?=
 =?us-ascii?Q?iySEoAWX0o/N486yDDGKe9mGK6EmQrvZYIPS9bU92J/G3XM9GRyysvS/Z3ZL?=
 =?us-ascii?Q?+0cKuhDmAI3sdpkXNPtS2obyhOvPx3sHg4F8PEEPPE6mflVppkR1wIIAFXzs?=
 =?us-ascii?Q?Wzcv+yjReYU1RFE1LjaB6PNPS2WoXliC+ctpMtWDcaqapdU06C3YYRbauLaA?=
 =?us-ascii?Q?AxXUbZJ1cF7+DOuX2R30dKILFZIUnLVD0sMS61OuPQHDQ3nfKowP1xefTirz?=
 =?us-ascii?Q?kExXMvLKiI1K49mJmxgSN7f3FbWyScJzZD9E8Yx0noqBgIYJlXuRfWp5jnWc?=
 =?us-ascii?Q?Ur+6kBGxF8Wk2G0jXOfsB4XjgbvPmnurXKxsTIiW9FPK65S87sgIxnKl1ApZ?=
 =?us-ascii?Q?+3TwiEP7+2SUpV4+dfd/JNrcy7hIvvUZFVuJw2polN8uo77RZyD0eo7P03I0?=
 =?us-ascii?Q?Ptl87DXLRXnHudca2vsEaYIq6PfmruHaEgiQB8uYamz3OmbyGfE+87oqVHpr?=
 =?us-ascii?Q?TmH6t/LclWjQI+5ESqoS++eL6Krr1BgSMgNngTidyqJKMzElf01Q0M+LbDQh?=
 =?us-ascii?Q?8XgRcJi+Fg2AFRv8rfUtKop1JWu324Bj7pWOCeCjNt/iPP4VD4vA+Bd7weN2?=
 =?us-ascii?Q?MeWpA1MxU45FVT62IXFERuY57dpcd9u/tOTqEg8CUt0chn2tFSVK41iQPPmj?=
 =?us-ascii?Q?3sJRSYTLABpZVpeGO4iwoiWrcCLPrTB+JJ3mDftXzA1mLGIfcVBB/H7o543U?=
 =?us-ascii?Q?kdil2GbxrlQv4BNZ2+GqWAPvK/TgaRvZwR812dY5sfQiZ6poux+1ch4JyaAM?=
 =?us-ascii?Q?gwtMdX8GyHGJDV/SftCVH3VtcRi1mumLNP5womAWQ3UxuBlZhB1bS0F3tzfA?=
 =?us-ascii?Q?tiFquvNCXMNL6PAwdJXqjLb1oCdDxBhBMS1hAgMzeOfjZim/51avFUQS/oVz?=
 =?us-ascii?Q?m+MVGoTl7IYXdAnEJpJSkDg27Pe4oMMPcTzxNUqodkneKOp5k0FhWGALHyLM?=
 =?us-ascii?Q?6jOIGr+R1Syoef1mGmRFgsQSNiBX9m5xQIt8DS0/T7C2yLHeSwd9ccIMtJqY?=
 =?us-ascii?Q?9Mu/UaZTwFZnz8kq8jd641NL2tYiQbe20cX2pdBnZN6kcrDA0erlpcCq/PTg?=
 =?us-ascii?Q?EEbz08FLN0mtTKf4Eh0MURtw4bc+ZdH2zBXgnLcwYvm8T8xmjpi3Kgcyg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: m6F9FVj2rDpe/Cspcqc/asrQbseNo8pcFhyP20sCTuNLlwbiXENYQrE9ZL8eHrlPBC5YwtoMvgmFvGAKMxMlibjuOr5CFJ9d2+rOZbU8wLaNsvA1etcku/aSErOTIunu6SVAHnkQAdGPH2FruRlk6TX3QCR98Ss73wytzdFHNJ0xgiDNQlHQxhh156A3EcTo
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:2lh8ap/nA9VSvBQ+ARFE4bXBIeDd6cYMxCZSC7FC7oKoMvYJ9ltak26tXMOq3ubiJsSpHJnOlW8CKgDVVGjebg3goqO/LMya5tHOokxC8I224qz4ODnebw6GOWEkqLwh7LfzXV84tp9gZB6HlknCAOR9xSE+4UDmF6njo+ar+1LF5a0FDqaiH6rnKSSV2zSM1eLAgzF+C1hLWCY3Cmiaq+80rWG7zgQ9uRfEzF8XoCofQ3/eFpT6X/RqNSZ7BFy+sZcrmeT62ge46OQ35aTNxitLl1q8pkEKoXa6vCuTDysjEsxti1WXZbpuJovWyykNpBwEOE/u419AmxycpYXitLLJ020QbbQOSH083dGIVux1R7icSkwRm+jLQLcMYiUi3CwpBrf+L76YC/7eLw1BoyxH47W5QwA59LWH8Inea96mQy7FFkK70pRoxR1Po91f1fMDQZPikk6d39S+GlKhUw==;5:krzQfK3gSXfcHYNn0OpgL0PW0rzr0v18YmyzmK7fg8v1wjulY2BuRVEbv3Xk2t4TsOUre21DOI4C2UExEnyRK8nM80OCVigWzvg3GtM7ZqT7GMQO/KryuPoSOjYgz8Muw+aoH71/IumXnlghIDiPkSn6IJSWZrbrv91EnljDTOE=;24:+tPPP+UyXHo2GaPGE+BCnCmAErd66GUMLkBqLWYceKmmGG7JZNK9of/u4mTk3dtzBq7jcqdqQt5zQBK2T/iKXBFBB/l73wa93a+KrLgHck4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:T1133Tz+4qS3rWU04yNoT1KYgtaxo7x0JZF4qyJfZdnNIanOwcQmc1OfHcMEcDQ+nL/hXGcNjMAxQvTeMMSH09NygCC4i7uyW9RCt/Im3LQi6C7a7SPL6+4e6wDnfMcTHjZbmfq4nkngEnTxcIY+ipTwnu7KRqgCEJsFE3BMpCYMYXiyVUInkK7XIEuSseJBVAOqJ6k48NqLQ4rhnP3TIjyE8u3nmjOFU6EBz4zR0WPVccbGVANPTN2155SaSmFc
X-MS-Office365-Filtering-Correlation-Id: 0900467a-5b77-4876-c1e2-08d5b262ccd1
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2018 08:32:50.7498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0900467a-5b77-4876-c1e2-08d5b262ccd1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pfuze100 support on i.MX6SX Sabre Auto board.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V5:
	improve node name and unit-address format.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 116 +++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 87ffe2c..1d8cf0f 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -66,6 +66,13 @@
 };
 
 &iomuxc {
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6SX_PAD_GPIO1_IO03__I2C2_SDA          0x4001b8b1
+			MX6SX_PAD_GPIO1_IO02__I2C2_SCL          0x4001b8b1
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
@@ -139,3 +146,112 @@
 		>;
 	};
 };
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	pfuze100: pmic@8 {
+		compatible = "fsl,pfuze100";
+		reg = <0x08>;
+
+		regulators {
+			sw1a_reg: sw1ab {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw1c_reg: sw1c {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3a {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3b_reg: sw3b {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw4_reg: sw4 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: vgen4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vgen5 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vgen6 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
-- 
2.7.4
