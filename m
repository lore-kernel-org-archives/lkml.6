Return-Path: <marina.yatsina@intel.com>
X-Google-Smtp-Source: AH8x227I+8ZjdTj7Lw+k/jXSiy8UF0yPHQ/rNMn4ZYttdtYK8yccTeoXp4eMbq6Jx9IKf6SI6AqC
ARC-Seal: i=1; a=rsa-sha256; t=1518597224; cv=none;
        d=google.com; s=arc-20160816;
        b=TTb6AyVfZAMypzh6wQxKF3qtIMiZI5FFlJSR/rwRU7vm6uy2ZWaObOfv12vhfmwq3w
         kfCgbplZD9HhngZaMMr89bPzdHyuNQW+BIj2AH7fD0aLVjBslSq1HALqz2G/4pSwuKWI
         936M7tDxnXomQMGOmfdwph9oJTupiavkOmYOF1pgp+izfnSznvz2NCNcjCaUSGGhDTXm
         0ZOsAMP9JIZSX0oAMVdCleonsCsBx/z2UphsoEsnmBPo8AnDGZrVbYyVhZCFjNKqvpMf
         pzRaOxjmp30Y0fPNX+kKenTs/UnRLgOFl/qmTL0tuRw6ax5U2ikWaIhyc8aSNWYsqs9B
         uK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=serXLKEFp+dgJwiQ10/bJ+O5A27FferwA5YyIC8TOM4=;
        b=RYLYshX2TC2p8UOy00radt/YN306O76hQ7LdD8UKq/5+MF80/bkbn9nt+Eul3ViKHg
         9JugKI9jL0euDHHecBWKHdGafUj4H82hYcP4XFFJ3/EjaodSbOeBObIpyxXEeZhiNe/9
         J8kvZZ77xQq2TCaYknt9gxw0mgupMB0+gVWUm/BcdCgywObjzdr6a5y20kAZSbxfw25R
         9gKmhSUGn5HTXb7u67uFONbU4JERQjeaG7vv9gkJj2j9E+lIYyLakS6a68Fa0K4/rx2B
         G59klceM1fbDZCv4L5EZN7UdgDKHEIRHoZCrZkW8xdno7D5+GAyMTJ0Pbk06ziVHLSop
         MiwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marina.yatsina@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=marina.yatsina@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marina.yatsina@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=marina.yatsina@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,511,1511856000";
   d="scan'208";a="30636526"
From: "Yatsina, Marina" <marina.yatsina@intel.com>
To: Kees Cook <keescook@google.com>, David Woodhouse <dwmw2@infradead.org>,
	Chandler Carruth <chandlerc@google.com>, "Kreitzer, David L"
	<david.l.kreitzer@intel.com>, "Grischenko, Andrei L"
	<andrei.l.grischenko@intel.com>, "rnk@google.com" <rnk@google.com>, "LLVM
 Developers" <llvm-dev@lists.llvm.org>, "ehsan@mozilla.com"
	<ehsan@mozilla.com>, "Yatsina, Marina" <marina.yatsina@intel.com>, "Tayree,
 Coby" <coby.tayree@intel.com>, Matthias Braun <matze@braunis.de>, "Dean
 Michael Berris" <dean.berris@gmail.com>, James Y Knight <jyknight@google.com>
CC: Guenter Roeck <linux@roeck-us.net>, X86 ML <x86@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, "Rik
 van Riel" <riel@redhat.com>, Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf
	<jpoimboe@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jiri
 Kosina <jikos@kernel.org>, Andy Lutomirski <luto@amacapital.net>, "Hansen,
 Dave" <dave.hansen@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, Greg
 Kroah-Hartman <gregkh@linux-foundation.org>, Paul Turner <pjt@google.com>,
	Stephen Hines <srhines@google.com>, Nick Desaulniers
	<ndesaulniers@google.com>
