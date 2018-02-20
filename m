Return-Path: <dmitry.eremin@intel.com>
X-Google-Smtp-Source: AH8x224EykK7eaB2/EX8MwsNjYLj4TQWte6x6Jc3v6KOD4K063Q/jvjimewA8u3Ro5UYkpJW7vxJ
ARC-Seal: i=1; a=rsa-sha256; t=1519114060; cv=none;
        d=google.com; s=arc-20160816;
        b=WRR8ConjfdAqopKQW2yWS4J6hfGRlHIJIUEvsVcKYUu6b6WIP+jw+jBiC8V5R5OCia
         q3TA9MRIDaBjDJEM3th8RDcxzu4sIT1ikqRVu6kLmhvijCDFa1gg0umGD2Oiddxwnzpg
         iH1LEuvmxxdRpYn99IMR81zjD5inI3OC+9nNEXmr3ElkXUbWmrYZod78R5tTEQw7kSJG
         pn0mz6h2DK97MaXn11B49SA77DYIGQO3lAYnRn2abpNWkB+AveEIlyAkdQBRN6NnEWSY
         wvXq2MWm1xLFK1dpWmZWdRfzPJAbbkgjA8m53WNbeEi9xeilqwXHPl4Wo+mYHzfuVGqu
         75tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=fPfIdXYikKVo8B0CoQF18HZYSKCAE25MDCsVKf4Mi6U=;
        b=wJmhSnjGMioeiSg9Wh3MfLteGiQaeHMVLnyhlNIzjQ9BDpzTddHmESi8nqZMFLZ6JB
         TzfFUUl9+pYxwRrW23V3rhkDP/wtDA31n0sUvmGuzZYZcJEUeIJzt++dYR890ZXHSj1V
         nv9k0wfohH9xJgNJeVbzhR3ZtHgdDNc9YlOX6JkGo7hgxUctN/boEkNyqgJT2zwq0the
         PqI6NaOtSQxbjjI5Wij+EJoomuqdAxt33gRKhp0wjsUc9mBIpcOGge2qQZ9V00QGOc0l
         l0P7NE+/8YlbCWhNpWMMKVyuNgbL7XSkPXBPJrqv9utbwL9DvPp4anH1WYgn8B0M3KRk
         Q3hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dmitry.eremin@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=dmitry.eremin@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dmitry.eremin@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=dmitry.eremin@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,538,1511856000";
   d="scan'208";a="176607368"
From: "Eremin, Dmitry" <dmitry.eremin@intel.com>
To: NeilBrown <neilb@suse.com>, "Drokin, Oleg" <oleg.drokin@intel.com>, James
 Simmons <jsimmons@infradead.org>, "Dilger, Andreas"
	<andreas.dilger@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: lkml <linux-kernel@vger.kernel.org>, lustre
	<lustre-devel@lists.lustre.org>
Subject: RE: [lustre-devel] [PATCH 14/21] staging: lustre: fix assorted
 checkpatch errors
Thread-Topic: [lustre-devel] [PATCH 14/21] staging: lustre: fix assorted
 checkpatch errors
Thread-Index: AQHTqfPgZAgkHfH0b0e/vnwE8ILnnaOs7T3A
Date: Tue, 20 Feb 2018 08:07:36 +0000
Message-ID: <9FC73D3DBECE0941BD2ED069D26863425CE8FF1E@irsmsx110.ger.corp.intel.com>
References: <151909308778.25814.9912662268627044409.stgit@noble>
 <151909341801.25814.16760126077741712102.stgit@noble>
