Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbeCRD01 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 23:26:27 -0400
Received: from mail-by2nam03on0057.outbound.protection.outlook.com ([104.47.42.57]:7072
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752548AbeCRD0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 23:26:24 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <stefan.wahren@i2se.com>
CC: <Linux-imx@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/2] ARM: dts: pfuze3000: update sw1a/vldo4 voltage range
Date: Sun, 18 Mar 2018 11:23:20 +0800
Message-ID: <1521343401-3109-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131658171829266220;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(39380400002)(376002)(396003)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(316002)(36756003)(6306002)(53936002)(105606002)(85426001)(2201001)(48376002)(356003)(86362001)(106466001)(575784001)(50466002)(305945005)(5660300001)(2906002)(104016004)(77096007)(51416003)(59450400001)(68736007)(54906003)(16586007)(110136005)(26826003)(498600001)(966005)(72206003)(6666003)(336012)(97736004)(50226002)(450100002)(4326008)(81156014)(81166006)(8676002)(15650500001)(8936002)(47776003)(26005)(32563001)(2101003)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2767;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD012;1:1SiQS3ly3UKtFi4W5lIjBjrxjkDUhT0hPxyziS+uEpghsWr/FQX6t6H6UgjZhAl/G2qGJKlGFHiV2YB3ZgcVHYUq0+tfWnqbecpmAJ+eQcbXQiNmkbYdxTXp3wWfRuDi
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 808a4573-a017-4239-bac3-08d58c80060a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:MWHPR03MB2767;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2767;3:jU9TfdIg+5JwoCSqwcaCke7qGItTFyKygQMmIWmccVH9jqlNyGFMTCH6xEZaM2NR0ffOx5JQunrpJrBO3tygQhQNCLytgPY6vUcqcdJ+J2xwWoQ788/3IYKQ8Y5Nu+CGrltS2J49cTwUhAm15X6nN2IdP7e2asQ/G5Dg4qJg8cRORnAy9Mwwnkg2W8SNhx/wwV3saMWaSNc/bDyJZPGvtAiCLDoVsbmRoVN3c6egc3kQCybCLZDw66kXgMEg+vj2VpdPZm6QwplkM2NxN4INx1wPDU93EgLMOIHKA1siJq5uUpVHz+40qBUN2p5w3mvSxax6GsF8jmEX9NEt4mR0PuRYMwUwmGWI2lVgx+rC4lE=;25:UJKZFTKY7J82/NILWGpwBO9OB/Qmi85H/61gCBNP05hK7kWduZxebgw9Ylab2KD7rd8Rb2qDk47IW2iYP0mmn4QIY0uzN14/dOMkmxTMdBG+L2z6PCRbJTNp6cE9mFHKp3QSng/2OIRbhSi2SAAlX7vEV3u+JDJNxw5OUyWo6gGF32fv3U/M+ttWGiQUrAfo42HAJYz6+oFZWLhpcVCL7oUW7cjgLufJ4S+yarFkvzmcEtcGMfOiGsmZcuWNE9E/LM/Lknz6G84IWUQ9sjA7oN44sznHfCDO34Qb8zyyAiK0HU5KTldIAj2uIzEfuX86LwBKHqI7/PutsDKMXW1r8g==
X-MS-TrafficTypeDiagnostic: MWHPR03MB2767:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2767;31:JpNjPdFRmZ+MSyZ6v9nOlnSSAFsTIZ/Wgw2k3dkQzF2/x4Jj4BQ7+UMggS3u+cEhgMS/4yB4tkomBi47txJ8bSkZ1VFiJ26k/Cz5mtbH+4c1ZWW7/c8M9XQTLLIM37dchFE5+reWpzlQhPBcoBHqHPsUeeHux/YK0mJEN6cuYylsrylsqtMvW2nNAZjWbgpdCZex/10KCuOR6yx3JtTIlP+MCPdUnIBWJBY8GxI8HJk=;4:MFwphJ20+4Qtgby7gKJTS7uS9eIANmMxGRFP/IzfBgBSTJ2r9yJRAe3eM9sQOsaBp+ATYekHJFf3E/xxCMRGWHui9p4yRRlC6LeXvZgcxAt7QG6XdX3vigOf1QosyU6KXanGqkjZAURVNrif2xN76RamgVb2iKAk3lsUgCByE263LinaeVRR3FmYeRM7hz97JonG0L7yTSm8ZbHB4hDaFUzMdBPugZrgMvcDwuh85ynjHRAvdXd/Q3MTc0BP1OtmcXAVbPadSBuKPwDZbdH63y01Jxv1dmrmxxZd6l5zZl9drwASohKESXuyhDMYW27qEJihe2hX/6FGNiUHJQ+dfOd+4g8drGO/H/Lkk8vMzE8=
X-Microsoft-Antispam-PRVS: <MWHPR03MB2767F33BA7C4A6890ADA5E0CF5D50@MWHPR03MB2767.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(264314650089876);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(6055026)(6096035)(20161123559100)(20161123563025)(20161123556025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123561025)(201708071742011);SRVR:MWHPR03MB2767;BCL:0;PCL:0;RULEID:(400006);SRVR:MWHPR03MB2767;
X-Forefront-PRVS: 06157D541C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2767;23:Gx1manIk9iVm8jyP4JAB1U6ZYtfgbT7HWrZNVbuOU?=
 =?us-ascii?Q?AXAwR3AIafjdUuu+V8qi1eTYFgLhW+0iUVvyJRXhE9uine/E7utnXFc0WmEz?=
 =?us-ascii?Q?563TG/SxC5s/7oKEfKHbyTREu8+YArGAJnvWq2Mk1V1MSbpof9yAKwiAmgzH?=
 =?us-ascii?Q?UBxFIICgrL+YsR35CtqXs16o7kRuMdT2npDu2TeQxbPLWMfETXW3jIJ9k/hP?=
 =?us-ascii?Q?8XAtG0QZ3WZsm68D5erebGvPRVPAYzy9+xU36bUxDHTZ85UIpMONInZ66mDe?=
 =?us-ascii?Q?xLJCEHaVJ9urrKmpFkFP+ynsruDR1yxzWcE7+PhUU7og5SvxalznegtxPIyD?=
 =?us-ascii?Q?KKYWUOJcvrgcZchljHl8KzQ7woyfaUywyM3jiF7HZrWHm4xJuL0QJrOLIrTV?=
 =?us-ascii?Q?Ae2O52O4kBMcgnPdWlrOtaqhzfy9yN6txdwlPgP70ZPagcVQlb2kB0lDGJVi?=
 =?us-ascii?Q?O87wu+UPVzvnb2yels5aLTF+v3GKm2EABQSyOCfmJZxjZfOVql0e6oATnUk+?=
 =?us-ascii?Q?CMpYVjJDD1hf77T9jsroPWaMPqPp/cN5pGnaNTOz/a/PE1kBFeox/Wlx9pUy?=
 =?us-ascii?Q?3tyo10tMAFKaIWhAQlHFHLjLqGlSjEuEAuza1XFRW6U3Hqzcn9l5ymfPGlQ9?=
 =?us-ascii?Q?eTQhIdW3nP70+N6ztRWry5rY/Cft3Jmy3nuBxTFG9qtfdpVNpdgU6e1g2PWJ?=
 =?us-ascii?Q?Uahcf4zNWjm3rfodldUo3EvEUtPDsWol2FoLsLHBsyJqSKeVkDWE2A52FeoF?=
 =?us-ascii?Q?ne+oaZLycAUSDpqhiSmYROYcZaDU6unw1BMAp6cRUgiyHdy74TFnGnVXj/hZ?=
 =?us-ascii?Q?KHVGznJnoPOBRFVJfOorVVMTZXCGjVYvaawKHOa4lQgeJgMEjR1eJfRDIYVl?=
 =?us-ascii?Q?l+jmySgZoRq50fA0zHzXc7wSONAksEOXaGZ84sQWPPCYMYKRYbKfAlPAwbHZ?=
 =?us-ascii?Q?PQTlo1L2lJVJqPBCO8Pz0yNzwzR81oXyREkxyCiycuxj2P2ZGiMHcfGEoBkY?=
 =?us-ascii?Q?cGUb611tOATSZWyOj1ab6tAneAXLhCAGjP29v0mE+H4Ygtd1w05zYUHm4BkU?=
 =?us-ascii?Q?7ALg9Sjqd74U6gUJ8N0/1LZSgbnj1AhRg5GbBFIWo2ADVPVFaoaFT7zCPk7W?=
 =?us-ascii?Q?l2fXCnnr4G07m9HHGDVxUbJKYpW6/esMwRAIUhVA/wtE3Pt1Ek6AUU3HCp0n?=
 =?us-ascii?Q?ITPbWGoNYKPxiQHjqCjzZveq+FAizgr5NBACgQH8hTir9TsksiVGJ5tYIi+x?=
 =?us-ascii?Q?yRFaW8WmxnCqFmQWuoHCuK0RSJaQnPaqZQ99Sxa?=
