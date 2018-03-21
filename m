Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeCUCzt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:55:49 -0400
Received: from mail-cys01nam02on0046.outbound.protection.outlook.com ([104.47.37.46]:14908
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751481AbeCUCzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:55:46 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Robin Gong <yibin.gong@nxp.com>
To: <shawnguo@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <aisheng.dong@nxp.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-imx@nxp.com>
Subject: [PATCH v1] ARM: dts: imx6qdl-sabreauto: add ecspi dts for sabreauto board
Date: Wed, 21 Mar 2018 18:22:48 +0800
Message-ID: <1521627768-942-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131660745444397572;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(39860400002)(39380400002)(346002)(376002)(396003)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(47776003)(50466002)(53936002)(106466001)(5660300001)(86362001)(336012)(356003)(77096007)(54906003)(48376002)(85426001)(59450400001)(110136005)(2201001)(305945005)(51416003)(26005)(50226002)(8936002)(26826003)(16586007)(81166006)(81156014)(450100002)(316002)(4326008)(104016004)(6666003)(68736007)(508600001)(2906002)(8676002)(6636002)(105606002)(97736004)(36756003)(32563001)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2760;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD013;1:WSI+JcrDtvpiJiM6Y8hmcAwNw1m7L3KpiMrsz/iEKvG+KBVg6A6oVwVjs7NWkNRetqpq8TVKiwlfcigyxYgQkjnHfHQEkEaJ70k2v8H8Ywyq6Dq2X1iFAiumwViWOgZq
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50055b85-6ad6-461d-259b-08d58ed73d75
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:CY4PR03MB2760;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2760;3:mC4f4nTNvzwqLseGzop/gTrgQFBcwdexR7laUumYXXg4q2eZVmKMZc3gxrnggkDd3av3NFhvyNGgTQ1bHe2DzUlv0Rj9OBA09HBNDg82J4Tt/hAHhzdaWPCTTCgS1nD+nnyPXDI0R5RMepTYvcmFHY66OBiFTtP0/INBfiKlSxs0KVdze5SVJ6DmQYhRw6odKvMtUhKPkbcDfZuBCBW4PnOdHSTP7oP3N8woFn3o2j3vL4IoO36z/YdQ+INdgzMiXmFJ0BKbyP6lPwqqpUH5PbJWY6bNlLoaBAIudVThWQRy6NCMmaJbZEyq0iZQk6JQ1lnCfrd3nTa8+e5b8JEK6gC2GHz2DkVQCrzTlgx96fg=;25:9+2XXj2BbkPfWTNtKXU/4/Got2JAD22N4YOVLIOAHyST8vkoVjWIKN6A5pHXObxGdL2sVNkoTHqYLJOZhIHy2oBBBsW8R/ZZxVTk3J9HpKkLiov1lPXzT2CQsclWdo+HNhMM2Ik/y2ED891StSmE84dxezg6XOxu9X025vroZeRKP55bJHI4N7gzOMc855YHCfHZuokT8RqQyFWkz4K9a4JvIU0nYbj0gTISMku22HXBmESShIAl6cB0RaRWp0OApNe4gNgh2lFH9RdCoslvbd+kllKp5GnWnuFHclkOWWuoIbmnZYdppY0MX8BA4bpzSdR2Ua1vnEQpu1RiEoZ6SA==
X-MS-TrafficTypeDiagnostic: CY4PR03MB2760:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2760;31:NblPiVh5vuJx5ZqGW9wtTJf9DIMJh6vKBNLoQ3nBqHeRFQZpIWDtwjsebsL6a9mWd9lBH3CG66gVqC3zLsDy5oitPmLgdDDcC4wLQA2wq1vKSA6BdNtNGZa0ziu9Q0sLjAb3ywipZrfnLNElKZT3Jgj3EinV239WOkHIcPjA+SFPpzRL/GZYnh64K2VM+aQOu6xRRri6flcYwbc+LHpRCjpw2HNL15ydUM80qXz8GdY=;4:M+b11Qidg7MuNuzwkdQEI10VFS+FjYwGvF5gvK9Zz/+V/+uBJY/YGkQvaY2w7KwXUoulttUdXuenZLygrelsARogkaW5qhi9lldFBQKaLCBjTmIHaLHfjHc3vY2RZvWhzxyXusa59UeK3XpTd4ps8D4MbWX85Qw0AihdUMo0lJPrhZ7O9+XNGtnibahX2Lmov5HVG5cNayP7HxL1HwlrVNuEYSdx1vYxLevxcUpmcM+8/SP3RvVcsvjund+gbol0Qh8cGWgv4MZuKXfieSx++vISaSQ+RMSH3ZndrRjVb3MAeGdxi6ZsRog2umlPhtjv
X-Microsoft-Antispam-PRVS: <CY4PR03MB2760FD8143D54C2EBED8740289AA0@CY4PR03MB2760.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501317)(52105095)(93006095)(93001095)(10201501046)(6055026)(6096035)(20161123563025)(20161123556025)(20161123565025)(20161123559100)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(20161123561025)(201708071742011);SRVR:CY4PR03MB2760;BCL:0;PCL:0;RULEID:(400006);SRVR:CY4PR03MB2760;
X-Forefront-PRVS: 0618E4E7E1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2760;23:cY5hcecV70v7/XqY7ZQTMx9DHqtFfRjTl5yWky821?=
 =?us-ascii?Q?YV7hZectjL7Q+jNU2YVz19GdumvjegLuKEWkTqnUftUzhtRQ2XSIsi/pCp3P?=
 =?us-ascii?Q?rxYY50aYM7EQIHH59IYkDXqcUXQPO6dSI/iug9XYArWrC9/cCsOIsbwR8s/2?=
 =?us-ascii?Q?3IVkyTZ4gtKPW4JU+fShlk+IV3gZTPFNHUx0RTOqfwVqZ1HUeqgd/5TC8jHc?=
 =?us-ascii?Q?qAvcaNWCxhKCIAPBM+79fL9Yv7ZGUePN3CpnjmRZ+YnDJ9RG/ASpS+dyZs6g?=
 =?us-ascii?Q?p61KbwtxQnF0WlGcnXOI1hDrnLIixVgYBNw9ui0Jmq8vn9YaZ3hGwX0spNwM?=
 =?us-ascii?Q?ptsNEDShFi0LSTMbP7ccq4u8e12eBOlTiOr9BUV8dFEy75umsbIN44CDJmYW?=
 =?us-ascii?Q?IwcNq8siiPxhbSWuEhNYpGC9yA9tuAJIzQnGg6Y4qjNxskx0aIQxcpol4Zk3?=
 =?us-ascii?Q?ouZOnu39dVu3105FVhK/P5rsiCQm9Y5pzh5bDkCFB1gOgTB2GiI8rtE/Cwcg?=
 =?us-ascii?Q?O1LN0TFztBV8CuIMd7DzdvWS37evxqClcoQnsZHgTLqIVVAM7yUI/ZxT6y2y?=
 =?us-ascii?Q?7QG0/L1MpOEZ0g1YuTE8jPy3zikWuHo1jF2oXvS7oQx/4KvHeqsh1Zcc0vTC?=
 =?us-ascii?Q?r2Uv0oJ3r9E31VTn0ZRgTMm7GUnAcHKwlOrPYoX/HAyANDCzpfs3zvtqkP42?=
 =?us-ascii?Q?l9hoOJFkG8gi4gpe/T+lk7QoI39NX2QFFGJRY7SyY7dLt6VPUZ5WCK3YR1pA?=
 =?us-ascii?Q?kZV4r3mpc2oo0WVdd6gjkpGVh0q6nmxZwY+mwFeUmoJrW1ZKvpBieXjr5OXk?=
 =?us-ascii?Q?WRAufQPqHeAy7UAvdRGGhMqUwDtdSNX+/0nlEBYvOTbWvdEWfkElPKvfaLJF?=
 =?us-ascii?Q?N2OkcjkPYO72qug2WXEYcqxlGpBDzqNe1U8/JJ5PXgwskyzsUUkNjY/8Ht/6?=
 =?us-ascii?Q?MLHxXXoukvciyXbaB2jZqsPp7VHrwsAupbcWlDQHsBQZdoJsxUTiG0z84+VZ?=
 =?us-ascii?Q?8v+XXBBpwO6f0AG+rBBJb38gfNVX35+V7foHFo3fURhIMm3XT2ui+teWv18l?=
 =?us-ascii?Q?Qz+YwoIpwvwj9lIo6JRuRR2qT8CX8m544sf2XnS+69z4QxDeJYe/I7yquGpb?=
 =?us-ascii?Q?3GMy16YzZgjbW+dJeVK+Vk7E/wELIcx6jkTpFGFCd6PCtc5xaVE5niNMj6Rp?=
 =?us-ascii?Q?xFpv1s/1XiEPak=3D?=
