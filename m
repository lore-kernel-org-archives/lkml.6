Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38610C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12F923ECB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12F923ECB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbeGCMXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:23:47 -0400
Received: from smtp-out6.electric.net ([192.162.217.186]:54493 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbeGCMXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:23:45 -0400
Received: from 1faKLL-0006eF-T2 by out6c.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1faKLN-0006pz-UF; Tue, 03 Jul 2018 05:23:41 -0700
Received: by emcmailer; Tue, 03 Jul 2018 05:23:41 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6c.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1faKLL-0006eF-T2; Tue, 03 Jul 2018 05:23:39 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 3 Jul 2018 13:25:18 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 3 Jul 2018 13:25:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Denys Vlasenko' <dvlasenk@redhat.com>,
        "jbeulich@suse.com" <jbeulich@suse.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
Subject: RE: [tip:x86/asm] x86/entry/64: Add two more instruction suffixes
Thread-Topic: [tip:x86/asm] x86/entry/64: Add two more instruction suffixes
Thread-Index: AQHUEqkqUgcuA0q28EukrINgYR6YAqR9LYhQgAAm8ICAABaccA==
Date:   Tue, 3 Jul 2018 12:25:18 +0000
Message-ID: <4420eda360c240488f7ce38fd8baa778@AcuMS.aculab.com>
References: <5B3A02DD02000078001CFB78@prv1-mh.provo.novell.com>
 <tip-6709812f094d96543b443645c68daaa32d3d3e77@git.kernel.org>
 <dd366701851f48e4897ebe0f62f0fd94@AcuMS.aculab.com>
 <68107758-8018-d8d5-dcfd-270bb64113eb@redhat.com>
In-Reply-To: <68107758-8018-d8d5-dcfd-270bb64113eb@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGVueXMgVmxhc2Vua28NCj4gU2VudDogMDMgSnVseSAyMDE4IDEyOjU5DQo+IA0KPiBP
biAwNy8wMy8yMDE4IDEwOjQ2IEFNLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gRnJvbTogSmFu
IEJldWxpY2gNCj4gPj4gU2VudDogMDMgSnVseSAyMDE4IDA5OjM2DQo+ID4gLi4uDQo+ID4+IEFz
IHNhaWQgdGhlcmUsIG9taXR0aW5nIHN1ZmZpeGVzIGZyb20gaW5zdHJ1Y3Rpb25zIGluIEFUJlQg
bW9kZSBpcyBiYWQNCj4gPj4gcHJhY3RpY2Ugd2hlbiBvcGVyYW5kIHNpemUgY2Fubm90IGJlIGRl
dGVybWluZWQgYnkgdGhlIGFzc2VtYmxlciBmcm9tDQo+ID4+IHJlZ2lzdGVyIG9wZXJhbmRzLCBh
bmQgaXMgbGlrZWx5IGdvaW5nIHRvIGJlIHdhcm5lZCBhYm91dCBieSB1cHN0cmVhbQ0KPiA+PiBn
YXMgaW4gdGhlIGZ1dHVyZSAobWluZSBkb2VzIGFscmVhZHkpLg0KPiA+IC4uLg0KPiA+PiAtCWJ0
CSQ5LCBFRkxBR1MoJXJzcCkJCS8qIGludGVycnVwdHMgb2ZmPyAqLw0KPiA+PiArCWJ0bAkkOSwg
RUZMQUdTKCVyc3ApCQkvKiBpbnRlcnJ1cHRzIG9mZj8gKi8NCj4gPg0KPiA+IEhtbW0uLi4uDQo+
ID4gRG9lcyB0aGUgb3BlcmFuZCBzaXplIG1ha2UgYW55IGRpZmZlcmVuY2UgYXQgYWxsIGZvciB0
aGUgYml0IGluc3RydWN0aW9ucz8NCj4gPiBJJ20gcHJldHR5IHN1cmUgdGhhdCB0aGUgY3B1cyAo
Mzg2IG9ud2FyZHMpIGhhdmUgYWx3YXlzIGRvbmUgYWxpZ25lZCAzMmJpdA0KPiA+IHRyYW5zZmVy
cyAodGhlIGRvY3MgbmV2ZXIgYWN0dWFsbHkgc2FpZCBhbGlnbmVkKS4NCj4gPiBJIGNhbid0IHJl
bWVtYmVyIHdoZXRoZXIgNjRiaXQgbW9kZSBhbGxvd3MgaW1tZWRpYXRlcyBhYm92ZSAzMS4NCj4g
DQo+IEltbWVkaWF0ZXMgdXAgdG8gNjMgYXJlIGFsbG93ZWQgaW4gNjQgYml0IG1vZGUgKElPVzog
Zm9yIFJFWC1wcmVmaXhlZCBmb3JtKQ0KPiAocnVuLXRlc3RlZCkuDQo+IA0KPiBLZWVwIGluIG1p
bmQgdGhhdCB0aGlzIGluc3RydWN0aW9uIGlzICJzcGVjaWFsIiB3aXRoIHJlZ2lzdGVyIGJpdCBv
ZmZzZXQ6DQo+IA0KPiBSZWdpc3Rlci9tZW1vcnkgZm9ybSAoQlQgUkVHLFtNRU1dKSBkb2VzIG5v
dCBsaW1pdCBvciBtYXNrIHRoZSB2YWx1ZSBvZiBiaXQgb2Zmc2V0DQo+IGluIFJFRywgdGhlIGlu
c3RydWN0aW9uIHVzZXMgYml0IFJFRyU4IGluIGJ5dGUgYXQgYWRkcmVzcyBbTUVNK1JFRy84XS4N
Cj4gDQo+IFRoaXMgd29ya3MgY29ycmVjdGx5IGV2ZW4gZm9yIG5lZ2F0aXZlIHZhbHVlczogUkVH
ID0gLTEgd2lsbCBhY2Nlc3MNCj4gdGhlIG1vc3Qgc2lnbmlmaWNhbnQgYml0IGluIHRoZSBieXRl
IGltbWVkaWF0ZWx5IGJlZm9yZSBNRU0uDQo+IA0KPiBUaHVzLCBmb3IgYWNjZXNzZXMgb2Ygc3Rh
bmRhcmQgUkFNIGxvY2F0aW9ucyAobm90IG1lbW9yeS1tYXBwZWQgSU8gYW5kIHN1Y2gpLA0KPiB0
aGUgIm9wZXJhbmQgc2l6ZSIgY29uY2VwdCBmb3IgdGhpcyBpbnN0cnVjdGlvbiAoYW5kIEJUQywg
QlRSLCBCVFMpDQo+IGRvZXMgbm90IG1ha2UgbXVjaCBzZW5zZTogaXQgYWNjZXNzZXMgb25lIGJp
dC4gVGhlIHdpZHRoIG9mIGFjdHVhbCBtZW1vcnkNCj4gYWNjZXNzIGlzIGlycmVsZXZhbnQuDQo+
IA0KPiBJJ2Qgc2F5IGFzc2VtYmxlciBzaG91bGQganVzdCB1c2UgdGhlICJuYXR1cmFsIiB3aWR0
aCBmb3IgY3VycmVudCBtb2RlDQo+ICgxNiBvciAzMi1iaXQpLCBhbmQgd2FybiB3aGVuIGNvZGUg
dHJpZXMgdG8gdXNlIGltbWVkaWF0ZSBvcGVyYW5kIHdoaWNoDQo+IHdpbGwgYmUgdHJ1bmNhdGVk
IGFuZCB0aHVzIG5lZWRzIGEgd2lkZXIgb3BlcmFuZCBzaXplLg0KLi4uDQoNCg0KSW5kZWVkLg0K
DQpUcnVuY2F0aW5nIHRoZSBpbW1lZGlhdGUgdmFsdWUgcmVhbGx5IG91Z2h0IHRvIGJlIGFuIGVy
cm9yLg0KSW4gNjRiaXQgbW9kZSB0aGUgNjRiaXQgZm9ybSBzaG91bGQgYmUgdXNlZCBmb3IgaW1t
ZWRpYXRlcyBbMzIuLjYzKS4NClRoZSAxNmJpdCBmb3JtIGNvdWxkIHNhZmVseSBiZSBzZWxlY3Rl
ZCBmb3IgaW1tZWRpYXRlcyBbMC4uMTUpLg0KDQpSZXF1aXJpbmcgdGhlIHdpZHRoIHN1ZmZpeCBp
cyBqdXN0IHN0dXBpZC4NCg0KCURhdmlkDQoNCg0K
