Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C5FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1882206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbeLNOfK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:35:10 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42175 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729766AbeLNOeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:34:44 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBEEVIJZ030822;
        Fri, 14 Dec 2018 15:34:23 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2p85qkm06d-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 14 Dec 2018 15:34:23 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1DFF934;
        Fri, 14 Dec 2018 14:34:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 09EA052EC;
        Fri, 14 Dec 2018 14:34:23 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 14 Dec
 2018 15:34:22 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 14 Dec 2018 15:34:22 +0100
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>
CC:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 3/6] dt-bindings: input: document stpmic1 pmic onkey
Thread-Topic: [PATCH v8 3/6] dt-bindings: input: document stpmic1 pmic onkey
Thread-Index: AQHUk7oaecGFTE0pbk2lhI+DNvoCJg==
Date:   Fri, 14 Dec 2018 14:34:22 +0000
Message-ID: <1544798057-1499-4-git-send-email-p.paillet@st.com>
References: <1544798057-1499-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1544798057-1499-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stpmic1 pmic is able to manage an onkey button. It can be configured
to shut-down the power supplies on a long key-press with an adjustable
duration.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
changes in v8: nothing

 .../devicetree/bindings/input/st,stpmic1-onkey.txt | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt

diff --git a/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt b/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
new file mode 100644
index 0000000..4494613
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
@@ -0,0 +1,28 @@
+STMicroelectronics STPMIC1 Onkey
+
+Required properties:
+
+- compatible = "st,stpmic1-onkey";
+- interrupts: interrupt line to use
+- interrupt-names = "onkey-falling", "onkey-rising"
+	onkey-falling: happens when onkey is pressed; IT_PONKEY_F of pmic
+	onkey-rising: happens when onkey is released; IT_PONKEY_R of pmic
+
+Optional properties:
+
+- st,onkey-clear-cc-flag: onkey is able power on after an
+  over-current shutdown event.
+- st,onkey-pu-inactive: onkey pull up is not active
+- power-off-time-sec: Duration in seconds which the key should be kept
+        pressed for device to power off automatically (from 1 to 16 seconds).
+        see See Documentation/devicetree/bindings/input/keys.txt
+
+Example:
+
+onkey {
+	compatible = "st,stpmic1-onkey";
+	interrupt-parent = <&pmic>;
+	interrupts = <IT_PONKEY_F 0>,<IT_PONKEY_R 1>;
+	interrupt-names = "onkey-falling", "onkey-rising";
+	power-off-time-sec = <10>;
+};
-- 
1.9.1