X-Microsoft-Antispam-Message-Info: 67QMGgx0flexcst4ypxxL6/HIzHrgtmNOysn4RoazH9qbcpA2q6OZeclZc4OI2OSJbwp+DRz5BKai+wwnpzLK/23iijkMrPOhPy8QlZ/wpoO4HNibEFJpUWhkFMYoKk+b/MZRwCj1DfVe3Xr7p+N5YIIy1/VIfD3j0gigjvEXVJ3nHupBhlWfyqJdH/T4Woq
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2760;6:cUKBqlskRa18MDcysThF4K5ClJgJle06IZYBzE05Pmko2kCBV108xvO51qlOlvcScgaXhCIUE7f28sJVOxJ7CsIXSymT6lV6/rSNHlc4BSwH7IobeJSiuN2L8mwq0ZLCVbeILJXwMFl4XIH6gX0JC/TIEegCCPpOsfa05oskaHR0XumYSijH3TpE+Jhw1YpvKVnxTNznT8Hh2o1xFdIcTNLMCwqol8lzE1MEj1JnfFv2DkRQPICOFxnoPs2NaHUcVTzH7adh7dU1r6e662+nxuMjMeEcdxLxN9rrrM6y5vZNsGyBAbRQeOfIkBHiq2nsk0zCtPDlGzkp91Eif64f+qQ+fQaw4cfpt3O4B8gwBHo=;5:qSBxo0aAAPAjZSH/28IgFPzQd8LXW8Cry8cZbZ2vKrIT7aLupGZaDvJ/ZYIfJGYjR8k7xbvKigz18G9o6vClOBqITxHL3G0HK/UnkGu9E4n1g3QBcfuexJMrXT4I8hvdFc4/I+eytfsEWHZZ3yU+MK4FDYqUmxxq3p9WXftFYeU=;24:GSu/6aeWqykAgGVRKudaEkH4b6NOZFT35ZEo2heLo9VJhfmTK7la2SdHajhKUHP98vJDJkHoO9PVjlorlWWvLvJjNuz6VyEGscNhcqX2I2g=;7:z7CGXtw5LbBvhahbKE3BS4/tdURZk2V6mHWjzImJ0Vviac9U8v2RK0MKmLA35AbnkviGpdWCSyJZHrAQ+6lTFfjsXDAo8mTE7Bc57RDpmv+3XPAONK8zp1c0MxZn0vPcvVP40pDNTKP/Nxg8h3dEdgN107rZjFKd0+hAWwnxIjNSzza+fC7PJT8+HaVmVZNMPP2sLMXSzfz/G77WBcAoQPTWbNQzkJp9yM4A/t1Ov/Sep/vQ039XXQNWm/iJED5r
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 02:55:43.3477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50055b85-6ad6-461d-259b-08d58ed73d75
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2760
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DIN pin of SPI-NOR muxed with I2C3_SDA which connected to one gpio expand
chip, thus have to disable all those module which compacted by those gpios
if enable SPI-NOR support on Sabreauto board.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm/boot/dts/Makefile                   |  2 ++
 arch/arm/boot/dts/imx6dl-sabreauto-ecspi.dts | 47 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q-sabreauto-ecspi.dts  | 48 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi     |  1 +
 4 files changed, 98 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-sabreauto-ecspi.dts
 create mode 100644 arch/arm/boot/dts/imx6q-sabreauto-ecspi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4fe209c..4a814bb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -406,6 +406,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-rex-basic.dtb \
 	imx6dl-riotboard.dtb \
 	imx6dl-sabreauto.dtb \
