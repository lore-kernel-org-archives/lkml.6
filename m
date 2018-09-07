Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28007C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCFB2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCFB2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbeIGRlk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:41:40 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:48539 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729660AbeIGRlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:41:15 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w87CxOKt020861;
        Fri, 7 Sep 2018 14:59:45 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mbhwsamhv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 07 Sep 2018 14:59:45 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A9EE03A;
        Fri,  7 Sep 2018 12:59:44 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8242A2D4A;
        Fri,  7 Sep 2018 12:59:44 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 7 Sep
 2018 14:59:44 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 7 Sep 2018 14:59:44 +0200
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
        "eballetbo@gmail.com" <eballetbo@gmail.com>
CC:     Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH V2 3/8] dt-bindings: regulator: document stpmic1 pmic
 regulators
Thread-Topic: [PATCH V2 3/8] dt-bindings: regulator: document stpmic1 pmic
 regulators
Thread-Index: AQHURqqlamEul0sXXU62CBrDAbuQcw==
Date:   Fri, 7 Sep 2018 12:59:44 +0000
Message-ID: <1536325173-16617-4-git-send-email-p.paillet@st.com>
References: <1536325173-16617-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1536325173-16617-1-git-send-email-p.paillet@st.com>
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: pascal paillet <p.paillet@st.com>

The STPMIC1 regulators supply power to the application processor as well as
to the external system peripherals such as DDR, Flash memories and system
devices.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
changes in v2:
* the hardware component has been renamed from stpmu1 to stpmic1 !
* replace _ with - in properties name
* remove deprecated regulator-compatible from the example
Rob, the st,mask_reset name is taken from the data-sheet. I have modified the 
description. I hope there is no confusion with bit masking know.

 .../bindings/regulator/st,stpmic1-regulator.txt    | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
new file mode 100644
index 0000000..a3f4762
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
@@ -0,0 +1,68 @@
+STMicroelectronics STPMIC1 Voltage regulators
+
+Regulator Nodes are optional depending on needs.
+
+Available Regulators in STPMIC1 device are:
+  - buck1 for Buck BUCK1
+  - buck2 for Buck BUCK2
+  - buck3 for Buck BUCK3
+  - buck4 for Buck BUCK4
+  - ldo1 for LDO LDO1
+  - ldo2 for LDO LDO2
+  - ldo3 for LDO LDO3
+  - ldo4 for LDO LDO4
+  - ldo5 for LDO LDO5
+  - ldo6 for LDO LDO6
+  - vref_ddr for LDO Vref DDR
+  - boost for Buck BOOST
+  - pwr_sw1 for VBUS_OTG switch
+  - pwr_sw2 for SW_OUT switch
+
+Switches are fixed voltage regulators with only enable/disable capability.
+
+Optional properties:
+- st,mask-reset: mask reset for this regulator: the regulator configuration
+  is maintained during pmic reset.
+- regulator-pull-down: enable high pull down
+  if not specified light pull down is used
+- regulator-over-current-protection:
+    if set, all regulators are switched off in case of over-current detection
+    on this regulator,
+    if not set, the driver only sends an over-current event.
+- interrupt-parent: phandle to the parent interrupt controller
+- interrupts: index of current limit detection interrupt
+- <regulator>-supply: phandle to the parent supply/regulator node
+	each regulator supply can be described except vref_ddr.
+
+Example:
+regulators {
+	compatible = "st,stpmic1-regulators";
+
+	ldo6-supply = <&v3v3>;
+
+	vdd_core: buck1 {
+		regulator-name = "vdd_core";
+		interrupts = <IT_CURLIM_BUCK1 0>;
+		interrupt-parent = <&pmic>;
+		st,mask-reset;
+		regulator-pull-down;
+		regulator-min-microvolt = <700000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
+	v3v3: buck4 {
+		regulator-name = "v3v3";
+		interrupts = <IT_CURLIM_BUCK4 0>;
+		interrupt-parent = <&mypmic>;
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	v1v8: ldo6 {
+		regulator-name = "v1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-over-current-protection;
+	};
+};
-- 
1.9.1
