Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CC9C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380232086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfANKFv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:05:51 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43367 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726528AbfANKFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:05:44 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0E9uPsk014550;
        Mon, 14 Jan 2019 11:05:18 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2pyby0ybs5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 14 Jan 2019 11:05:18 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5207C34;
        Mon, 14 Jan 2019 10:05:16 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E2ED62AF1;
        Mon, 14 Jan 2019 10:05:15 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 14 Jan
 2019 11:05:15 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Mon, 14 Jan 2019 11:05:15 +0100
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
CC:     Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH RESEND v8 1/6] dt-bindings: mfd: document stpmic1
Thread-Topic: [PATCH RESEND v8 1/6] dt-bindings: mfd: document stpmic1
Thread-Index: AQHUq/CllHjuf04plEW9N/shkZUbKw==
Date:   Mon, 14 Jan 2019 10:05:15 +0000
Message-ID: <1547460290-21049-2-git-send-email-p.paillet@st.com>
References: <1547460290-21049-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1547460290-21049-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STPMIC1 is a PMIC from STMicroelectronics. The STPMIC1 integrates 10
regulators, 3 power switches, a watchdog and an input for a power on key.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
changes in v8: nothing

 .../devicetree/bindings/mfd/st,stpmic1.txt         | 61 ++++++++++++++++++++++
 include/dt-bindings/mfd/st,stpmic1.h               | 50 ++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
 create mode 100644 include/dt-bindings/mfd/st,stpmic1.h

diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.txt b/Documentation/devicetree/bindings/mfd/st,stpmic1.txt
new file mode 100644
index 0000000..afd45c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.txt
@@ -0,0 +1,61 @@
+* STMicroelectronics STPMIC1 Power Management IC
+
+Required properties:
+- compatible:		: "st,stpmic1"
+- reg:			: The I2C slave address for the STPMIC1 chip.
+- interrupts:		: The interrupt line the device is connected to.
+- #interrupt-cells:	: Should be 1.
+- interrupt-controller:	: Marks the device node as an interrupt controller.
+			    Interrupt numbers are defined at
+			    dt-bindings/mfd/st,stpmic1.h.
+
+STPMIC1 consists in a varied group of sub-devices.
+Each sub-device binding is be described in own documentation file.
+
+Device			 Description
+------			------------
+st,stpmic1-onkey	: Power on key, see ../input/st,stpmic1-onkey.txt
+st,stpmic1-regulators	: Regulators, see ../regulator/st,stpmic1-regulator.txt
+st,stpmic1-wdt		: Watchdog, see ../watchdog/st,stpmic1-wdt.txt
+
+Example:
+
+#include <dt-bindings/mfd/st,stpmic1.h>
+
+pmic: pmic@33 {
+	compatible = "st,stpmic1";
+	reg = <0x33>;
+	interrupt-parent = <&gpioa>;
+	interrupts = <0 2>;
+
+	interrupt-controller;
+	#interrupt-cells = <2>;
+
+	onkey {
+		compatible = "st,stpmic1-onkey";
+		interrupts = <IT_PONKEY_F 0>,<IT_PONKEY_R 1>;
+		interrupt-names = "onkey-falling", "onkey-rising";
+		power-off-time-sec = <10>;
+	};
+
+	watchdog {
+		compatible = "st,stpmic1-wdt";
+	};
+
+	regulators {
+		compatible = "st,stpmic1-regulators";
+
+		vdd_core: buck1 {
+			regulator-name = "vdd_core";
+			regulator-boot-on;
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <1200000>;
+		};
+		vdd: buck3 {
+			regulator-name = "vdd";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-pull-down;
+		};
+	};
diff --git a/include/dt-bindings/mfd/st,stpmic1.h b/include/dt-bindings/mfd/st,stpmic1.h
new file mode 100644
index 0000000..321cd087
--- /dev/null
+++ b/include/dt-bindings/mfd/st,stpmic1.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Philippe Peurichard <philippe.peurichard@st.com>,
+ * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
+ */
+
+#ifndef __DT_BINDINGS_STPMIC1_H__
+#define __DT_BINDINGS_STPMIC1_H__
+
+/* IRQ definitions */
+#define IT_PONKEY_F	0
+#define IT_PONKEY_R	1
+#define IT_WAKEUP_F	2
+#define IT_WAKEUP_R	3
+#define IT_VBUS_OTG_F	4
+#define IT_VBUS_OTG_R	5
+#define IT_SWOUT_F	6
+#define IT_SWOUT_R	7
+
+#define IT_CURLIM_BUCK1	8
+#define IT_CURLIM_BUCK2	9
+#define IT_CURLIM_BUCK3	10
+#define IT_CURLIM_BUCK4	11
+#define IT_OCP_OTG	12
+#define IT_OCP_SWOUT	13
+#define IT_OCP_BOOST	14
+#define IT_OVP_BOOST	15
+
+#define IT_CURLIM_LDO1	16
+#define IT_CURLIM_LDO2	17
+#define IT_CURLIM_LDO3	18
+#define IT_CURLIM_LDO4	19
+#define IT_CURLIM_LDO5	20
+#define IT_CURLIM_LDO6	21
+#define IT_SHORT_SWOTG	22
+#define IT_SHORT_SWOUT	23
+
+#define IT_TWARN_F	24
+#define IT_TWARN_R	25
+#define IT_VINLOW_F	26
+#define IT_VINLOW_R	27
+#define IT_SWIN_F	30
+#define IT_SWIN_R	31
+
+/* BUCK MODES definitions */
+#define STPMIC1_BUCK_MODE_NORMAL 0
+#define STPMIC1_BUCK_MODE_LP 2
+
+#endif /* __DT_BINDINGS_STPMIC1_H__ */
-- 
1.9.1