Subject: RE: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
Thread-Topic: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
Thread-Index: AQHTpSrRc0Tf36QxBkW6ZxMIE0y/9aOjiI5w
Date: Wed, 14 Feb 2018 08:33:39 +0000
Message-ID: <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
In-Reply-To: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTkzNmZmOTMtYjE0Ny00YTA3LWI1YzMtZWZhMjYxZmQ4MjdmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJpQzJubWJWQ2ZPNlBicDNzbzFLb0prZGZQZHhZbVJCR3V3aGRhV0tDN2Rac1hrdloyOVRNTUdSY0Z2Nk1GOFhpIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.185.126.126]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592364603715549051?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgS2VlcywNCg0KV2hlbiBJIHJhaXNlZCB0aGUgcXVlc3Rpb24gb2Ygd2hldGhlciB3ZSB3YW50
IHRvIGFkZCBzdXBwb3J0IGZvciAiYXNtIGdvdG8iIGluIGxsdm0gSSBnb3Qgc29tZSBmZWVkYmFj
ayBmcm9tIHRoZSBjb21tdW5pdHkgdGhhdCAiYXNtIGdvdG8iIG1pZ2h0IG5vdCBiZSB0aGUgYmVz
dCBzb2x1dGlvbiBmb3IgdGhlIHByb2JsZW0gaXQgd2FzIGludmVudGVkIGZvciAob3B0aW1pemlu
ZyBzdXBwb3J0IGZvciB0cmFjZXBvaW50cyksIHNvIEkgc3RvcHBlZCBwZXJ1c2luZyB0aGlzIGlz
c3VlLg0KSSdtIENDLWluZyB0aGUgZGV2ZWxvcGVycyB0aGF0IHBhcnRpY2lwYXRlZCBpbiB0aGUg
b3JpZ2luYWwgdGhyZWFkIGFuZCBhIGZldyBkZXZlbG9wZXJzIHRoYXQgbWlnaHQgYmUgaW50ZXJl
c3RlZCBpbiBhZGRpbmcgc3VwcG9ydCBvZiAiYXNtIGdvdG8iLg0KSSdtIGFsc28gYWRkaW5nIHRo
ZSBsbHZtLWRldiBtYWlsaW5nIGxpc3QsIGluIGNhc2UgdGhlcmUgYXJlIGFkZGl0aW9uYWwgcGFy
dGllcyBpbnRlcmVzdGVkIGluIHZvaWNpbmcgdGhlaXIgb3Bpbmlvbi4NCg0KSSBob3BlIHRoaXMg
d2lsbCBnaXZlIHRoaXMgaXNzdWUgYSBwdXNoIGZvcndhcmQgYW5kIHdlIHdpbGwgZmluZCBhIHNv
bHV0aW9uIHRoYXQgd2lsbCBub3QgcHJldmVudCBsbHZtIGZyb20gY29tcGlsaW5nIGxpbnV4IGtl
cm5lbC4NCg0KVGhhbmtzLA0KTWFyaW5hDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBLZWVzIENvb2sgW21haWx0bzprZWVzY29va0Bnb29nbGUuY29tXSANClNlbnQ6IFdlZG5l
c2RheSwgRmVicnVhcnkgMTQsIDIwMTggMDI6MjkNClRvOiBEYXZpZCBXb29kaG91c2UgPGR3bXcy
QGluZnJhZGVhZC5vcmc+OyBDaGFuZGxlciBDYXJydXRoIDxjaGFuZGxlcmNAZ29vZ2xlLmNvbT47
IFlhdHNpbmEsIE1hcmluYSA8bWFyaW5hLnlhdHNpbmFAaW50ZWwuY29tPg0KQ2M6IEd1ZW50ZXIg
Um9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD47IFg4NiBNTCA8eDg2QGtlcm5lbC5vcmc+OyBMS01M
IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgQWxhbiBDb3ggPGdub21lc0BseG9yZ3Vr
LnVrdXUub3JnLnVrPjsgUmlrIHZhbiBSaWVsIDxyaWVsQHJlZGhhdC5jb20+OyBBbmRpIEtsZWVu
IDxha0BsaW51eC5pbnRlbC5jb20+OyBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAcmVkaGF0LmNv
bT47IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+OyBQZXRlciBaaWpsc3Ry
YSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgt
Zm91bmRhdGlvbi5vcmc+OyBKaXJpIEtvc2luYSA8amlrb3NAa2VybmVsLm9yZz47IEFuZHkgTHV0
b21pcnNraSA8bHV0b0BhbWFjYXBpdGFsLm5ldD47IEhhbnNlbiwgRGF2ZSA8ZGF2ZS5oYW5zZW5A
aW50ZWwuY29tPjsgVGltIENoZW4gPHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tPjsgR3JlZyBL
cm9haC1IYXJ0bWFuIDxncmVna2hAbGludXgtZm91bmRhdGlvbi5vcmc+OyBQYXVsIFR1cm5lciA8
cGp0QGdvb2dsZS5jb20+OyBTdGVwaGVuIEhpbmVzIDxzcmhpbmVzQGdvb2dsZS5jb20+OyBOaWNr
IERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4NClN1YmplY3Q6IGNsYW5nIGFz
bS1nb3RvIHN1cHBvcnQgKFdhcyBSZTogW1BBVENIIHYyXSB4ODYvcmV0cG9saW5lOiBBZGQgY2xh
bmcgc3VwcG9ydCkNCg0KT24gVHVlLCBGZWIgMTMsIDIwMTggYXQgNDoxMCBQTSwgRGF2aWQgV29v
ZGhvdXNlIDxkd213MkBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4gV2UgYWxzbyBuZWVkIHRvIHJl
c29sdmUgdGhlIGFzbS1nb3RvIHRoaW5nLg0KDQpZZXMsIHRoaXMgaXMgYmVjb21pbmcgbXVjaCBt
b3JlIHVyZ2VudCwgYXNzdW1pbmcgd2UnbGwgYmUgcmFpc2luZyB0aGUgbWluaW11bSBHQ0MgdmVy
c2lvbiBzb29uIGFuZCBkcm9wIHN1cHBvcnQgZm9yIGxhY2tpbmcgYXNtLWdvdG8uLi4NCg0KRG8g
eW91IGhhcHBlbiB0byBrbm93IHdobyB0aGUgcmlnaHQgcGVvcGxlIGFyZSB0byBpbmNsdWRlIHRv
IG1vdmUgdGhlIGRpc2N1c3Npb24gZm9yd2FyZD8gSSBrbm93IHZhcmlvdXMga2VybmVsIGZvbGtz
IHRoYXQgYXJlIHBhc3Npb25hdGUgYWJvdXQgaXQsIGJ1dCBJJ20gc3RpbGwgZ2V0dGluZyB0byBr
bm93IHdobyB0byB0YWxrIHdpdGggZnJvbSBsbHZtLg0KDQpJIHNlZSBhbiBlYXJsaWVyIHRocmVh
ZCBoZXJlOg0KaHR0cDovL2xpc3RzLmxsdm0ub3JnL3BpcGVybWFpbC9sbHZtLWRldi8yMDE3LUFw
cmlsLzExMTc0OC5odG1sDQoNCkl0IHNlZW1zIHRvIGVuZCB0aGVyZT8gSSdtIHN0aWxsIGNvbWlu
ZyB1cCB0byBzcGVlZCBvbiBpdCwgc28gSSdtIGxpa2VseSBtaXNzaW5nIG90aGVyIGNvbnRleHQu
DQoNCi1LZWVzDQoNCi0tDQpLZWVzIENvb2sNClBpeGVsIFNlY3VyaXR5DQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
SW50ZWwgSXNyYWVsICg3NCkgTGltaXRlZAoKVGhpcyBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50
cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgbWF0ZXJpYWwgZm9yCnRoZSBzb2xlIHVzZSBvZiB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpLiBBbnkgcmV2aWV3IG9yIGRpc3RyaWJ1dGlvbgpieSBv
dGhlcnMgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVk
CnJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBhbmQgZGVsZXRlIGFsbCBjb3Bp
ZXMuCg==
