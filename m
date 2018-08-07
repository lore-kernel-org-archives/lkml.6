Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F7EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19D52178F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19D52178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbeHGOPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:15:36 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46328 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727429AbeHGOPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:15:36 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w77BxUIo011775;
        Tue, 7 Aug 2018 14:01:07 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2knxjnag0j-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 07 Aug 2018 14:01:07 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6AB0D31;
        Tue,  7 Aug 2018 12:01:06 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3DCD32D53;
        Tue,  7 Aug 2018 12:01:06 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 7 Aug
 2018 14:01:05 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Tue, 7 Aug 2018 14:01:05 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 1/3] ARM: dts: stm32: Fix DT dtc warnings for stm32h7
Thread-Topic: [PATCH 1/3] ARM: dts: stm32: Fix DT dtc warnings for stm32h7
Thread-Index: AQHULj6+k3oL7dNsFkin1TxJ5kDhZKS0CGyAgAAE3gCAAAFUgA==
Date:   Tue, 7 Aug 2018 12:01:05 +0000
Message-ID: <9570b293-6467-c8bb-4f08-71c07371730a@st.com>
References: <1533639995-27047-1-git-send-email-patrice.chotard@st.com>
 <1533639995-27047-2-git-send-email-patrice.chotard@st.com>
 <8bd7a402-fc88-f4d9-451f-9533f2898ce0@st.com>
 <f5933d5c-8da3-5112-351c-6b1ba669a9b6@st.com>
In-Reply-To: <f5933d5c-8da3-5112-351c-6b1ba669a9b6@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9594A8CC688964182CC4AB44FE41948@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSB3aWxsIHNlbmQgYSB2Mg0KDQpUaGFua3MgZm9yIHJldmlld2luZyA7LSkNCg0KUGF0cmljZQ0K
DQpPbiAwOC8wNy8yMDE4IDAxOjU2IFBNLCBBbGV4YW5kcmUgVG9yZ3VlIHdyb3RlOg0KPiBIaSBQ
YXRyaWNlDQo+IA0KPiBPbiAwOC8wNy8yMDE4IDAxOjM4IFBNLCBBbGV4YW5kcmUgVG9yZ3VlIHdy
b3RlOg0KPj4+ICvCoMKgwqAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+Pj4gK8KgwqDCoCAjc2l6
ZS1jZWxscyA9IDwxPjsNCj4+PiArDQo+Pj4gwqDCoMKgwqDCoCBjbG9ja3Mgew0KPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBjbGtfaHNlOiBjbGstaHNlIHsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAjY2xvY2stY2VsbHMgPSA8MD47DQo+Pj4gQEAgLTYwLDcgKzYyLDcgQEANCj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbG9jay1mcmVxdWVuY3kgPSA8MzI3Njg+Ow0KPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCB9Ow0KPj4+IC3CoMKgwqDCoMKgwqDCoCBjbGtfaTJzOiBpMnNf
Y2tpbiB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGNsa19pMnM6IGkycy1ja2luIHsNCj4+DQo+PiBj
bG9jayBkcml2ZXIgZGVhbHMgd2l0aCAiaTJzX2NraW4iIGZvciBjbG9ja8KgIHNvdXJjZSBzZWxl
Y3Rpb24uIEkgbmVlZCANCj4+IHRvIGNoZWNrIGRlZXBlciBpZiB0aGlzIGNoYW5nZSBjb3VsZCBj
YXVzZSBhbiBpc3N1ZS4NCj4gDQo+IFNvcnJ5IEkgZGlkbid0IGNoZWNrIGluIHRoZSB3ZWxsIGRy
aXZlci4gQXMgZmFyIEkgY2FuIHNlZSBpdCdzIG9rIGZvciANCj4gdGhpcyBwYXJ0IG9mIHBhdGNo
Lg0KPiANCj4gY2hlZXJzDQo+IEFsZXgNCj4gDQo+Pg0KPj4gdGh4DQo+PiBBbGV4
