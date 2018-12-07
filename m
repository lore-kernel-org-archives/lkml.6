Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84FBC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9E7208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9E7208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeLGK2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:28:38 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:2102 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbeLGK2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:28:38 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB7AQOQ2012297;
        Fri, 7 Dec 2018 11:28:04 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2p3w2s9hpv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 07 Dec 2018 11:28:04 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7C82A3A;
        Fri,  7 Dec 2018 10:28:03 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 50F6B2A17;
        Fri,  7 Dec 2018 10:28:03 +0000 (GMT)
Received: from SFHDAG3NODE2.st.com (10.75.127.8) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 7 Dec
 2018 11:28:04 +0100
Received: from SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96]) by
 SFHDAG3NODE2.st.com ([fe80::b82f:1ce:8854:5b96%20]) with mapi id
 15.00.1347.000; Fri, 7 Dec 2018 11:28:04 +0100
From:   David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: dts: stm32: Enable thermal sensor support on
 STM32MP157c-ed1
Thread-Topic: [PATCH] ARM: dts: stm32: Enable thermal sensor support on
 STM32MP157c-ed1
Thread-Index: AQHUjheJEnpwhyHooU+HoBCMfbMWLw==
Date:   Fri, 7 Dec 2018 10:28:04 +0000
Message-ID: <1544178482-30494-1-git-send-email-david.hernandezsanchez@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <64AE5F7BD18D6941882D819B88A0C866@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-07_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RW5hYmxlIFNUTTMyIERpZ2l0YWwgVGhlcm1hbCBTZW5zb3IgKGR0cykgZHJpdmVyIGZvcg0KU1RN
MzJNUDE1N2MtZWQxIGJvYXJkLg0KDQpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBIZXJuYW5kZXogU2Fu
Y2hleiA8ZGF2aWQuaGVybmFuZGV6c2FuY2hlekBzdC5jb20+DQoNCmRpZmYgLS1naXQgYS9hcmNo
L2FybS9ib290L2R0cy9zdG0zMm1wMTU3Yy1lZDEuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvc3Rt
MzJtcDE1N2MtZWQxLmR0cw0KaW5kZXggYzNlY2IxZS4uOThlZjdhMCAxMDA2NDQNCi0tLSBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL3N0bTMybXAxNTdjLWVkMS5kdHMNCisrKyBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL3N0bTMybXAxNTdjLWVkMS5kdHMNCkBAIC00OSw2ICs0OSwxMCBAQA0KIAl9Ow0KIH07DQog
DQorJmR0cyB7DQorCXN0YXR1cyA9ICJva2F5IjsNCit9Ow0KKw0KICZpMmM0IHsNCiAJcGluY3Ry
bC1uYW1lcyA9ICJkZWZhdWx0IjsNCiAJcGluY3RybC0wID0gPCZpMmM0X3BpbnNfYT47DQotLSAN
CjIuNy40DQo=
