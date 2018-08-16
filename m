Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DA9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3680E2148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3680E2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbeHPMrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:47:31 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:41639 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727206AbeHPMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:47:31 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-115-gvWX7dmtOMie0FGI6Q0_6A-1; Thu, 16 Aug 2018 10:50:02 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 16 Aug 2018 10:51:41 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 16 Aug 2018 10:51:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        "Will Deacon" <will.deacon@arm.com>
Subject: RE: [GIT PULL] gcc-plugin updates for v4.19-rc1
Thread-Topic: [GIT PULL] gcc-plugin updates for v4.19-rc1
Thread-Index: AQHUNNV2Fwz5Ik1UXE2pPnWxxxYZ46TCIJpg
Date:   Thu, 16 Aug 2018 09:51:41 +0000
Message-ID: <8d9dd1f35af1463dbeaf03c9d028020b@AcuMS.aculab.com>
References: <20180813214328.GA15137@beast>
 <CA+55aFw5Tkn6DgkAZS-UGOjJpYp2R4rFAm9ixu_=FONeqRyofg@mail.gmail.com>
 <CAGXu5jK_w7JRywdQ78FfQxeLSMmXbvyDDnaYzj27=y8wnAzKxQ@mail.gmail.com>
 <CA+55aFyFCWH3YJnRUKtSzs9Mvny0eU+=QANxoPTE+9B9CkUWDw@mail.gmail.com>
 <CAGXu5jJ1JNSxJABUTAO85z_hXjSkjD=nWEho7KrYJTqqVGivig@mail.gmail.com>
 <CA+55aFy6jNLsywVYdGp83AMrXBo_P-pkjkphPGrO=82SPKCpLQ@mail.gmail.com>
In-Reply-To: <CA+55aFy6jNLsywVYdGp83AMrXBo_P-pkjkphPGrO=82SPKCpLQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: gvWX7dmtOMie0FGI6Q0_6A-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTUgQXVndXN0IDIwMTggMjE6MTkNCi4uLg0K
PiBCdXQgaWYgcGVvcGxlIHJ1biB0aGluZ3Mgb24gcmVhbCBtYWNoaW5lcywgdGhlbiBCVUcoKSBp
cyBhYnNvbHV0ZWx5DQo+IHRoZSBsYXN0IHRoaW5nIHlvdSBFVkVSIHdhbnQgdG8gZG8gZm9yICJk
ZWJ1Z2dpbmciLg0KDQpJJ20gbm90IHN1cmUgeW91IHdhbnQgaXQgb24gYSBsaXZlIHN5c3RlbSBl
aXRoZXIuDQpMaXZlIHN5c3RlbXMgYXJlIHdoZXJlIHRoZSAnaGFyZCcgYnVncyBzaG93IHVwLg0K
DQpJJ3ZlIGp1c3Qgc3BlbnQgYSBjb3VwbGUgb2YgZGF5cyBwdWxsaW5nIG15IGhhaXIgb3V0IHRy
eWluZyB0byB3b3JrDQpvdXQgaG93IHRvIGRlYnVnIGEgY3VzdG9tZXIgc3lzdGVtIHRoYXQgd2Fz
IGxvY2tpbmcgdXAgc29saWQgd2hlbg0KcnVubmluZyBzb21lIG5ldyAoYW5kIG5vdCBjb21wbGV0
ZWx5IHRlc3RhYmxlIGJ5IHVzKSBrZXJuZWwgY29kZS4NCg0KQXQgNGFtIEkgc3VkZGVubHkgcmVh
bGlzZWQgdGhhdCB0aGUgZGlzdHJpYnV0aW9uIHRoZXkgYXJlIHVzaW5nDQptaWdodCBiZSBlbmFi
bGluZyAncGFuaWNfb25fb29wcycgYnkgZGVmYXVsdC4NClR1cm5pbmcgdGhhdCBvZmYgc2hvd2Vk
IHdoYXQgd2FzIGdvaW5nIHdyb25nLg0KDQpJdCB3b3VsZG4ndCBiZSBhcyBiYWQgaWYgTGludXgg
aW1wbGVtZW50ZWQgJ2R1bXAgdG8gc3dhcCcuDQoNCkZvciAnZXJyb3JzJyB0aGF0IGFyZW4ndCBj
b21wbGV0ZWx5IGZhdGFsIHRoZSBzeXN0ZW0gY291bGQNCidmYXN0IHNodXRkb3duJyBhIGxvdCBv
ZiBwcm9jZXNzZXMgKG1heWJlIGp1c3QgcmVmdXNlIHRvIHNjaGVkdWxlDQp0aGVtKSB3aGlsZSBs
ZWF2aW5nIGVub3VnaCBydW5uaW5nIGZvciBmYXVsdCBkaWFnbm9zaXMuDQpJJ20gbm90IHN1cmUg
aG93IHlvdSdkIGRlY2lkZSB3aGF0IHRvIGFsbG93IHRvIHJ1biB0aG91Z2guDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

