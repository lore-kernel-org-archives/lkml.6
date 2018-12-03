Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C39C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57162087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L1gQ1mQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57162087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeLCKYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:24:50 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:38190 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeLCKYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:24:49 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 46AAA10C06EF;
        Mon,  3 Dec 2018 02:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543832664; bh=x3oEStGKbRsh0NB5OC4CeGnY86hACG4ZXYQ4aWimpjs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=L1gQ1mQfJ7gRM+UKigLZk2pSKe1fR1CyV3Q5QzpioSLrnWpqlADs5SUokpAL/+pXK
         7GTpYd4pDKziWgSnvhxBCiQgi0W/jbJNt3ElyD4UixLsQoqegAsmpDbdW+CEE0/9MO
         y4ixpjdqLVgQUBZ3tmaN2nT7/QLUZFiVHaDMiA3plk6YlqK2h9QzcFfeRFgGiEq0B2
         9oDZfGDPcuM/qpxGzFT8u7mYnkP1iqKzdQwZ7MnPCPUdjCe9kdykGAXInqkAGoSpGy
         XAjMKrYjdKRyE/Q49y/BmXkI931IWghO7G0ZfGuDGcHBhqXR9/r7yGTWX9P1ldjb4P
         iXbvmAqbU+0QQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id DD6E65170;
        Mon,  3 Dec 2018 02:24:23 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Dec 2018 02:24:23 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 3 Dec 2018 11:24:20 +0100
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     "sashal@kernel.org" <sashal@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: Re: [PATCH v2] ARC: change defconfig defaults to ARCv2
Thread-Topic: [PATCH v2] ARC: change defconfig defaults to ARCv2
Thread-Index: AQHUiKuDyirRSdD5VES1xEM3nRkp26Vq9DwAgAHOWwA=
Date:   Mon, 3 Dec 2018 10:24:20 +0000
Message-ID: <3b9f09a5cd48345cd23ec8cb760c322876ceeba3.camel@synopsys.com>
References: <20181130125156.34460-1-abrodkin@synopsys.com>
         <20181202064929.9B32D20851@mail.kernel.org>
