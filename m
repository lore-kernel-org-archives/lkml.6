Return-Path: <dmitry.eremin@intel.com>
X-Google-Smtp-Source: AH8x225dMroB+NB/Ky1dZvHHjWLCrqXmYuqgStaQ4A7dDdc/zBaJX53XmTB5X7Oo2tlzkWfR28VE
ARC-Seal: i=1; a=rsa-sha256; t=1519123828; cv=none;
        d=google.com; s=arc-20160816;
        b=wxnOiuFaUBzHcfGFT9Dl8ZBCvMpxoB5pS80XA5q8jtIzjHyLpHHWL9TX41/yWZBcHD
         AnpBtqfIXCcLF6U2l0JupQUbwAx5yE752S2GYPlx+VuzQQEzYxuDt9jQ9M0oYFT9xIsZ
         W/ONT0ujsDU6ZavgtgcpN0CTofUcehLUBdgUupX3FpfuBsGO92D/WNUyaefrPyhtycE0
         bPVDAHJtt0ZXD1F4Xd74mUTdubZcMGflshw6WAJanOfuc+DPTD7l4JlxYIP1/pUPQeL7
         kRuIHw/FIJU+kyMnBbdEkhTzgm04eUgO/uHVjcR+TaL/7KLHEnDuEp59xQaxEladFnLn
         7dhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=RUaH/ZD8BvY/TWtL1mWYr5t+jBQFqRzz95Td8BD5piM=;
        b=H1/PqixZfzztdfDJxWK0PtGZZCIHoVA+s3fbhXADM17p+oDF4xRuAAOoVhP7+3WRlf
         CjX570OkITwLAPi8kMHk+FZtTd7QIXOgofzPU0F8GlXlX2nNyOrXxv1LI1FyIVDBmiIK
         JUNh5NuEgb2zlZUTMv3/5da3VVrJd5MP6euGhLH0hqYo+kPxYzMChyBxmjQ+Ab4/9XqF
         Le8OiEdTZ6UPpkzfAkPyHEX/goD6nn4Ovilt+WQSpZvx8sfo4tBlB2cvvi/4v2jKhvMw
         /qexmYCj3ypscobrthKuUg6CoYDP2Ey4JoFsyz3lDq/m12m1yKqOUCkJkTGR534ksd4g
         xxAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dmitry.eremin@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=dmitry.eremin@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dmitry.eremin@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=dmitry.eremin@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,538,1511856000";
   d="scan'208";a="202395446"
From: "Eremin, Dmitry" <dmitry.eremin@intel.com>
To: NeilBrown <neilb@suse.com>, "Drokin, Oleg" <oleg.drokin@intel.com>,
	"James Simmons" <jsimmons@infradead.org>, "Dilger, Andreas"
	<andreas.dilger@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: lkml <linux-kernel@vger.kernel.org>, lustre
	<lustre-devel@lists.lustre.org>
Subject: RE: [lustre-devel] [PATCH 14/21] staging: lustre: fix assorted
 checkpatch errors
Thread-Topic: [lustre-devel] [PATCH 14/21] staging: lustre: fix assorted
 checkpatch errors
Thread-Index: AQHTqfPgZAgkHfH0b0e/vnwE8ILnnaOs7T3AgAAP+QCAAB77kA==
Date: Tue, 20 Feb 2018 10:50:25 +0000
Message-ID: <9FC73D3DBECE0941BD2ED069D26863425CE8FF72@irsmsx110.ger.corp.intel.com>
References: <151909308778.25814.9912662268627044409.stgit@noble>
 <151909341801.25814.16760126077741712102.stgit@noble>
 <9FC73D3DBECE0941BD2ED069D26863425CE8FF1E@irsmsx110.ger.corp.intel.com>
 <87lgfojb0d.fsf@notabene.neil.brown.name>