X-Microsoft-Antispam-Message-Info: sz8wraFyyeE3bFEAC+mFuHwFUfku2Ea/WqBmd7LEVsy2uz8on9gDqNrhJdon/alVf/X96GAGcga0uUphyq0F5R6N0ac6TDoacRUYGGqRlfxHc+LM+1i0NIgHHdE+Tr3wwGT9AxeKrRvvtXK9mtlK7RiYlWaeeaSnhH+sdeKmLHTbYIDUkJDb9YVZRIP8gut3
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2767;6:It8FxoPGRgQwC67eubRWYDTtZvBB6xNfhMjClAHm3kXpp5xZuKvZiOZPBWg/xdlWB7O6JQMxL1noNVLoqNxKx5wjXtCcDLDCR0kMFMeDWXgP2OjG01Af8pWRH4SfCYC1b7XTWvEYHj6Rox1zqMZh8jgXtLS8e729FEhKleeOAGTL+NHGNXRsb/Dsll4Dbvru3rQGUGJLw9Fg28Z5e0c/hvRXaIWtp9QI3Hsp3UVkkWy5B4htfHITls6v3MozlkmI8cai2/5XKCuOY0NGWfrmoj7ToEfS2DwVJ6cmAE4aztBr0nPF+T6gO/axAE6oRMPmnpcae6hVlsulKB1it1gIdHmxOvrlLgRQzUMno81+vLU=;5:0+3Q2396Qc9JFQ5JDO93cuBLKS10ekTVGTqfpBj7eqt9TqYGBPXgzlg7ROmaWoQhY1HpgIWYaFK+hnGo820mg67x072D40QprzWxXwooW19LJgS00XB1mMgqTRxVj72wCepj3OTjPnkdilu28m3X3tSzGsnKCHZJ269x3OLD92A=;24:Tij/+CZD1ouGPg3I/i2vgrOowDn9hDzTP3r2+Pb3LOIS7BaEdrITGoKUiG9xXIOg5OMA+jWg7mB8Jf1N3Ai0TK93E8mUzQe7PFrW+Gwxtwg=;7:XovSeDc/usVhvTYRRL1UMBTrGyBRjq534Cv9oo8ijbx++l6FbMRwYNSdiJci5wKg3e+z5aFXRb3pBIjfdWmIEM3WyvCxmw6JJiyorVeVvcsXqPQMnUyPw5W7ULg161EZfl5a18lMxOl0x0TvQkxDXHwHuL4btl1z2MsOJH30Nu92BypmRWfQniw5G8uRbpxtubqp/cEdplC2Rc/iGLnTQ3XFqKOBaJ0bHBkUFacV6CaceuptKDdbsU7571+tGuP3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2018 03:26:22.6614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 808a4573-a017-4239-bac3-08d58c80060a
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2767
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update sw1a/vldo4's voltage range according to pfuze3000
datasheet(Rev.9.0) from:

