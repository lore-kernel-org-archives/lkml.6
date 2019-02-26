Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AABAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BA72146F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfBZKaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:30:39 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14291 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725908AbfBZKaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:30:39 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QARn5D014088;
        Tue, 26 Feb 2019 11:30:17 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qtv6cqmrr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Feb 2019 11:30:17 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3F13F31;
        Tue, 26 Feb 2019 10:30:14 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node1.st.com [10.75.127.10])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C82AB2958;
        Tue, 26 Feb 2019 10:30:12 +0000 (GMT)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG4NODE1.st.com
 (10.75.127.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Feb
 2019 11:30:12 +0100
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1347.000; Tue, 26 Feb 2019 11:30:12 +0100
From:   Christophe ROULLIER <christophe.roullier@st.com>
To:     Rob Herring <robh@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
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
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: [PATCH V2 3/8] dt-bindings: net: stmmac: add phys config
 properties
Thread-Topic: [PATCH V2 3/8] dt-bindings: net: stmmac: add phys config
 properties
Thread-Index: AQHUyoiWpExj405+ekOaRsfcLh6Cn6XsdFCAgAViVgA=
Date:   Tue, 26 Feb 2019 10:30:12 +0000
Message-ID: <419f54c3-08a7-42be-4e1a-a7c0f61a4543@st.com>
References: <1550824089-19961-1-git-send-email-christophe.roullier@st.com>
 <1550824089-19961-4-git-send-email-christophe.roullier@st.com>
 <20190223001651.GA22381@bogus>
In-Reply-To: <20190223001651.GA22381@bogus>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F65357342655644ADC33EBEC8F06FC7@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yMy8xOSAxOjE2IEFNLCBSb2IgSGVycmluZyB3cm90ZToNCj4gT24gRnJpLCBGZWIgMjIs
IDIwMTkgYXQgMDk6Mjg6MDRBTSArMDEwMCwgQ2hyaXN0b3BoZSBSb3VsbGllciB3cm90ZToNCj4+
IEFkZCBwcm9wZXJ0aWVzIHRvIHN1cHBvcnQgYWxsIFBoeSBjb25maWcNCj4+ICAgUEhZX01PREUJ
KE1JSSxHTUlJLCBSTUlJLCBSR01JSSkgYW5kIGluIG5vcm1hbCwgUEhZIHdvIGNyeXN0YWwgKDI1
TWh6KSwNCj4+ICAgUEhZIHdvIGNyeXN0YWwgKDUwTWh6KSwgTm8gMTI1TWh6IGZyb20gUEhZIGNv
bmZpZy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIFJvdWxsaWVyIDxjaHJpc3Rv
cGhlLnJvdWxsaWVyQHN0LmNvbT4NCj4+IC0tLQ0KPj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L3N0bTMyLWR3bWFjLnR4dCB8IDYgKysrLS0tDQo+PiAgIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvc3RtMzItZHdtYWMudHh0
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9zdG0zMi1kd21hYy50eHQN
Cj4+IGluZGV4IDEzNDEwMTIuLmY0MmRjNjggMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3N0bTMyLWR3bWFjLnR4dA0KPj4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9zdG0zMi1kd21hYy50eHQNCj4+IEBAIC0y
NCw5ICsyNCw5IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+PiAgIAkgICAgICAgZW5jb21wYXNl
cyB0aGUgZ2x1ZSByZWdpc3RlciwgYW5kIHRoZSBvZmZzZXQgb2YgdGhlIGNvbnRyb2wgcmVnaXN0
ZXIuDQo+PiAgIA0KPj4gICBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPj4gLS0gY2xvY2stbmFtZXM6
ICAgICBGb3IgTVBVIGZhbWlseSAibWFjLWNsay1jayIgZm9yIFBIWSB3aXRob3V0IHF1YXJ0eg0K
Pj4gLS0gc3QsaW50LXBoeWNsayAoYm9vbGVhbikgOiAgdmFsaWQgb25seSB3aGVyZSBQSFkgZG8g
bm90IGhhdmUgcXVhcnR6IGFuZCBuZWVkIHRvIGJlIGNsb2NrDQo+PiAtCSAgICAgICAgICAgYnkg
UkNDDQo+IA0KPiBZb3UgY2FuJ3QganVzdCByZW1vdmUgcHJvcGVydGllcy4NCg0KVGhlcmUgaXMg
bm8gcmlzayB0byByZW1vdmUvcmVuYW1lIHRoZXNlIDIgcHJvcGVydGllcywgYmVjYXVzZSBpdCBp
cyANCnNwZWNpZmljIGJvYXJkIHdoaWNoIGlzIG5ldmVyIGRlcGxveWVkLg0KV2l0aCBuZXcgcHJv
cGVydGllcyAocmVuYW1pbmcgY2xvY2sgKGV0aC1jaykgKyBzdCxldGhfY2xrX3NlbCBhbmQgDQpz
dCxldGhfcmVmX2Nsa19zZWwsIHdlIGFyZSBtYW5hZ2VkIGFsbCBraW5kIG9mIHNwZWNpZmljIGJv
YXJkcyBzdG0zMm1wMQ0KU28gbm8gcmlzayBvZiBiYWNrd2FyZCBjb21wYXRpYmxlLg0KDQo+IA0K
Pj4gKy0gY2xvY2stbmFtZXM6ICAgICBGb3IgTVBVIGZhbWlseSAiZXRoLWNrIiBmb3IgUEhZIHdp
dGhvdXQgcXVhcnR6DQo+PiArLSBzdCxldGhfY2xrX3NlbCAoYm9vbGVhbikgOiBzZXQgdGhpcyBw
cm9wZXJ0eSBpbiBSR01JSSBQSFkgd2hlbiB5b3UgZG8gbm90IHdhbnQgdXNlIDEyNU1oeg0KPj4g
Ky0gc3QsZXRoX3JlZl9jbGtfc2VsIChib29sZWFuKSA6ICBzZXQgdGhpcyBwcm9wZXJ0eSBpbiBS
TUlJIG1vZGUgd2hlbiB5b3UgaGF2ZSBQSFkgd2l0aG91dCBjcnlzdGFsIDUwTUh6DQo+IA0KPiBz
L18vLS8NCj4gDQo+ICdzZWwnIEkgYXNzdW1lIGlzIHNob3J0IGZvciBzZWxlY3QsIGJ1dCB0aGUg
bmFtaW5nIGhlcmUgYW5kIGRlc2NyaXB0aW9uDQo+IGRvbid0IHJlYWxseSB0ZWxsIG1lIHdoYXQg
SSdtIGdldHRpbmcuDQo+IA0KDQpPaywgUm9iLCBJIHdpbGwgdXBkYXRlIHdpdGggeW91ciByZWNv
bW1lbmRhdGlvbnMNCg0KPiBSb2INCj4gDQo=