In-Reply-To: <20181202064929.9B32D20851@mail.kernel.org>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.2 (3.30.2-2.fc29) 
x-originating-ip: [10.225.15.88]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E66AD5278FC7744199AF92630B34872C@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2FzaGEsDQoNCk9uIFN1biwgMjAxOC0xMi0wMiBhdCAwNjo0OSArMDAwMCwgU2FzaGEgTGV2
aW4gd3JvdGU6DQo+IEhpLA0KPiANCj4gW1RoaXMgaXMgYW4gYXV0b21hdGVkIGVtYWlsXQ0KPiAN
Cj4gVGhpcyBjb21taXQgaGFzIGJlZW4gcHJvY2Vzc2VkIGJlY2F1c2UgaXQgY29udGFpbnMgYSAt
c3RhYmxlIHRhZy4NCj4gVGhlIHN0YWJsZSB0YWcgaW5kaWNhdGVzIHRoYXQgaXQncyByZWxldmFu
dCBmb3IgdGhlIGZvbGxvd2luZyB0cmVlczogNC40LisNCj4gDQo+IFRoZSBib3QgaGFzIHRlc3Rl
ZCB0aGUgZm9sbG93aW5nIHRyZWVzOiB2NC4xOS41LCB2NC4xNC44NCwgdjQuOS4xNDEsIHY0LjQu
MTY1LCANCj4gDQo+IHY0LjE5LjU6IEJ1aWxkIE9LIQ0KPiB2NC4xNC44NDogQnVpbGQgT0shDQo+
IHY0LjkuMTQxOiBGYWlsZWQgdG8gYXBwbHkhIFBvc3NpYmxlIGRlcGVuZGVuY2llczoNCj4gICAg
IFVuYWJsZSB0byBjYWxjdWxhdGUNCg0KVGhhdCdzIGEgZml4ZWQgaHVuayBmb3IgNC45Og0KLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KLS0tIGEvYXJjaC9h
cmMvTWFrZWZpbGUNCisrKyBiL2FyY2gvYXJjL01ha2VmaWxlDQpAQCAtOCw3ICs4LDcgQEANCiAN
CiBVVFNfTUFDSElORSA6PSBhcmMNCiANCi1LQlVJTERfREVGQ09ORklHIDo9IG5zaW1fNzAwX2Rl
ZmNvbmZpZw0KK0tCVUlMRF9ERUZDT05GSUcgOj0gbnNpbV9oc19kZWZjb25maWcNCiANCiBjZmxh
Z3MteSAgICAgICArPSAtZm5vLWNvbW1vbiAtcGlwZSAtZm5vLWJ1aWx0aW4gLW1tZWRpdW0tY2Fs
bHMgLURfX2xpbnV4X18NCiBjZmxhZ3MtJChDT05GSUdfSVNBX0FSQ09NUEFDVCkgKz0gLW1BNw0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQo+IHY0LjQu
MTY1OiBGYWlsZWQgdG8gYXBwbHkhIFBvc3NpYmxlIGRlcGVuZGVuY2llczoNCj4gICAgIDg0NTAz
M2JlMDA0MSAoIkFSQzogW3BsYXQtZXpucHNdIEFkZCBlem5wcyBib2FyZCBkZWZjb25maWcgYW5k
IGR0cyIpDQoNCkluZGVlZCBFekNoaXAncyBucHM0MDAgcGxhdGZvcm0gd2FzIGFkZGVkIGxhdGVy
IGJ1dCB3ZSBkb24ndCBuZWVkIGl0IGluIDQuNC55DQphcyBJSVJDIHRoZXJlIHdlcmUgcXVpdGUg
c29tZSBvdGhlciBkZXBlbmRlbmNpZXMsIHNvIGp1c3QgZHJvcCBodW5rIHJlbGF0ZWQgdG8gaXQu
DQoNCkFuZCBvbmNlIG5wc19kZWZjb25maWcgaHVuayBpcyBkcm9wcGVkIHRoZXJlJ3MgYSBmaXhk
IGh1bmsgZm9yIGFyY2gvYXJjL01ha2VmaWxlDQpzaW1pbGFybHkgdG8gNC45Og0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KLS0tIGEvYXJjaC9hcmMvTWFr
ZWZpbGUNCisrKyBiL2FyY2gvYXJjL01ha2VmaWxlDQpAQCAtMTIsNyArMTIsNyBAQCBpZmVxICgk
KENST1NTX0NPTVBJTEUpLCkNCiBDUk9TU19DT01QSUxFIDo9IGFyYy1saW51eC0NCiBlbmRpZg0K
IA0KLUtCVUlMRF9ERUZDT05GSUcgOj0gbnNpbV83MDBfZGVmY29uZmlnDQorS0JVSUxEX0RFRkNP
TkZJRyA6PSBuc2ltX2hzX2RlZmNvbmZpZw0KIA0KIGNmbGFncy15ICAgICAgICs9IC1mbm8tY29t
bW9uIC1waXBlIC1mbm8tYnVpbHRpbiAtbW1lZGl1bS1jYWxscyAtRF9fbGludXhfXw0KIGNmbGFn
cy0kKENPTkZJR19JU0FfQVJDT01QQUNUKSArPSAtbUE3DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
PjgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCj4gSG93IHNob3VsZCB3ZSBwcm9jZWVkIHdpdGgg
dGhpcyBwYXRjaD8NCg0KSG9wZSBhYm92ZSBoZWxwcy4gT3RoZXJ3aXNlIEkgbWF5IHNlbmQgY29t
cGxldGUgcGF0Y2hlcyBmb3IgYm90aA0KNC40IGFuZCA0LjkuDQoNCkxldCBtZSBrbm93IHdoYXQg
aXMgeW91ciBwcmVmZXJlbmNlLg0KDQotQWxleGV5DQo=