In-Reply-To: <151909341801.25814.16760126077741712102.stgit@noble>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzM4NDI1OWYtY2M3Ny00YTk5LTkxMzQtNTRmM2M1MjE0Y2FhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IkdEUmdCUTEzMnNncGNVYjlBSjNjWVZkdjdGWHJJWnVnXC83NjkxVWRYcTdBPSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592885047375416179?=
X-GMAIL-MSGID: =?utf-8?q?1592906545368958158?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGVsbG8gTmVpbCwNCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2x1c3RyZS9sdXN0
cmUvbWRjL21kY19yZXF1ZXN0LmMNCj4gYi9kcml2ZXJzL3N0YWdpbmcvbHVzdHJlL2x1c3RyZS9t
ZGMvbWRjX3JlcXVlc3QuYw0KPiBpbmRleCBhYjQ4NzQ2Y2U0MzMuLmJkZTI3YWNiMGRkMyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL2x1c3RyZS9sdXN0cmUvbWRjL21kY19yZXF1ZXN0
LmMNCj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL2x1c3RyZS9sdXN0cmUvbWRjL21kY19yZXF1ZXN0
LmMNCj4gQEAgLTEwNjAsOCArMTA2MCwxMCBAQCBzdGF0aWMgdm9pZCBtZGNfYWRqdXN0X2RpcnBh
Z2VzKHN0cnVjdCBwYWdlDQo+ICoqcGFnZXMsIGludCBjZnNfcGdzLCBpbnQgbHVfcGdzKQ0KPiAN
Cj4gIAkJd2hpbGUgKC0tbHVfcGdzID4gMCkgew0KPiAgCQkJZW50ID0gbHVfZGlyZW50X3N0YXJ0
KGRwKTsNCj4gLQkJCWZvciAoZW5kX2RpcmVudCA9IGVudDsgZW50Ow0KPiAtCQkJICAgICBlbmRf
ZGlyZW50ID0gZW50LCBlbnQgPSBsdV9kaXJlbnRfbmV4dChlbnQpKTsNCj4gKwkJCXdoaWxlIChl
bnQpIHsNCj4gKwkJCQllbmRfZGlyZW50ID0gZW50Ow0KPiArCQkJCWVudCA9IGx1X2RpcmVudF9u
ZXh0KGVudCk7DQo+ICsJCQl9DQo+IA0KPiAgCQkJLyogQWR2YW5jZSBkcCB0byBuZXh0IGx1X2Rp
cnBhZ2UuICovDQo+ICAJCQlkcCA9IChzdHJ1Y3QgbHVfZGlycGFnZSAqKSgoY2hhciAqKWRwICsg
TFVfUEFHRV9TSVpFKTsNCg0KSSBkb3VidCB0aGlzIGlzIGNvcnJlY3QgcmVwbGFjZW1lbnQuIElu
IG9yaWdpbmFsIGNvZGUgZW5kX2RpcmVudCBpcyBzZXQgYWx3YXlzIGluIHRoZSBiZWdpbiBvZiBv
dXRlciBsb29wICh3aGlsZSAoLS1sdV9wZ3MgPiAwKSkuIEJ1dCBpbiBuZXcgY29kZSB0aGlzIGlz
IG1pc3NlZC4gVGhlcmVmb3JlIGluIGNhc2Ugb2Ygc2Vjb25kIGl0ZXJhdGlvbiBhbmQgKGVudCA9
IGx1X2RpcmVudF9zdGFydChkcCkpID09IE5VTEwgdGhlIGVuZF9kaXJlbnQgd2lsbCBjb250YWlu
IGEgdmFsdWUgZnJvbSBwcmV2aW91cyBpdGVyYXRpb24gd2hpY2ggaXMgbm90IGNvcnJlY3QuDQoN
CkRtaXRyeS4NCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpKb2ludCBTdG9jayBDb21wYW55IEludGVsIEEvTwpSZWdp
c3RlcmVkIGxlZ2FsIGFkZHJlc3M6IEtyeWxhdHNreSBIaWxscyBCdXNpbmVzcyBQYXJrLAoxNyBL
cnlsYXRza2F5YSBTdHIuLCBCbGRnIDQsIE1vc2NvdyAxMjE2MTQsClJ1c3NpYW4gRmVkZXJhdGlv
bgoKVGhpcyBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRp
YWwgbWF0ZXJpYWwgZm9yCnRoZSBzb2xlIHVzZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMp
LiBBbnkgcmV2aWV3IG9yIGRpc3RyaWJ1dGlvbgpieSBvdGhlcnMgaXMgc3RyaWN0bHkgcHJvaGli
aXRlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkCnJlY2lwaWVudCwgcGxlYXNlIGNvbnRh
Y3QgdGhlIHNlbmRlciBhbmQgZGVsZXRlIGFsbCBjb3BpZXMuCg==
