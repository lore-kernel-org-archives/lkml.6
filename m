Return-Path: <David.Laight@aculab.com>
X-Google-Smtp-Source: AH8x226JJxdI+yovBEi5C7U5MBHBDNgp88Mvxk3sFlYEWRq7agTbJusq9eTXgpygdarsEcUIDf2q
ARC-Seal: i=1; a=rsa-sha256; t=1518109291; cv=none;
        d=google.com; s=arc-20160816;
        b=G/L1frYFurBmmQ3eACu9MEPuezjdOUb9g5OoZ/2t2AHIiX5FLbkEq3AD0UZtyCwBq8
         gQHmvVlvPA9Away59Bbx7RfxNY+fgxfRzIO2Dh/Fpnti2akFICJWkHfvkVij6+8NINH1
         Y06hhIDoBNQr70CF2iuA5ncE575tUw9DPDCn5SzuumB7FnCXWpSAYUs9mR6zuw0Q7Htv
         sIqWhGqweozhnrPPD1uWZqP0TKCVLeEgkd93JDi3wSrNRLZqMJVmEtPlfD0bq5MzCmPv
         GS73lkkmYn7QYPSxRXmO7fzlgJ8yBEAJmWB0QIHKMJOtfCbDrUpLE4hETZSNPugkzvmn
         HPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=TplNujDA65wdGkG2D6OEktwli4J4JmWLOJbYs0oGK0o=;
        b=Wmir+n7VsOmSiMEOzKVzxfvAH3ZapMZyXWRw929+vzTxTS97duux1PZoJ9b3qwhLI9
         3yBia2BEwCO7mbVJ720C2FWMAnGkwJ/3ER3QIAm8N4BL8hC2cD/DHWZdNmAmxbb+HE7w
         70NIsqtTvAABXaPAErN3XlGlDbjldN+VzNnXE8EabK4jrpfocsFfAjSNfxqBXou8x/yK
         3Cr5EFLaimMKCkD0B3eZEAh97Fko8/Cfr2tQ+oPoZZ5rsf4vRNB+i16s6YtCk0i9IiLQ
         7ZOO4leUfNqolRfJQucSKN390QVXP37CSahWzYwX54NKPMhmNZ1AYArywfgPRh7zCAML
         dciw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david.laight@aculab.com designates 192.162.217.181 as permitted sender) smtp.mailfrom=David.Laight@aculab.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david.laight@aculab.com designates 192.162.217.181 as permitted sender) smtp.mailfrom=David.Laight@aculab.com
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@arndb.de>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
CC: Ondrej Zary <linux@rainbow-software.org>, "whiteheadm@acm.org"
	<whiteheadm@acm.org>, David Woodhouse <dwmw2@infradead.org>, Guenter Roeck
	<linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Hugh
 Dickins" <hughd@google.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Jiri
 Kosina" <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>, Kees Cook
	<keescook@chromium.org>, Jamie Iles <jamie@jamieiles.com>, Eduardo Valentin
	<eduval@amazon.com>, Laura Abbott <labbott@redhat.com>, Rik van Riel
	<riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>, "Linux Kernel
 Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] x86 : i486 reporting to be vulnerable to
 Meltdown/Spectre_V1/Spectre_V2
Thread-Topic: [BUG] x86 : i486 reporting to be vulnerable to
 Meltdown/Spectre_V1/Spectre_V2
Thread-Index: AQHToPDO+LB8+cTBLkCPgdNxHI8N26Oat6YA
Date: Thu, 8 Feb 2018 17:02:14 +0000
Message-ID: <63ca28c5acb64de5ba33a81b6da5c507@AcuMS.aculab.com>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <1517950494.3677.30.camel@infradead.org>
 <CAP8WD_ZaewC-NE4szBzU3brvNhvV9PwoVo-uDFcEMTMWVbsxQQ@mail.gmail.com>
 <201802070918.18978.linux@rainbow-software.org>
 <20180208134908.4b516794@alans-desktop>
 <CAK8P3a2kuHXpJOVKux2v-B_=CrpnQBTMfV24sJqY+nQaSMf+KA@mail.gmail.com>
In-Reply-To: <CAK8P3a2kuHXpJOVKux2v-B_=CrpnQBTMfV24sJqY+nQaSMf+KA@mail.gmail.com>
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
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591852968450895340?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAwOCBGZWJydWFyeSAyMDE4IDE1OjIzDQouLi4N
Cj4gVGhlIFdpbmNoaXAgaXMgd2hhdCBldmVudHVhbGx5IHR1cm5lZCBpbnRvIHRoZSBWSUEgTmFu
bywgd2hpY2ggZG9lcw0KPiBoYXZlIHNwZWN1bGF0aXZlIGV4ZWN1dGlvbiwgYnV0IEkgZG9uJ3Qg
dGhpbmsgdGhlIGVhcmxpZXIgQzMgYW5kIEM3IGRpZCwNCj4gdGhleSBhcmUgbXVjaCBjbG9zZXIg
dG8gdGhlIG9yaWdpbmFsIFdpbmNoaXAgZGVzaWduLg0KDQpXZSBoYWQgdGVycmlibGUgdHJvdWJs
ZSBnZXR0aW5nIChJSVJDKSB0aGUgQzcgdG8gZXhlY3V0ZSBmdW5jdGlvbnMNCnRoYXQgd2VyZSBj
YWxsZWQgaW4gMTZiaXQgbW9kZSBhbmQgcmV0dXJuZWQgaW4gMzJiaXQgbW9kZSBhbmQgdi52Lg0K
KGZvciBib290IGNvZGUgYmlvcyBjYWxscykuDQpUaGUgcHJvYmxlbXMgc2VlbWVkIHRvIGltcGx5
IHRoYXQgaXQgd2FzIGNhY2hpbmcgcmV0dXJuIGFkZHJlc3Nlcw0KYW5kIHRoZSB0cmFuc2xhdGlv
biAodG8gdW9wcykgb2YgdGhlIGluc3RydWN0aW9ucyB0aGF0IGZvbGxvd2VkLg0KU28gaXQgd291
bGQgZWZmZWN0aXZlbHkgZGVjb2RlIHRoZSBmaXJzdCBmZXcgYnl0ZXMgaW4gdGhlIHdyb25nIG1v
ZGUuDQpTbyB0aGVyZSBtaWdodCBiZSBzY29wZSBmb3Igb25lIG9mIHRoZXNlIGF0dGFja3MuDQoN
Ck9UT0ggdGhlc2UgZGV2aWNlcyB3ZXJlIHNvIHNsb3cgdGhhdCBJIGRvdWJ0IGFueSBhcmUgdXNl
ZCBmb3IgYW55dGhpbmcNCnNlcmlvdXMgLSBhbmQgY2VydGFpbmx5IHdvbid0IGdldCBhIGtlcm5l
bCB1cGRhdGUgZXZlbiBpZiB0aGV5IGFyZS4NCg0KQWxzbyB3b3J0aCBub3RoaW5nIHRoYXQgdGhl
IGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgY3B1IGFuZCBtZW1vcnkNCnNwZWVkcyBpcyBtdWNoIGxv
d2VyIC0gc28gZmFyIGZld2VyIGluc3RydWN0aW9ucyBjb3VsZCBiZSBzcGVjdWxhdGl2ZWx5DQpl
eGVjdXRlZCB3aGlsZSB3YWl0aW5nIGEgY2FjaGUgbWlzcy4NCg0KVGVtcHRpbmcgdG8gZGlzYWJs
ZSBldmVyeXRoaW5nLg0KDQoJRGF2aWQNCg0K
