Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3226D60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeFFPdu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:33:50 -0400
Received: from smtp-out6.electric.net ([192.162.217.185]:60969 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbeFFPds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:33:48 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: 'Josh Poimboeuf' <jpoimboe@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC: kbuild test robot <lkp@intel.com>,
        Michal Januszewski <spock@gentoo.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: RE: include/linux/string.h:246:9: warning: '__builtin_strncpy' output
 truncated before terminating nul copying 4 bytes from a string of the same
 length
Thread-Topic: include/linux/string.h:246:9: warning: '__builtin_strncpy'
 output truncated before terminating nul copying 4 bytes from a string of the
 same length
Thread-Index: AQHT/OJEF7Yw/OKTXkC1hP/mTbT+bKRTWtiQ
Date: Wed, 6 Jun 2018 15:34:43 +0000
Message-ID: <968a69b2aeb34ffb9d2fb01731ac9247@AcuMS.aculab.com>
References: <201805290939.AjijeyJf%fengguang.wu@intel.com>
 <CAHp75Ve-OjbeVjWUGkXbyh-PXn8L12Sb56EBq-n5z5sicUh7Sg@mail.gmail.com>
 <20180605153003.epf37ivdbewv256i@treble>
In-Reply-To: <20180605153003.epf37ivdbewv256i@treble>
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
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMDUgSnVuZSAyMDE4IDE2OjMwDQouLi4NCj4g
V2hhdCBhYm91dCBqdXN0IGNoYW5naW5nIGl0IHRvIGEgbWVtY3B5PyAgU2VlbXMgbGlrZSB0aGF0
IHdvdWxkIGJlDQo+IGNsZWFuZXIgYW55d2F5LCBzaW5jZSB0aGUgd2hvbGUgcG9pbnQgb2Ygc3Ry
bmNweSBpcyB0byBhZGQgdGhlDQo+IHRlcm1pbmF0aW5nIE5VTEwsIHdoaWNoIGlzbid0IG5lZWQg
aGVyZS4NCg0KTm90IHJlYWxseSwgdGhlIHBvaW50IG9mIHN0cm5jcHkgaXMgdG8gY29weSBzdHJp
bmdzIHRoYXQgbWlnaHQNCm5vdCBiZSAnXDAnIHRlcm1pbmF0ZWQgYW5kIHRvIHplcm8gZmlsbCB0
aGUgdGFyZ2V0IGJ1ZmZlci4NCg0KVW5mb3J0dW5hdGVseSBzdHJuY3B5KCkgaGFzIG9mdGVuIGJl
ZW4gdXNlZCB3aXRoIHRoZSBhc3N1bXB0aW9uDQp0aGF0IGl0IGFsd2F5cyB0ZXJtaW5hdGVzIHRo
ZSB0YXJnZXQgc3RyaW5nIC0gd2hpY2ggaXNuJ3QgdHJ1ZS4NCg0KVW5mb3J0dW5hdGVseSB5b3Ug
Y2FuJ3QgYWx3YXlzIHJlcGxhY2Ugc3RybmNweSB3aXRoIHN0cmxjcHkgb3INCnNucHJpbnRmIGJl
Y2F1c2UgYm90aCB0aG9zZSByZXF1aXJlIHRoZSBzb3VyY2Ugc3RyaW5nIGJlICdcMCcNCnRlcm1p
bmF0ZWQgLSB3aGljaCBpc24ndCBhIHJlcXVpcmVtZW50IGZvciBzdHJuY3B5Lg0KDQpUaGlzIHdh
cm5pbmcgb24gX19idWlsdGluX3N0cm5jcHkoKSBzZWVtcyBvdHQgdG8gbWUuDQpUaGUgb25seSBm
aXggaXMgdG8gYXVkaXQgdGhlIGNvZGUgYW5kIHJlcGxhY2UgYXQgbGVhc3Qgc29tZSBvZg0KdGhl
IHN0cm5jcHkoKSB3aXRoIHJlYWxseV9zdHJuY3B5KCkuDQoNCglEYXZpZA0KDQo=
