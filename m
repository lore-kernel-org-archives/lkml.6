Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E54EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1F62075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1F62075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbeIGRl3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:41:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:52119 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729667AbeIGRlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:41:16 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w87Cx7Va005582;
        Fri, 7 Sep 2018 14:59:46 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mbjwpjcmf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 07 Sep 2018 14:59:46 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8E1043F;
        Fri,  7 Sep 2018 12:59:45 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6E8B62D4D;
        Fri,  7 Sep 2018 12:59:45 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 7 Sep
 2018 14:59:45 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 7 Sep 2018 14:59:45 +0200
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
Subject: [PATCH V2 5/8] dt-bindings: input: document stpmic1 pmic onkey
Thread-Topic: [PATCH V2 5/8] dt-bindings: input: document stpmic1 pmic onkey
Thread-Index: AQHURqqmhndlp2hGlk2oSqFoX+/HCQ==
Date:   Fri, 7 Sep 2018 12:59:45 +0000
Message-ID: <1536325173-16617-6-git-send-email-p.paillet@st.com>
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

The stpmic1 pmic is able to manage an onkey button. It can be configured
to shut-down the power supplies on a long key-press with an adjustable
duration.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 .../devicetree/bindings/input/st,stpmic1-onkey.txt | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt

diff --git a/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt b/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
new file mode 100644
index 0000000..b0db90d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
@@ -0,0 +1,31 @@
+STMicroelectronics STPMIC1 Onkey
+
+Required properties:
+
+- compatible = "st,stpmic1-onkey";
+- interrupt-parent: phandle to the parent interrupt controller
+- interrupts: interrupt line to use
+- interrupt-names = "onkey-falling", "onkey-rising"
+	onkey-falling: happens when onkey is pressed; IT_PONKEY_F of pmic
+	onkey-rising: happens when onkey is released; IT_PONKEY_R of pmic
+
+Optional properties:
+
+- st,onkey-pwroff-enabled: power off on long key-press
+- st,onkey-long-press-seconds: long key-press duration from 1 to 16s
+  (default 16s)
+- st,onkey-clear-cc-flag: onkey is able power on after an
+  over-current shutdown event.
+- st,onkey-pu-inactive: onkey pull up is not active
+
+Example:
+
+onkey {
+	compatible = "st,stpmic1-onkey";
+	interrupt-parent = <&pmic>;
+	interrupts = <IT_PONKEY_F 0>,<IT_PONKEY_R 1>;
+	interrupt-names = "onkey-falling", "onkey-rising";
+	status = "okay";
+	st,onkey-pwroff-enabled;
+	st,onkey-long-press-seconds = <10>;
+};
-- 
1.9.1
