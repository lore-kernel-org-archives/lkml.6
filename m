Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeCPI5g (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:57:36 -0400
Received: from mail-by2nam01on0062.outbound.protection.outlook.com ([104.47.34.62]:53254
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751236AbeCPI5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:57:33 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>
CC: <Linux-imx@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: dts: imx7d-sdb: add gpio key support
Date: Fri, 16 Mar 2018 16:54:31 +0800
Message-ID: <1521190471-25242-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131656642513498955;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(7966004)(376002)(39860400002)(39380400002)(346002)(396003)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(305945005)(53936002)(26005)(77096007)(26826003)(336012)(104016004)(1857600001)(2201001)(450100002)(4326008)(508600001)(16586007)(36756003)(86362001)(316002)(85426001)(356003)(68736007)(51416003)(110136005)(5660300001)(54906003)(97736004)(47776003)(6666003)(72206003)(8936002)(2906002)(50466002)(48376002)(106466001)(8676002)(81156014)(50226002)(81166006)(105606002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3162;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD006;1:DaKaOcQIEKvGA02LtrsPL0weuqwAVd0vIUXaFmb8aboO5vKor3mnuH8lFJzvvXb37geTyekz7WxA/RTcD05xa7Ys+/nN6BVdy/ZzdBcYVeMbaiubhZWiUCIffCnuqcL2
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fde8b05a-1eab-45e3-734b-08d58b1bf3cd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:DM5PR03MB3162;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3162;3:YZV89exCm7mlEIh7Xj4NIRACMVQokdMXbERQ3Zv7TQrOZdNe3OBNHZvxO1cIsZS2fbKblS8e7RkBxQ/T3XmURkAumsDgxj8qjP4R6u5OC8pn8rY0kFwfESBGSAdeRL58Y9RBJoeC/8svdXfJQEtJTGVAZ+WARW7Jbm4sojr5y5DGDsME4Q1zECBOwJCfyX26aXdxDxFIqQP59hgrIjNHwNb5LM7EWpRAELGXIuYH0PopQkKQxYX8obznIylMRCC+Dh8Yqg9LJFXz+gpWW8avhwD9nY58MViEYv/RvbMVRST0gZPZv7D8d1yKdqwqngmS9CzaeMNcm1qfKjvOZUn7NAWRZLZvamDCc3H/ux0Ww0k=;25:S1zI3SzcPqqeqeKbEoAtrh6fLucy4XN58iAxZlxMzuSTrMBcg+un+JW5pekzZL5ehTwNf7IZl9Bd9Kb3v1AS/HmUxDWzrwSCZT39FtfHbeuPc11EbyKx3a6LUYElhEr61xkEOiHyjlzAljLISMVHGB8rNQnUG/0PITbVlJ8sUc9ejoyad5yONKdZVUGjUidEwi37sxrBZPnog98OzGFebnmdM5QhiFf2AjaLA7JpJtXVgsnLHfPnrAMzGJF0WmQmCfGwijaKF9d+P3YSDy/cxDGmGeeH972ynw1nwxnST3pFKbcgwQRwnZsPLuSsz8mq4sWn+vTneYvOg6NNLj0sUA==
X-MS-TrafficTypeDiagnostic: DM5PR03MB3162:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3162;31:ofu600RqyZZP4dv3LSjIi6ThCplS7vp3LU7BhY8xVYr2eAgo0E8GzTTZL7naWuiJqRZ7eF1dHbunHpWAtsVxyh6ugZ3UiYc/R/HxnsnrthoUCsP3p5iVxS9hRDlKEOLSrpwF6pJ4jHvAZY4qXCk54v3ho0h0yO7tpWu3yt2bHb4aeZvEWSr3V1R9Bvdo/Hs/pxwXyi8MOvqoactAH5crgo03RwSQqZ2fH6vsqnORZkk=;4:a9qfmvzFojzZl8cwNHd7T7okMFH1JzUro3AfOb9K7pAA6818ae11ovogk8nWokBDU4X3ibi13fVdxWcufe4jA8Q2uPGbxMGw8vb7ifDXe3ZaUVH8W9E801ms5K09fZHrH7B9srcAKn5WnzACES2TGMePxoKD1rLW4ArXr21HVoBv1euBWKDkpF9liNsaFD+xeCouUN1VOjjbQgmpbBuz/xTka6xzS4MmZ0af1HTh52WBOdjRLGUk+uIgGWPps1eIYF3i+sPfwiR56gZIy0Pvd9An5OSfa8uUTbXH2nKLeLCLcf3e/qzgj94DKnoV5/X8
X-Microsoft-Antispam-PRVS: <DM5PR03MB3162000FFE43A0C2200D7526F5D70@DM5PR03MB3162.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501281)(52105095)(6055026)(6096035)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(20161123559100)(20161123556025)(20161123563025)(20161123565025)(20161123561025)(201708071742011);SRVR:DM5PR03MB3162;BCL:0;PCL:0;RULEID:(400006);SRVR:DM5PR03MB3162;
X-Forefront-PRVS: 0613912E23
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3162;23:wZ989GdXmXu/qa2RUbQChwzNt5YC9iW0eYTJBpUsh?=
 =?us-ascii?Q?rlf1pI45GXR1jg+NMK8rlfMKVyo++PYZiPI6Oz5WKKsOZSGVVHDeIxOFXb6T?=
 =?us-ascii?Q?ZGvqbUuddqL6giiXZXzubOGrpW5nGXUU0vLw8gBUMJppdqBvClsacmdxNI6o?=
 =?us-ascii?Q?jbFU2/WCFEqnjOMcmftN9i63RbC+4kBItPcieNS4VLPgSouD0JIeL543xA6q?=
 =?us-ascii?Q?LviwYZwS16ycjavKamcFqMn0JQi3oAdUEu/wzrEwB4i5YtlTt0Ln0ZilCVgD?=
 =?us-ascii?Q?Kc+/UTYZNn2xXWYuzPuQGdvfU69tICwkgNCOrDOJrMmb1Hbwm7xA9PhbRKag?=
 =?us-ascii?Q?L+w6Q+Ey/8n92Ebxc0IDIMwzkYFd9ZX12n/mEyeL7KaoNRH5Ti86jRb2xYcq?=
 =?us-ascii?Q?ykjQ3ad0eOOLW6/e1lu/VETQj0qI8eVkndqYLa8D7ejAhuAJR4hfZ4TrX/Q3?=
 =?us-ascii?Q?cD30ie7LEEny5YmfpGch41CXPio9NRhOXq1fgULHdFK0tEjRzVGoWTRVZb1B?=
 =?us-ascii?Q?ABcO6RR90gvBVf1HNOVxk/jEHXM4hF0Enrh0nJvd4RyUS0rtLKkAt+qAD1bf?=
 =?us-ascii?Q?agCtnkqM9DVRca+cG26imEYHI/4dIEj91l5CWYJ4L/rqYTiUG9YnkZ5oLnuk?=
 =?us-ascii?Q?c62dewuRza3yfrSrMNtAh/+ef4pfw+6DiWEI3eO5IdJAeu0I41MCx28yuHx0?=
 =?us-ascii?Q?VCBjMakVD9PArnlWY0rimDnIqIZiCfxqgmRItZwgmVMsN5x94YIdDel9/Qha?=
 =?us-ascii?Q?FyrfPGnwHVV00VGIcHdIdjLG8oSHTce3NbGNcG0932W2r+k0EzuP6118d0Kf?=
 =?us-ascii?Q?kD3dDR1I1JsECD2RJ09QVNyuM9ra5mzpJ9GfJmuu3tDe7aTrT2h+F5Juag/z?=
 =?us-ascii?Q?3mtzrQQ0UDCu741vrH6tUWiYhtouDvISFr0U3zEtrop/R4bsi82xmElVoKH2?=
 =?us-ascii?Q?FnAlBrqRKrbYp8sPFpwUelRhnhGkbLjBesfieUmiwp1UrVhQXILm28eIZl9/?=
 =?us-ascii?Q?AUNkSX0xv8m6obEQZXdXO+Ydi836Ycx9BrsOHseiEWGrn2D/JEECIRebcSRt?=
 =?us-ascii?Q?4g4UtiGkO2E/cOUxsYK+8LECqJ+u+DNn+2wdyu4MhlOXLUpHUWmueS2y3S5A?=
 =?us-ascii?Q?F6GN7wd6HYk/96wx3v+ucCKmeGuLIASEQcyypZW7sPzkLa/eNc0crOsMcPIi?=
 =?us-ascii?Q?EIPmDr7VyTlHhT6cY9vLDh60Cqx/uOfBFrzo+qCFnz7zEFmr1XvC5VMqb77E?=
 =?us-ascii?Q?g/roTITjxyZpD8ZCIo=3D?=
X-Microsoft-Antispam-Message-Info: UHknT5CytG9kOZA96vw2O/l2gSLH/fCfPRG4ZprYRYXAmlmFgg8WSyFsmty375BCX9R2Q4eBnoa05sT/2vwLoTAenOHgMcQw47a46+zSbcknl5pG62Jft0NCfJhwyFTNZEdklR5dCmkwbXQKe0VbLVafT6oWp1kNqDMvuJcBwNHamJZ8Rw/08o3gbVLVCbfG
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3162;6:Qany4EyRPuvLcz1BkY3f7JZwDcCUFNSpxuZS2sv9qIjbSWq0vJ6F3Blg0cw6ssEGI3eAClpGJPD4kkLHZj/3ZrxjuV3dax9K7V+ajFRvRV6WmifMgwQj61xnAqPub+XD7lAPGTY4hFp9KHStvX249PrqZd59EpNaWORikHqVvjCEkUTepLx7OXFLDKtSrH5yfvtSkFgQvSTnjq9wuAlFah/sfFAtsjqEUt+QBQUNi7Vp0CplmTWRjJJ8koXwpaW2lbAhskz89hgkGs2VERr86v1oRDQMZ4rjSeZoa0lq6dzEWVoZ0bGr7VPfmiK0NGhxhyXaFM+ugZyKaHlZC8Q2HRy8ifIkBfVCdJmEVegbg2Y=;5:tW8THBxDQSX40lzbbLZheXPFLj2so5kQsnJmONmHXml+8TrAD7ZBKXRO2RTRBqopnYAXReUBbuXUybShir4yaAzmutsmZY9SHLGWziQXkUXDkzNuoH96kOYK0rb1LxOjXiy52vk6RoYPygoDzOJu2ZSs0HIY2HyG9aSKseqVB7U=;24:aFCWxl1zLYxThoCpHWQW7Bv7u7f/aAGHpMTTSQC0Vigm/fHKRZ0bP0Uhc9XYgXkBNb7MTrsn4CkX7WiJ2YqZ2cF8AZwn3ATy8pxaGdh/SWc=;7:lgVyNBoXpqYrADe4ghO+QKFlW5OnC81R14ZM4ujPWuWlxTKlJ75EhZLS+OxfY2MyFYKSrwtFEG68C7ib9uZVSrnAps5HvuCBYC+Z+Y53yrn5wEoMMF2SZY2m1OoSl5M1Q2cwxomAxcPFqrfvTPFzfHIxi8hUjSWioTrsL5gH73wBkgTlQ4h5hpjUj80aDkhEEDvTAHfpEHBi1j36+NfefgyDcQ9JOBM2OXDgESweaeWwpnF0kBFkxOMUxrvEDN2u
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 08:57:31.2094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fde8b05a-1eab-45e3-734b-08d58b1bf3cd
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3162
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for imx7d-sdb board's gpio keys:

S1(FUNC1): KEY_VOLUMEUP
S3(FUNC2): KEY_VOLUMEDOWN

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 7f241af..e47b5b2 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -52,6 +52,24 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		volume-up {
+			label = "Volume Up";
+			gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		volume-down {
+			label = "Volume Down";
+			gpios = <&gpio5 10 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+	};
+
 	spi4 {
 		compatible = "spi-gpio";
 		pinctrl-names = "default";
@@ -519,6 +537,12 @@
 			>;
 		};
 
+		pinctrl_gpio_keys: gpio_keysgrp {
+			fsl,pins = <
+				MX7D_PAD_SD2_RESET_B__GPIO5_IO11	0x59
+				MX7D_PAD_SD2_WP__GPIO5_IO10		0x59
+			>;
+		};
 
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-- 
2.7.4
