Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC020C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F3E2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfBSKFO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:05:14 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28357 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727361AbfBSKEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:04:42 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JA1wJB005510;
        Tue, 19 Feb 2019 11:04:35 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qpc6kq30u-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 19 Feb 2019 11:04:35 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5E7743F;
        Tue, 19 Feb 2019 10:04:34 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3A2672796;
        Tue, 19 Feb 2019 10:04:34 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 19 Feb
 2019 11:04:33 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Tue, 19 Feb 2019 11:04:33 +0100
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
CC:     Pascal PAILLET-LME <p.paillet@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 4/8] dt-bindings: regulator: remove regulator pull-down
 support for stpmic1
Thread-Topic: [PATCH 4/8] dt-bindings: regulator: remove regulator pull-down
 support for stpmic1
Thread-Index: AQHUyDqDB1q5RfHEh0+Y/zPyKTc5gQ==
Date:   Tue, 19 Feb 2019 10:04:33 +0000
Message-ID: <1550570647-9555-5-git-send-email-p.paillet@st.com>
References: <1550570647-9555-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1550570647-9555-1-git-send-email-p.paillet@st.com>
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator high pull down are enabled by default so remove support in the
driver.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
---
 Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
index de27897..bf9385b 100644
--- a/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
@@ -23,8 +23,6 @@ Switches are fixed voltage regulators with only enable/disable capability.
 Optional properties:
 - st,mask-reset: mask reset for this regulator: the regulator configuration
   is maintained during pmic reset.
-- regulator-pull-down: enable high pull down
-  if not specified light pull down is used
 - regulator-over-current-protection:
     if set, all regulators are switched off in case of over-current detection
     on this regulator,
-- 
1.9.1