+	imx6dl-sabreauto-ecspi.dtb \
 	imx6dl-sabrelite.dtb \
 	imx6dl-sabresd.dtb \
 	imx6dl-savageboard.dtb \
@@ -478,6 +479,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-pistachio.dtb \
 	imx6q-rex-pro.dtb \
 	imx6q-sabreauto.dtb \
+	imx6q-sabreauto-ecspi.dtb \
 	imx6q-sabrelite.dtb \
 	imx6q-sabresd.dtb \
 	imx6q-savageboard.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-sabreauto-ecspi.dts b/arch/arm/boot/dts/imx6dl-sabreauto-ecspi.dts
new file mode 100644
index 0000000..80d018d
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-sabreauto-ecspi.dts
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2014 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "imx6dl-sabreauto.dts"
+
+&gpio5 {
+	eim_d18_steered {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "ecspi1_din";
+	};
+};
+
+&ecspi1 {
+	status = "okay";
+};
+
+&can2 {
+	/* max7310_c on i2c3 is gone */
+	status = "disabled";
+};
+
+&i2c3 {
+	/* pin conflict with ecspi1 */
+	status = "disabled";
+};
+
+&uart3 {
+	/* the uart3 depends on the i2c3, so disable it too. */
+	status = "disabled";
+};
+
+&usbh1 {
+	/* max7310_b on i2c3 is gone */
+	status = "disabled";
+};
+
+&usbotg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6q-sabreauto-ecspi.dts b/arch/arm/boot/dts/imx6q-sabreauto-ecspi.dts
new file mode 100644
index 0000000..cb7f38e
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-sabreauto-ecspi.dts
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2014 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "imx6q-sabreauto.dts"
+
+&gpio5 {
+	eim_d18_steered {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "ecspi1_din";
+	};
+};
+
+&ecspi1 {
+	status = "okay";
+};
+
+&can2 {
+	/* max7310_c on i2c3 is gone */
+	status = "disabled";
+};
+
+&i2c3 {
+	/* pin conflict with ecspi1 */
+	status = "disabled";
+};
+
+&uart3 {
+	/* the uart3 depends on the i2c3, so disable it too. */
+	status = "disabled";
+};
+
+&usbh1 {
+	/* max7310_b on i2c3 is gone */
+	status = "disabled";
+};
+
+&usbotg {
+	/* max7310_c on i2c3 is gone */
+	status = "okay";
+	dr_mode = "peripheral";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 54b0139..b83efc3 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -375,6 +375,7 @@
 				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x80000000
 				MX6QDL_PAD_SD2_DAT2__GPIO1_IO13  0x80000000
 				MX6QDL_PAD_GPIO_18__SD3_VSELECT 0x17059
+				MX6QDL_PAD_EIM_A24__GPIO5_IO04   0x80000000
 			>;
 		};
 
-- 
2.7.4
