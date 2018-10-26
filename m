Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD621ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6FD20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6FD20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJZSZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:25:01 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:32966 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726367AbeJZSZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:25:01 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9Q9hp5B028983;
        Fri, 26 Oct 2018 11:48:13 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2nbyf78j76-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 26 Oct 2018 11:48:13 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 44C0834;
        Fri, 26 Oct 2018 09:48:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0658E28EC;
        Fri, 26 Oct 2018 09:48:12 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 26 Oct
 2018 11:48:11 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 26 Oct 2018 11:48:11 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v4 1/8] dt-bindings: mfd: document stpmic1
Thread-Topic: [PATCH v4 1/8] dt-bindings: mfd: document stpmic1
Thread-Index: AQHUZsFBRuMut//ZdkWyRzcqszCImA==
Date:   Fri, 26 Oct 2018 09:48:11 +0000
Message-ID: <5BD2E2DB.5090305@st.com>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-2-git-send-email-p.paillet@st.com>
 <20181025094430.GQ4939@dell>
 <CAL_JsqKsp8kTK2v_cBrNm+enzieQSEh2G7KMxsBdidr+XhDwTg@mail.gmail.com>
 <20181026064614.GG4870@dell>
In-Reply-To: <20181026064614.GG4870@dell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D192C7C0414264C938069FC3CDEFFA2@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-26_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTGVlLA0KDQpMZSAxMC8yNi8yMDE4IDA4OjQ2IEFNLCBMZWUgSm9uZXMgYSDDqWNyaXQg
Og0KPiBPbiBUaHUsIDI1IE9jdCAyMDE4LCBSb2IgSGVycmluZyB3cm90ZToNCj4NCj4+IE9uIFRo
dSwgT2N0IDI1LCAyMDE4IGF0IDQ6NDQgQU0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9y
Zz4gd3JvdGU6DQo+Pj4gUm9iOiBwbGVhc2UgZ3JlcCB5b3VyIG5hbWUgZm9yIHNvbWUgZmVlZGJh
Y2suDQo+IFtNb3ZlZCB0byB0aGUgdG9wXQ0KPg0KPj4+IEknbSBzdXJwcmlzZWQgUm9iIGFsbG93
ZWQgeW91IHRvIGFkZCByZWdpc3RlciBiaXRzIGluIGEgRFQgcHJvcGVydHk/DQo+PiBZZWFoLCB0
aGV5IGFyZSBjZXJ0YWlubHkgcXVlc3Rpb25hYmxlIGFuZCBub3Qgc29tZXRoaW5nIHdlIGVuY291
cmFnZSwNCj4+IGJ1dCB0aGUgYWx0ZXJuYXRpdmUgd291bGQgYmUgZG96ZW5zIG9mIHByb3BlcnRp
ZXMgd2hpY2ggb25seSBhcHBseSBmb3INCj4+IHRoaXMgb25lIGRldmljZSBhbmQganVzdCBnZXQg
dHJhbnNsYXRlZCBiYWNrIHRvIHJlZ2lzdGVyIHZhbHVlcy4NCj4gSSBkb24ndCBzZWUgaG93IHRo
aXMgZGV2aWNlIGlzIGFueSBkaWZmZXJlbnQgdG8gdGhlIDEwMCdzIG9mIGRldmljZXMNCj4gd2hp
Y2ggYXJlIGFscmVhZHkgc3VwcG9ydGVkIGluIERULg0KPg0KPj4+IE9uIFRodSwgMTggT2N0IDIw
MTgsIFBhc2NhbCBQQUlMTEVULUxNRSB3cm90ZToNCj4+Pg0KPj4+PiBGcm9tOiBwYXNjYWwgcGFp
bGxldCA8cC5wYWlsbGV0QHN0LmNvbT4NCj4+Pj4gK09wdGlvbmFsIHBhcmVudCBkZXZpY2UgcHJv
cGVydGllczoNCj4+Pj4gKy0gc3QsbWFpbi1jb250cm9sLXJlZ2lzdGVyOg0KPj4+PiArICAgICAt
Yml0IDE6IFBvd2VyIGN5Y2xpbmcgd2lsbCBiZSBwZXJmb3JtZWQgb24gdHVybiBPRkYgY29uZGl0
aW9uDQo+Pj4+ICsgICAgIC1iaXQgMjogUFdSQ1RSTCBpcyBmdW5jdGlvbmFsDQo+Pj4+ICsgICAg
IC1iaXQgMzogUFdSQ1RSTCBhY3RpdmUgaGlnaA0KPj4+PiArLSBzdCxwYWRzLXB1bGwtcmVnaXN0
ZXI6DQo+Pj4+ICsgICAgIC1iaXQgMTogV0FLRVVQIHB1bGwgZG93biBpcyBub3QgYWN0aXZlDQo+
Pj4+ICsgICAgIC1iaXQgMjogUFdSQ1RSTCBwdWxsIHVwIGlzIGFjdGl2ZQ0KPj4+PiArICAgICAt
Yml0IDM6IFBXUkNUUkwgcHVsbCBkb3duIGlzIGFjdGl2ZQ0KPj4+PiArICAgICAtYml0IDQ6IFdB
S0VVUCBkZXRlY3RvciBpcyBkaXNhYmxlZA0KPiBUaGlzIHNob3VsZCBiZSBwYXJ0IG9mIHRoZSBQ
aW5jdHJsIGNvbmZpZ3VyYXRpb24vZHJpdmVyLg0KPg0KPiBBbmQgUGluY3RybCBwcm9iYWJseSBh
bHJlYWR5IGhhcyBwcm9wZXJ0aWVzIGZvciB0aGlzPw0KSSB3aWxsIHJlbW92ZSB0aGlzIGluIHRo
ZSBuZXh0IHZlcnNpb24uDQo+Pj4+ICstIHN0LHZpbi1jb250cm9sLXJlZ2lzdGVyOg0KPj4+PiAr
ICAgICAtYml0IDA6IFZJTkxPVyBtb25pdG9yaW5nIGlzIGVuYWJsZWQNCj4+Pj4gKyAgICAgLWJp
dCBbMS4uLjNdOiBWSU5MT1cgcmlzaW5nIHRocmVzaG9sZA0KPj4+PiArICAgICAgICAgICAgIDAw
MCBWSU5PS19mICsgNTBtVg0KPj4+PiArICAgICAgICAgICAgIDAwMSBWSU5PS19mICsgMTAwbVYN
Cj4+Pj4gKyAgICAgICAgICAgICAwMTAgVklOT0tfZiArIDE1MG1WDQo+Pj4+ICsgICAgICAgICAg
ICAgMDExIFZJTk9LX2YgKyAyMDBtVg0KPj4+PiArICAgICAgICAgICAgIDEwMCBWSU5PS19mICsg
MjUwbVYNCj4+Pj4gKyAgICAgICAgICAgICAxMDEgVklOT0tfZiArIDMwMG1WDQo+Pj4+ICsgICAg
ICAgICAgICAgMTEwIFZJTk9LX2YgKyAzNTBtVg0KPj4+PiArICAgICAgICAgICAgIDExMSBWSU5P
S19mICsgNDAwbVYNCj4+Pj4gKyAgICAgLWJpdCBbNC4uLjVdOiBWSU5MT1cgaHlzdA0KPj4+PiAr
ICAgICAgICAgICAgIDAwIDEwMG1WDQo+Pj4+ICsgICAgICAgICAgICAgMDEgMjAwbVYNCj4+Pj4g
KyAgICAgICAgICAgICAxMCAzMDBtVg0KPj4+PiArICAgICAgICAgICAgIDExIDQwMG1WDQo+Pj4+
ICsgICAgIC1iaXQgNjogU1dfT1VUIGRldGVjdG9yIGlzIGRpc2FibGVkDQo+Pj4+ICsgICAgIC1i
aXQgNzogU1dfSU4gZGV0ZWN0b3IgaXMgZW5hYmxlZC4NCj4gVGhpcyBzaG91bGQgYmUgcGFydCBv
ZiB0aGUgUmVndWxhdG9yIGNvbmZpZ3VyYXRpb24vZHJpdmVyPw0KSSB3aWxsIGFsc28gcmVtb3Zl
IHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbi4gSSB0aGluayB0aGlzIGNvdWxkIGJlIA0KaGFuZGxl
ZCBieSBhbiBoYXJkd2FyZSBtb25pdG9yIGZ1dHVyZSBkcml2ZXIuDQo+Pj4+ICstIHN0LHVzYi1j
b250cm9sLXJlZ2lzdGVyOg0KPj4+PiArICAgICAtYml0IDM6IFNXX09VVCBjdXJyZW50IGxpbWl0
DQo+Pj4+ICsgICAgICAgICAgICAgMDogNjAwbUENCj4+Pj4gKyAgICAgICAgICAgICAxOiAxLjFB
DQo+Pj4+ICsgICAgIC1iaXQgNDogVkJVU19PVEcgZGlzY2hhcmdlIGlzIGVuYWJsZWQNCj4+Pj4g
KyAgICAgLWJpdCA1OiBTV19PVVQgZGlzY2hhcmdlIGlzIGVuYWJsZWQNCj4+Pj4gKyAgICAgLWJp
dCA2OiBWQlVTX09URyBkZXRlY3Rpb24gaXMgZW5hYmxlZA0KPj4+PiArICAgICAtYml0IDc6IEJP
T1NUX09WUCBpcyBkaXNhYmxlZA0KPiBUaGlzIHNob3VsZCBiZSBwYXJ0IG9mIHRoZSBVU0IgY29u
ZmlndXJhdGlvbi9kcml2ZXI/DQo+DQpJIHdpbGwgYWxzbyByZW1vdmUgdGhpcyBpbiB0aGUgbmV4
dCB2ZXJzaW9uLiBBbmQgSSdtIGdvaW5nIHRvIGFkZCBhY3RpdmUgDQpkaXNjaGFyZ2Ugb3BzIGlu
IHRoZSByZWd1bGF0b3IgZHJpdmVyLg0KDQpUaGFuayB5b3UgIQ0KcGFzY2FsDQo=
