Return-Path: <arjan.van.de.ven@intel.com>
X-Google-Smtp-Source: AH8x225fcnvcm1rsAvf2Gea//0w/QUnHJLNnfRpr6RS/dkjwuvwf8LetInAAyIRzWvZRd6KjiHYB
ARC-Seal: i=1; a=rsa-sha256; t=1518443776; cv=none;
        d=google.com; s=arc-20160816;
        b=cph+g/Rkaz8tEiZ2ZiI5vj1kB805vdQKNkfnOVjZB7OEoqWmioCp/WZmcXz329siby
         mRtTomOUs+7bqczYhdkzjTNXUucdsWaBmA4ISJNdu6TrgiNfmrpg9CN8sNV7ATTKZwqD
         DG0LpYMy6j0PdqB3up7pE8bmjrSckVi2/afk/2ToApiHiRP3Pd/+KG/cl9nWDSKZ7xZG
         LW9RgrPahqcSGFj3X3rIQKqheLwzlAUhHARG9xJnvjibLHIJvyatZTeGE3P/hdy5bdPc
         JELqr1iRw8q+nsx8RSmYjV8I2Sfd+oY5/x/dXK/2INO6hX1Hw8E0x764sZQohYizAint
         G9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=lSjfKkkoRUIWy2wTNG0F6dimqRCUoR2RG08DDKFW7Pw=;
        b=nCmRG9cQhnKGcWAA46xbSYxRg2jx8q2d0ByioT8UhxT2P+OPW1GTFqL32Rlnv3Eepb
         OtrK89oxCgosTfIpxVgdfO9VO5Na8cNVGhh0YyBGI0WU2S4UHrSyT3njphPbNM8c0F8j
         Oi4WYThOZDLeM3zGXDhNMs2ByOCbOnrlpGBwWb/iiQkUR2+btA2goFXfIWzxNW4YXXl4
         3/jphIdrYb+TVRHK5ZjpWDvKLiuNcTV3LSw3NvMJbDWlT600NEGGviBwQDS2eqwibUG5
         mzgeURiCDKXdx0jv3dQXK6+njmZhn/4jVYNEvCnGc/WLLBUgiHkIFUP+BkS2CPIyZ2Ih
         hcsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of arjan.van.de.ven@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=arjan.van.de.ven@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of arjan.van.de.ven@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=arjan.van.de.ven@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,501,1511856000";
   d="scan'208";a="203524513"
From: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
To: David Woodhouse <dwmw2@infradead.org>, Alexander Sergeyev
	<sergeev917@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Kyle Huey
	<me@kylehuey.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Levin,
 Alexander (Sasha Levin)" <alexander.levin@verizon.com>, Peter Zijlstra
	<peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: update spectre v2 microcodes blacklist
Thread-Topic: update spectre v2 microcodes blacklist
Thread-Index: AQHTo+TO+IKkHARMz0e3WxseD4Wi/aOgymnA
Date: Mon, 12 Feb 2018 13:56:15 +0000
Message-ID: <0575AF4FD06DD142AD198903C74E1CC87A61260B@ORSMSX103.amr.corp.intel.com>
References: <20180210123123.GA19396@localhost.localdomain>
	 <20180210171459.GA12797@localhost.localdomain>
 <1518428086.6606.11.camel@infradead.org>
In-Reply-To: <1518428086.6606.11.camel@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592016927852230730?=
X-GMAIL-MSGID: =?utf-8?q?1592203701722715886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiA+IFJhdyBkaWZmIGJldHdlZW4gdGhlIG1haW5saW5lIGJsYWNrbGlzdCBhbmQgdGhlIGJ1bGxl
dGluIGxvb2tzIGxpa2U6DQo+ID4gQEAgLTEsNSArMSw2IEBADQo+ID4gwqB7IElOVEVMX0ZBTTZf
QlJPQURXRUxMX0NPUkUswqDCoMKgwqDCoDB4MDQsIDB4MjggfSwNCj4gPiDCoHsgSU5URUxfRkFN
Nl9CUk9BRFdFTExfR1QzRSzCoMKgwqDCoMKgMHgwMSwgMHgxYiB9LA0KPiA+ICt7IElOVEVMX0ZB
TTZfQlJPQURXRUxMX1gswqDCoMKgwqDCoMKgwqDCoDB4MDEsIDB4MGIwMDAwMjMgfSwNCj4gPiDC
oHsgSU5URUxfRkFNNl9CUk9BRFdFTExfWCzCoMKgwqDCoMKgwqDCoMKgMHgwMSwgMHgwYjAwMDAy
NSB9LA0KPiANCj4gVGhhdCdzIHJlZHVuZGFudCBzaW5jZSBibGFja2xpc3RpbmcgMHgwYjAwMDAy
NSB3aWxsIGFsc28gc3RvcCB1cyBmcm9tDQo+IHVzaW5nIDB4MGIwMDAwMjMgYW55d2F5Lg0KDQph
bmQgMjMgaXMgdGhlIHByZSBzZWN1cml0eSB2ZXJzaW9uIHNvIGtub3duIGdvb2QuDQoNCg0KDQo=
