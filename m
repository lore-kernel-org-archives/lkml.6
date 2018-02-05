Return-Path: <David.Laight@aculab.com>
X-Google-Smtp-Source: AH8x224BwosThZuiLfZgJai8eyHGYO0jtPFjYPqI7/5+Sps+0TlDhdxvqXCY/fRFOKk8iFQlNq62
ARC-Seal: i=1; a=rsa-sha256; t=1517825333; cv=none;
        d=google.com; s=arc-20160816;
        b=C02XQ4vQHnXLdRGerJDEE81rJ/fa+Ll4Ll5z8z1F6QpnHKwe+H08Qm81xUS3M2Vh5k
         Vh0SNdJbq+O+AXOJdef5VPIq9CaLo4NWSCeoHA6RPaF4OyV6ks0GfVRKUxD8t58kOXNJ
         xZgGXQjLRybmAEsvgLPQqoTqxS7unleVy0UvsAt4ERth9aHzVnajAE1YbRaULAJ3us5B
         ubWemsYCwXKWJtq9yTWPmz05tc0PQb92i9QveAw1O+6UxyZMSI0qC4cG4iPOHujEFkTa
         DPPERc+PiS4owPc9MWqTNpwEwPfhW/uYnOZvi6JZgn1/lLc5XhDCxT/eJB63a5HKbzsl
         CcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=DBTaedwgylHScQO740w5UtHIlJy6PZWsMkABJ6I1cXk=;
        b=F01oFv1JKrK/yK6oGtkqhlAhR6ltQGZzYxomrdMhhKL/MfkyD4SXQfWWlocIG97UYS
         MuHIaweDWFNi8uH/IupdTkU/ph+buOylGEPhOTg4e8YcjQPA7kFMyPaDYkH8crXRKwn7
         UR3woPV5UO5dUfPzwPoG5q1Pdnd+x8gFXSaanqKlnaMhu8y+9uBovP+mqzG6Zqr40MJz
         duWaAkIkzjyv4yj9buHk9OOHEFkwb+iotg0mmZKdiRJAUuv2+eIQMFCyj3nqEX9G5DcJ
         J3MsfOq/cVlRUrApzhzPdGSmUYBuQJHBvGkH63Mfh66l7hM9xgWaC3AP7tdApBRhX8mk
         TqKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david.laight@aculab.com designates 192.162.216.185 as permitted sender) smtp.mailfrom=David.Laight@aculab.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david.laight@aculab.com designates 192.162.216.185 as permitted sender) smtp.mailfrom=David.Laight@aculab.com
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Linus Walleij
	<linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>
Subject: RE: [GIT PULL] pin control bulk changes for v4.16
Thread-Topic: [GIT PULL] pin control bulk changes for v4.16
Thread-Index: AQHTnHlGX5BFwqQW5U6SKO/d1u5b1aOVmHsQ
Date: Mon, 5 Feb 2018 10:09:36 +0000
Message-ID: <b82adbc32e4444debb947582d3a8291c@AcuMS.aculab.com>
References: <CACRpkdaTv4NBrRXeJE6dVi4W88+LZdsTCSzTHi0vdcKMW3Qfmw@mail.gmail.com>
 <CA+55aFzMBptQt-QHMR0MM9MA3=1rxcf8ca5qHxrf4Mm0ZobE_A@mail.gmail.com>
In-Reply-To: <CA+55aFzMBptQt-QHMR0MM9MA3=1rxcf8ca5qHxrf4Mm0ZobE_A@mail.gmail.com>
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
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591331743286572652?=
X-GMAIL-MSGID: =?utf-8?q?1591555217296989502?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDIgRmVicnVhcnkgMjAxOCAyMjo1Nw0KLi4u
DQo+IEkgYWxzbyB3b25kZXIgaWYgdGhlcmUgYXJlIGFueSBhdXRvbWF0ZWQgdG9vbHMgdGhhdCB0
cnkgdG8gZmluZCB0aGVzZQ0KPiBraW5kcyBvZiBjcmF6eSB0aGluZ3MuIEkgc3VzcGVjdCBhIGxv
dCBvZiBvdXIgYnVpbGQgdGltZXMgaXMgdGhlIHBvb3INCj4gY29tcGlsZXIganVzdCByZWFkaW5n
IGFuZCBwYXJzaW5nIGhlYWRlciBmaWxlcyBvdmVyIGFuZCBvdmVyIGFnYWluLA0KPiBhbmQgYSBs
b3Qgb2YgdGhlbSBhcmUgcHJvYmFibHkgbm90IG5lZWRlZC4NCg0KSSd2ZSBjb3VudGVkIHN5c3Rl
bSBjYWxscyBkdXJpbmcgYSBOZXRCU0Qga2VybmVsIGJ1aWxkLCBJIGltYWdpbmUgTGludXggaXMN
Cm11Y2ggdGhlIHNhbWUuDQpNb3N0IG9mIHRoZSBjYWxscyB3ZXJlIG9wZW4oKSwgYW5kIG1vc3Qg
b2YgdGhvc2UgZmFpbGluZyBvcGVucy4NCkkgc3VzcGVjdGVkIHRoYXQgbW9zdCBjYW1lIGZyb20g
c2VhcmNoaW5nIHRoZSAtSSBwYXRoIHRvIGZpbmQgaGVhZGVycy4NCkJ1aWxkIG92ZXIgTkZTIGFu
ZCB0aGUgY29zdCBpcyBldmVuIG1vcmUgc2lnbmlmaWNhbnQgKGV2ZXJ5IGRpcmVjdG9yeQ0KbmFt
ZSBpbiB0aGUgcGF0aCAodXNlZCB0bykgcmVxdWlyZSBhbiBORlMgbWVzc2FnZSBleGNoYW5nZSku
DQoNCglEYXZpZA0KDQo=