In-Reply-To: <87lgfojb0d.fsf@notabene.neil.brown.name>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGIyY2QzYzEtYmI4Zi00ZjIzLTk5OTYtNDI1MjNjY2YyZTM2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IlJZQjRHT1NPUUZEZ2ZOWGxUNjUyamx5QXFMUk9mWDY5Rmc1RkZlK0RYdDg9In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592885047375416179?=
X-GMAIL-MSGID: =?utf-8?q?1592916788150684594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBUaGFua3MgZm9yIHRoZSByZXZpZXcuICBZ
ZXMsIHlvdSBhcmUgY29ycmVjdC4NCj4gSSBoYWQgc2VlbiB0aGF0IGVuZF9kaXJlbnQgd2FzIGlu
aXRpYWxpemVkIHRvIE5VTEwsIGFuZCBsZXQgbXlzZWxmDQo+IGJlbGlldmUgdGhhdCB3b3VsZCBt
YWtlIHRoZSB0cmFuc2Zvcm1hdGlvbiBzYWZlLg0KPiBJbiBmYWN0LCB0aGF0IGluaXRpYWxpemF0
aW9uIHRvIE5VTEwgaXMgcG9pbnRsZXNzIGFzIGl0IGlzIG5ldmVyIHVzZWQuDQo+IA0KPiBNYXli
ZSB0aGlzIHdvdWxkIGJlIGJldHRlcg0KPiANCj4gQEAgLTEwNTUsMTMgKzEwNTUsMTQgQEAgc3Rh
dGljIHZvaWQgbWRjX2FkanVzdF9kaXJwYWdlcyhzdHJ1Y3QgcGFnZQ0KPiAqKnBhZ2VzLCBpbnQg
Y2ZzX3BncywgaW50IGx1X3BncykNCj4gIAkJX191NjQgaGFzaF9lbmQgPSBsZTY0X3RvX2NwdShk
cC0+bGRwX2hhc2hfZW5kKTsNCj4gIAkJX191MzIgZmxhZ3MgPSBsZTMyX3RvX2NwdShkcC0+bGRw
X2ZsYWdzKTsNCj4gIAkJc3RydWN0IGx1X2RpcnBhZ2UgKmZpcnN0ID0gZHA7DQo+IC0JCXN0cnVj
dCBsdV9kaXJlbnQgKmVuZF9kaXJlbnQgPSBOVUxMOw0KPiAtCQlzdHJ1Y3QgbHVfZGlyZW50ICpl
bnQ7DQo+IA0KPiAgCQl3aGlsZSAoLS1sdV9wZ3MgPiAwKSB7DQo+IC0JCQllbnQgPSBsdV9kaXJl
bnRfc3RhcnQoZHApOw0KPiAtCQkJZm9yIChlbmRfZGlyZW50ID0gZW50OyBlbnQ7DQo+IC0JCQkg
ICAgIGVuZF9kaXJlbnQgPSBlbnQsIGVudCA9IGx1X2RpcmVudF9uZXh0KGVudCkpOw0KPiArCQkJ
c3RydWN0IGx1X2RpcmVudCAqZW5kX2RpcmVudCA9IE5VTEw7DQo+ICsJCQlzdHJ1Y3QgbHVfZGly
ZW50ICplbnQ7DQo+ICsNCj4gKwkJCWZvciAoZW50ID0gbHVfZGlyZW50X3N0YXJ0KGRwKTsgZW50
Ow0KPiArCQkJICAgICBlbnQgPSBsdV9kaXJlbnRfbmV4dChlbnQpKQ0KPiArCQkJCWVuZF9kaXJl
bnQgPSBlbnQ7DQo+IA0KPiAgCQkJLyogQWR2YW5jZSBkcCB0byBuZXh0IGx1X2RpcnBhZ2UuICov
DQo+ICAJCQlkcCA9IChzdHJ1Y3QgbHVfZGlycGFnZSAqKSgoY2hhciAqKWRwICsgTFVfUEFHRV9T
SVpFKTsNCj4gPz8NCg0KVGhhbmtzLCBJIGFncmVlIHdpdGggdGhpcyB2ZXJzaW9uLg0KDQpEbWl0
cnkuDQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KSm9pbnQgU3RvY2sgQ29tcGFueSBJbnRlbCBBL08KUmVnaXN0ZXJl
ZCBsZWdhbCBhZGRyZXNzOiBLcnlsYXRza3kgSGlsbHMgQnVzaW5lc3MgUGFyaywKMTcgS3J5bGF0
c2theWEgU3RyLiwgQmxkZyA0LCBNb3Njb3cgMTIxNjE0LApSdXNzaWFuIEZlZGVyYXRpb24KClRo
aXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1h
dGVyaWFsIGZvcgp0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gQW55
IHJldmlldyBvciBkaXN0cmlidXRpb24KYnkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQu
IElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZApyZWNpcGllbnQsIHBsZWFzZSBjb250YWN0IHRo
ZSBzZW5kZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVzLgo=
