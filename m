Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201EAECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F692084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F692084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbeGSOLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:11:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:2275 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731577AbeGSOLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:11:32 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6JDNm0e013885;
        Thu, 19 Jul 2018 15:27:58 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2kap7s9mu1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 19 Jul 2018 15:27:58 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DA12231;
        Thu, 19 Jul 2018 13:27:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B5E5B2CC6;
        Thu, 19 Jul 2018 13:27:57 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 19 Jul
 2018 15:27:57 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Thu, 19 Jul 2018 15:27:57 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>
Subject: Re: [U-BOOT internal] ARM: dts: stm32: Add clk-lse node's label on
 stm32f429
Thread-Topic: [U-BOOT internal] ARM: dts: stm32: Add clk-lse node's label on
 stm32f429
Thread-Index: AQHUH2HvV/XOq0riq0ug9kPTNucwfKSWaFAA
Date:   Thu, 19 Jul 2018 13:27:56 +0000
Message-ID: <a4472301-1394-3680-079d-b7eab8a6a917@st.com>
References: <1532005842-3264-1-git-send-email-patrice.chotard@st.com>
In-Reply-To: <1532005842-3264-1-git-send-email-patrice.chotard@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA478747DF938A42BFA53932E3DBD9CE@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-19_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnksIGRvbid0IHRha2UgY2FyZSBhYm91dCB0aGlzIHBhdGNoLCBpdCB3YXMgc2VuZCB1c2lu
ZyB0aGUgd3Jvbmcgc2NyaXB0DQoNClBhdHJpY2UNCg0KT24gMDcvMTkvMjAxOCAwMzoxMCBQTSwg
cGF0cmljZS5jaG90YXJkQHN0LmNvbSB3cm90ZToNCj4gRnJvbTogUGF0cmljZSBDaG90YXJkIDxw
YXRyaWNlLmNob3RhcmRAc3QuY29tPg0KPiANCj4gQWRkIG1pc3NpbmcgY2xrX2xzZSBsYWJlbCBm
b3Igbm9kZSBjbGstbHNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGF0cmljZSBDaG90YXJkIDxw
YXRyaWNlLmNob3RhcmRAc3QuY29tPg0KPiAtLS0NCj4gICBhcmNoL2FybS9ib290L2R0cy9zdG0z
MmY0MjkuZHRzaSB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zdG0zMmY0
MjkuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMyZjQyOS5kdHNpDQo+IGluZGV4IGVkZTc3
ZTBmMWM0MS4uNjQyNzhlODFiYzA4IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9z
dG0zMmY0MjkuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9zdG0zMmY0MjkuZHRzaQ0K
PiBAQCAtNTgsNyArNTgsNyBAQA0KPiAgIAkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwwPjsNCj4gICAJ
CX07DQo+ICAgDQo+IC0JCWNsay1sc2Ugew0KPiArCQljbGtfbHNlOiBjbGstbHNlIHsNCj4gICAJ
CQkjY2xvY2stY2VsbHMgPSA8MD47DQo+ICAgCQkJY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7
DQo+ICAgCQkJY2xvY2stZnJlcXVlbmN5ID0gPDMyNzY4PjsNCj4g
