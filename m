Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6668FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30794208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30794208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeLDILe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:11:34 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28235 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726005AbeLDILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:11:34 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB486Fm3014091;
        Tue, 4 Dec 2018 09:10:54 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2p3uhmpc8e-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 04 Dec 2018 09:10:54 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2ED633A;
        Tue,  4 Dec 2018 08:10:53 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ECB42253F;
        Tue,  4 Dec 2018 08:10:52 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 4 Dec
 2018 09:10:52 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Tue, 4 Dec 2018 09:10:52 +0100
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <grant.likely@arm.com>,
        "Kumar Gala" <kumar.gala@linaro.org>,
        "arm@kernel.org" <arm@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 29/34] dt-bindings: arm: Convert ST STi board/soc
 bindings to json-schema
Thread-Topic: [PATCH v2 29/34] dt-bindings: arm: Convert ST STi board/soc
 bindings to json-schema
Thread-Index: AQHUi0/Fl0DVGNx0wECLP1s4jzgjA6VuKlsA
Date:   Tue, 4 Dec 2018 08:10:52 +0000
Message-ID: <158f1163-3489-3a02-3a37-0ef54148ac59@st.com>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-30-robh@kernel.org>
In-Reply-To: <20181203213223.16986-30-robh@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6D86D7874CABE4FAA6CEA8DA4BD5091@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-04_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iDQoNCk9uIDEyLzMvMTggMTA6MzIgUE0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBDb252
ZXJ0IFNUIFNUaSBTb0MgYmluZGluZ3MgdG8gRFQgc2NoZW1hIGZvcm1hdCB1c2luZyBqc29uLXNj
aGVtYS4NCj4gDQo+IENjOiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+
DQo+IENjOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPg0KPiBDYzogZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUm9iIEhlcnJpbmcgPHJvYmhA
a2VybmVsLm9yZz4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL3N0aS50eHQgfCAyMyAtLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vc3RpLnlhbWwgICAgICAgICAgfCAyMyArKysrKysrKysrKysrKysrKysrDQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPiAg
ZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
c3RpLnR4dA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vc3RpLnlhbWwNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL3N0aS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL3N0aS50eHQNCj4gZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4
IDhkMjdmNmIwODRjNy4uMDAwMDAwMDAwMDAwDQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9hcm0vc3RpLnR4dA0KPiArKysgL2Rldi9udWxsDQo+IEBAIC0xLDIzICsw
LDAgQEANCj4gLVNUIFNUaSBQbGF0Zm9ybXMgRGV2aWNlIFRyZWUgQmluZGluZ3MNCj4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtDQo+IC1Cb2FyZHMgd2l0aCB0
aGUgU1QgU1RpSDQxNSBTb0Mgc2hhbGwgaGF2ZSB0aGUgZm9sbG93aW5nIHByb3BlcnRpZXM6DQo+
IC1SZXF1aXJlZCByb290IG5vZGUgcHJvcGVydHk6DQo+IC1jb21wYXRpYmxlID0gInN0LHN0aWg0
MTUiOw0KPiAtDQo+IC1Cb2FyZHMgd2l0aCB0aGUgU1QgU1RpSDQxNiBTb0Mgc2hhbGwgaGF2ZSB0
aGUgZm9sbG93aW5nIHByb3BlcnRpZXM6DQo+IC1SZXF1aXJlZCByb290IG5vZGUgcHJvcGVydHk6
DQo+IC1jb21wYXRpYmxlID0gInN0LHN0aWg0MTYiOw0KPiAtDQo+IC1Cb2FyZHMgd2l0aCB0aGUg
U1QgU1RpSDQwNyBTb0Mgc2hhbGwgaGF2ZSB0aGUgZm9sbG93aW5nIHByb3BlcnRpZXM6DQo+IC1S
ZXF1aXJlZCByb290IG5vZGUgcHJvcGVydHk6DQo+IC1jb21wYXRpYmxlID0gInN0LHN0aWg0MDci
Ow0KPiAtDQo+IC1Cb2FyZHMgd2l0aCB0aGUgU1QgU1RpSDQxMCBTb0Mgc2hhbGwgaGF2ZSB0aGUg
Zm9sbG93aW5nIHByb3BlcnRpZXM6DQo+IC1SZXF1aXJlZCByb290IG5vZGUgcHJvcGVydHk6DQo+
IC1jb21wYXRpYmxlID0gInN0LHN0aWg0MTAiOw0KPiAtDQo+IC1Cb2FyZHMgd2l0aCB0aGUgU1Qg
U1RpSDQxOCBTb0Mgc2hhbGwgaGF2ZSB0aGUgZm9sbG93aW5nIHByb3BlcnRpZXM6DQo+IC1SZXF1
aXJlZCByb290IG5vZGUgcHJvcGVydHk6DQo+IC1jb21wYXRpYmxlID0gInN0LHN0aWg0MTgiOw0K
PiAtDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L3N0aS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9zdGkueWFt
bA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjQ3ZjliOGVl
YmFhMA0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vc3RpLnlhbWwNCj4gQEAgLTAsMCArMSwyMyBAQA0KPiArIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArJVlBTUwgMS4yDQo+ICstLS0NCj4gKyRpZDogaHR0
cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvYXJtL3N0aS55YW1sIw0KPiArJHNjaGVtYTogaHR0
cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ICsNCj4gK3RpdGxl
OiBTVCBTVGkgUGxhdGZvcm1zIERldmljZSBUcmVlIEJpbmRpbmdzDQo+ICsNCj4gK21haW50YWlu
ZXJzOg0KPiArICAtIFBhdHJpY2UgQ2hvdGFyZCA8cGF0cmljZS5jaG90YXJkQHN0LmNvbT4NCj4g
Kw0KPiArcHJvcGVydGllczoNCj4gKyAgJG5vZGVuYW1lOg0KPiArICAgIGNvbnN0OiAnLycNCj4g
KyAgY29tcGF0aWJsZToNCj4gKyAgICBpdGVtczoNCj4gKyAgICAgIC0gZW51bToNCj4gKyAgICAg
ICAgICAtIHN0LHN0aWg0MTUNCj4gKyAgICAgICAgICAtIHN0LHN0aWg0MTYNCj4gKyAgICAgICAg
ICAtIHN0LHN0aWg0MDcNCj4gKyAgICAgICAgICAtIHN0LHN0aWg0MTANCj4gKyAgICAgICAgICAt
IHN0LHN0aWg0MTgNCj4gKy4uLg0KPiANCg0KQWNrZWQtYnk6IFBhdHJpY2UgQ2hvdGFyZCA8cGF0
cmljZS5jaG90YXJkQHN0LmNvbT4NCg0KVGhhbmtz
