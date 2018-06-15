Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 96F9BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563F9208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563F9208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965587AbeFOJJw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:09:52 -0400
Received: from smtp-out4.electric.net ([192.162.216.184]:58202 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936076AbeFOJJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:09:51 -0400
Received: from 1fTkjl-0000mZ-UY by out4c.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fTkjs-0001Ko-Tg; Fri, 15 Jun 2018 02:09:48 -0700
Received: by emcmailer; Fri, 15 Jun 2018 02:09:48 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out4c.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fTkjl-0000mZ-UY; Fri, 15 Jun 2018 02:09:41 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 15 Jun 2018 10:10:52 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 15 Jun 2018 10:10:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Paul Clarke' <pc@us.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>
CC:     "brueckner@linux.vnet.ibm.com" <brueckner@linux.vnet.ibm.com>,
        "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>
Subject: RE: [PATCH 1/3] perf alias: Remove trailing newline when reading
 sysfs files
Thread-Topic: [PATCH 1/3] perf alias: Remove trailing newline when reading
 sysfs files
Thread-Index: AQHUA+JFjXwTYc9vP0GifxywlJiJQaRhB3vg
Date:   Fri, 15 Jun 2018 09:10:52 +0000
Message-ID: <30f3ac625d734674aa6697440aa3253f@AcuMS.aculab.com>
References: <20180614114845.41221-1-tmricht@linux.ibm.com>
 <c29a4b36-a2db-b1d9-a5c7-a0c0806970ab@us.ibm.com>
In-Reply-To: <c29a4b36-a2db-b1d9-a5c7-a0c0806970ab@us.ibm.com>
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

RnJvbTogUGF1bCBDbGFya2UNCj4gU2VudDogMTQgSnVuZSAyMDE4IDE0OjE4DQouLi4NCj4gPiAr
CS8qIFJlbW92ZSB0cmFpbGluZyBuZXdsaW5lIGZyb20gc3lzZnMgZmlsZSAqLw0KPiA+ICsJY3Ag
PSBzdHJyY2hyKGJ1ZiwgJ1xuJyk7DQo+ID4gKwlpZiAoY3ApDQo+ID4gKwkJKmNwID0gJ1wwJzsN
Cj4gDQo+IEEgbml0LCBwZXJoYXBzLCBidXQgdGhpcyB3aWxsIHNlYXJjaCBiYWNrd2FyZHMgdGhy
b3VnaCB0aGUgZW50aXJlIHN0cmluZyBpZiBhIG5ld2xpbmUgaXMgbm90IGZvdW5kLA0KPiB3aGlj
aCBpcyB0aGUgbW9zdCBjb21tb24gY2FzZSwgSSBwcmVzdW1lLiAgV291bGQgaXQgYmUgbW9yZSBl
ZmZpY2llbnQgdG8ganVzdCBsb29rIGF0IHRoZSBsYXN0DQo+IGNoYXJhY3Rlcj8gIFNvbWV0aGlu
ZyBsaWtlOg0KPiBpID0gc3RybGVuKGJ1Zik7DQo+IGlmIChpID4gMCAmJiBidWZbaS0xXSA9PSAn
XG4nKQ0KPiAgIGJ1ZltpLTFdID0gJ1wwJzsNCg0KV29yc2UgaXQgd2lsbCBkbyBob3JyaWQgdGhp
bmdzIG9mIHRoZSBvdXRwdXQgaGFzIG11bHRpcGxlIGxpbmVzIG9mIHRleHQNCndpdGhvdXQgYSBu
ZXdsaW5lIGF0IHRoZSBlbmQuDQoNCkJvdGggc3RybGVuKCkgYW5kIHN0cnJocigpIG5lZWQgdG8g
c2NhbiB0aGUgZW50aXJlIHN0cmluZy4NCkhvd2V2ZXIgc2luY2Ugc3RybGVuIGlzIG9ubHkgbG9v
a2luZyBmb3Igb25lIHZhbHVlIGl0IHNob3VsZCBiZSBtdWNoDQptb3JlIGVmZmljaWVudCAtIGVz
cGVjaWFsbHkgb24gNjRiaXQgc3lzdGVtcyB3aGVyZSBzaGlmdHMgYW5kIGJpdA0Kb3BlcmF0aW9u
cyBjYW4gYmUgdXNlZCB0byBmaW5kIHRoZSA2NGJpdCB3b3JkIGNvbnRhaW5pbmcgdGhlIGZpcnN0
DQp6ZXJvIGJ5dGUuDQoNCkkgc3VzcGVjdCBydHJpbSgpIGhhcyBhbiBleHRyYSBkYXRhIGNhY2hl
IG1pc3MuDQoNCglEYXZpZA0KDQo=
