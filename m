Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921FFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B142077C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B142077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbeKOS7v convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:59:51 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:8134 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728634AbeKOS7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:59:51 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAF8nPL6016749;
        Thu, 15 Nov 2018 09:52:31 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2nr7cygd6m-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 15 Nov 2018 09:52:31 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8BF3A31;
        Thu, 15 Nov 2018 08:52:30 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4D94115BD;
        Thu, 15 Nov 2018 08:52:30 +0000 (GMT)
Received: from SFHDAG3NODE1.st.com (10.75.127.7) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 15 Nov
 2018 09:52:29 +0100
Received: from SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86]) by
 SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86%20]) with mapi id
 15.00.1347.000; Thu, 15 Nov 2018 09:52:29 +0100
From:   Bich HEMON <bich.hemon@st.com>
To:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 3/3] ARM: dts: stm32: add can1 sleep pins muxing on
 stm32mp157c-ev1 board
Thread-Topic: [PATCH 3/3] ARM: dts: stm32: add can1 sleep pins muxing on
 stm32mp157c-ev1 board
Thread-Index: AQHUfMCKP6B+lJDFdkSHxkjZVSBhXQ==
Date:   Thu, 15 Nov 2018 08:52:29 +0000
Message-ID: <1542271942-28130-4-git-send-email-bich.hemon@st.com>
References: <1542271942-28130-1-git-send-email-bich.hemon@st.com>
In-Reply-To: <1542271942-28130-1-git-send-email-bich.hemon@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-15_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl sleep state for can1 on stm32mp157c-ev1.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 063ee8a..fdc4c92 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -124,8 +124,9 @@
 };
 
 &m_can1 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&m_can1_pins_a>;
+	pinctrl-1 = <&m_can1_sleep_pins_a>;
 	status = "okay";
 };
 
-- 
1.9.1
