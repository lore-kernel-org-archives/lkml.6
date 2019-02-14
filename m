Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5426C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF862229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfBNO4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:56:14 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15375 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732894AbfBNO4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:56:12 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EEjsnV023434;
        Thu, 14 Feb 2019 15:55:53 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qmxr73qss-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 14 Feb 2019 15:55:53 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C76A534;
        Thu, 14 Feb 2019 14:55:52 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 90CF8569D;
        Thu, 14 Feb 2019 14:55:52 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 Feb
 2019 15:55:52 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Thu, 14 Feb 2019 15:55:52 +0100
From:   Christophe ROULLIER <christophe.roullier@st.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Peppe CAVALLARO <peppe.cavallaro@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 7/8] ARM: dts: stm32: Add Ethernet support on stm32h7 SOC
 and activate it for eval and disco boards
Thread-Topic: [PATCH 7/8] ARM: dts: stm32: Add Ethernet support on stm32h7 SOC
 and activate it for eval and disco boards
Thread-Index: AQHUxHVhnxyM5yabkEOxlQrhZI8fig==
Date:   Thu, 14 Feb 2019 14:55:51 +0000
Message-ID: <5c59f60a-2364-a4a8-117e-b485647fd88e@st.com>
References: <1550126763-22669-1-git-send-email-christophe.roullier@st.com>
 <1550126763-22669-8-git-send-email-christophe.roullier@st.com>
 <20190214134414.GB5699@lunn.ch>
In-Reply-To: <20190214134414.GB5699@lunn.ch>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <35B4D304070043499A7C310BE66315CA@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xNC8xOSAyOjQ0IFBNLCBBbmRyZXcgTHVubiB3cm90ZToNCj4gT24gVGh1LCBGZWIgMTQs
IDIwMTkgYXQgMDc6NDY6MDJBTSArMDEwMCwgQ2hyaXN0b3BoZSBSb3VsbGllciB3cm90ZToNCj4+
ICsJbWRpbzAgew0KPj4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+PiArCQkjc2l6ZS1jZWxs
cyA9IDwwPjsNCj4+ICsJCWNvbXBhdGlibGUgPSAic25wcyxkd21hYy1tZGlvIjsNCj4+ICsJCXBo
eTE6IGV0aGVybmV0LXBoeUAxIHsNCj4+ICsJCQlyZWcgPSA8MD47DQo+PiArCQl9Ow0KPiANCj4g
VGhlIHJlZyB2YWx1ZSBzaG91bGQgYmUgdGhlIHNhbWUgYXMgZXRoZXJuZXQtcGh5QFguDQo+IA0K
PiAgICAgIEFuZHJldw0KPj4gKwltZGlvMCB7DQo+PiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsN
Cj4+ICsJCSNzaXplLWNlbGxzID0gPDA+Ow0KPj4gKwkJY29tcGF0aWJsZSA9ICJzbnBzLGR3bWFj
LW1kaW8iOw0KPj4gKwkJcGh5MTogZXRoZXJuZXQtcGh5QDEgew0KPj4gKwkJCXJlZyA9IDwwPjsN
Cj4+ICsJCX07DQo+IA0KPiBIZXJlIGFzIHdlbGwuDQo+IA0KPiAgICAgICBBbmRyZXcNCj4gDQoN
CkhpIEFuZHJldywNCg0KT2sgSSB3aWxsIHVwZGF0ZS4NCg0KVGhhbmtzLg0KDQpDaHJpc3RvcGhl