https://www.nxp.com/docs/en/data-sheet/PF3000.pdf

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
no changes since V1.
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi  | 2 +-
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 4 ++--
 arch/arm/boot/dts/imx7d-nitrogen7.dts   | 2 +-
 arch/arm/boot/dts/imx7d-sdb.dts         | 6 +++---
 arch/arm/boot/dts/imx7s-warp.dts        | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
index 53b3eac..1de0a0f 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
@@ -142,7 +142,7 @@
 		regulators {
 			sw1a_reg: sw1a {
 				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <6250>;
diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index ae45af1..3781cb8 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -87,7 +87,7 @@
 		regulators {
 			sw1a_reg: sw1a {
 				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <6250>;
@@ -284,4 +284,4 @@
 			MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x14 /* OTG PWREN */
 		>;
 	};
-};
\ No newline at end of file
+};
diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index 2b05898..2802bcf 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -188,7 +188,7 @@
 		regulators {
 			sw1a_reg: sw1a {
 				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <6250>;
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index a7a5dc7..ba60457 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -248,7 +248,7 @@
 		regulators {
 			sw1a_reg: sw1a {
 				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <6250>;
@@ -324,8 +324,8 @@
 			};
 
 			vgen6_reg: vldo4 {
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
 		};
diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 9bdf121..0e0cbcf 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -129,7 +129,7 @@
 		regulators {
 			sw1a_reg: sw1a {
 				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <6250>;
-- 
2.7.4
