Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D20C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1370A2156B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1370A2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbeGEPQg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:16:36 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15319 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754330AbeGEPOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:14:52 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w65F9KNp017110;
        Thu, 5 Jul 2018 17:14:25 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2k1k1j0twv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 17:14:25 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DFA7B3D;
        Thu,  5 Jul 2018 15:14:24 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BE7AF26DF;
        Thu,  5 Jul 2018 15:14:24 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul
 2018 17:14:24 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 5 Jul 2018 17:14:24 +0200
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
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
CC:     Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH 5/8] dt-bindings: input: document stpmu1 pmic onkey
Thread-Topic: [PATCH 5/8] dt-bindings: input: document stpmu1 pmic onkey
Thread-Index: AQHUFHLbkAuWORwl9ECG4KcKZQv+TA==
Date:   Thu, 5 Jul 2018 15:14:24 +0000
Message-ID: <1530803657-17684-6-git-send-email-p.paillet@st.com>
References: <1530803657-17684-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1530803657-17684-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: pascal paillet <p.paillet@st.com>

The stpmu1 pmic is able to manage an onkey button. It can be configured
to shut-down the power supplies on a long key-press with an adjustable
duration.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 .../devicetree/bindings/input/st,stpmu1-onkey.txt  | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/st,stpmu1-onkey.txt

diff --git a/Documentation/devicetree/bindings/input/st,stpmu1-onkey.txt b/Documentation/devicetree/bindings/input/st,stpmu1-onkey.txt
new file mode 100644
index 0000000..cc42b7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/st,stpmu1-onkey.txt
@@ -0,0 +1,31 @@
+STMicroelectronics STPMU1 Onkey
+
+Required properties:
+
+- compatible = "st,stpmu1-onkey";
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
+	compatible = "st,stpmu1-onkey";
+	interrupt-parent = <&pmic>;
+	interrupts = <7 0>,<6 1>;
+	interrupt-names = "onkey-falling", "onkey-rising";
+	status = "okay";
+	st,onkey-pwroff-enabled;
+	st,onkey-long-press-seconds = <10>;
+};
-- 
1.9.1
