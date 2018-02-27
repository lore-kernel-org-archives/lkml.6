Return-Path: <tomas.winkler@intel.com>
X-Google-Smtp-Source: AG47ELtmGS4TRotEvnqtVZ/TrxxXh4XEk5beiSljGF//VHX6WMUidnw/eGtdRpmI99AsLnZP3Tck
ARC-Seal: i=1; a=rsa-sha256; t=1519752387; cv=none;
        d=google.com; s=arc-20160816;
        b=OM1shVkJ+40+vR68wlh10krqbYViP+937Zm8XINSvDsDLknYIvoiFz0W71pbAb8aGa
         7TLsrIxZLnNPLg0+G0TkFB+f0VSYR/Fc1G/BqRHJdasOHkKvWigGrnxXie24XdQowEZr
         HWXDpnAHQo8ub34AjniRRmPyubm+WNvWKmGKGoZaGq3mfo6MI5AEg1jYjfROk1Mq637E
         p2QwI0slqypfsFsMJ1iJ/85+BKUUfTiqxGMksfvXgxqxzIU5d8k9LCEKOYCnqydVEgek
         /o+71TcltCiWxII244EXukLJ/qMygPUFj7DqXSfgzEuxDirUFPAjyX+ITCGYajVhO8ou
         N5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=GlAYHAAyZlM7UdprxfkLl6ger6lym4eEQ4uEoc+W9qg=;
        b=ZtLRQrDFtATqc7sCaCmfR81IDFWvprAAfKUwVvWI8/vt8CYxuTNVSlaexZEPI2nHEK
         TsaQTW1ARC+wHcFvhQKbMlq6aUAS57jbkY2nphPRRu97YUPc+cupssleoS49gK8v6wcm
         BAsDCJl2ltgSE1OyZzU6gqfrZHLhNgyE4nHje2G+oC4Smh2OHw3ETko02/Vncd526QYt
         0MXXiAozZyd4zPtE0H3MdxVjjmPBJOXwMvNaMu5Vq7OdWwNm5KRuFriLYdk0rLcUFRoD
         KPPQa9QZCo2SOPxlI0OooWo6RzPrPDXPiVyI9A83790ACI9AoUcqoePbdTHMxlqJG/6l
         hWCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tomas.winkler@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=tomas.winkler@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tomas.winkler@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=tomas.winkler@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,401,1515484800";
   d="scan'208";a="34548334"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Colin King <colin.king@canonical.com>, Arnd Bergmann <arnd@arndb.de>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: remove dev_err message on an unsupported ioctl
Thread-Topic: [PATCH] mei: remove dev_err message on an unsupported ioctl
Thread-Index: AQHTr+cBWLhVLGez8kOOfhAUJlAh/6O4fpMA
Date: Tue, 27 Feb 2018 17:26:22 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422A4CC@hasmsx108.ger.corp.intel.com>
References: <20180227162105.14113-1-colin.king@canonical.com>
In-Reply-To: <20180227162105.14113-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGJkZDVmYjctNDdlNy00OTlkLWIyYmUtNDRkODA5NzUwNTExIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJON0VpSUNGNkc1REk2UkMxaTNmY1RzaHFkRHVRa0ZQTDBmU2tsR1lVelwvR3ZobTlaVzVcL01RS2RvVDFHZVh5Q04ifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.252.4.156]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593571772960941030?=
X-GMAIL-MSGID: =?utf-8?q?1593575878932809716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PiANCj4gRnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4g
DQo+IEN1cnJlbnRseSB0aGUgZHJpdmVyIHNwYW1zIHRoZSBrZXJuZWwgbG9nIG9uIHVuc3VwcG9y
dGVkIGlvY3RscyB3aGljaCBpcw0KPiB1bm5lY2Vzc2FyeSBhcyB0aGUgaW9jdGwgcmV0dXJucyAt
RU5PSU9DVExDTUQgdG8gaW5kaWNhdGUgdGhpcyBhbnl3YXkuDQo+IEkgc3VzcGVjdCB0aGlzIHdh
cyBvcmlnaW5hbGx5IGZvciBkZWJ1Z2dpbmcgcHVycG9zZXMgYnV0IGl0IHJlYWxseSBpcyBub3QN
Cj4gcmVxdWlyZWQgc28gcmVtb3ZlIGl0Lg0KPg0KDQpUaGlzIGlzIHJhdGhlciBzdHJhbmdlIGFz
IG1vc3Qgb2YgdGhlIGxlZ2ltaXQgYXBwbGljYXRpb25zIGFyZSB1c2luZyBvbmUgSU9DVEwgZnJv
bSBrZXJuZWwgMy4wDQpEbyB5b3UgaGF2ZSBhbnkgcmVmZXJlbmNlIHdoZXJlIHRoaXMgY2FsbCBp
cyBvcmlnaW5hdGVkIGZyb20sIGZyYW5rbHkgdGhpcyBpcyB0aGUgZmlyc3QgdGltZSBJIGdvdCBz
dWNoIGNvbXBsYWluLg0KDQpJbiBhbnkgY2FzZSBpdCB3b3VsZCBiZSBtYXliZSBiZXR0ZXIgdG8g
Y2hhbmdlIGl0IGEgd2FybiBvbmNlIGNhbGwuDQogDQpUaGFua3MNClRvbWFzDQoNCj4gU2lnbmVk
LW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL21pc2MvbWVpL21haW4uYyB8IDEgLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvbWVpL21haW4uYyBi
L2RyaXZlcnMvbWlzYy9tZWkvbWFpbi5jIGluZGV4DQo+IDc1OGRjNzM2MDJkNS4uN2JiMDEzNjQ0
YWViIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21pc2MvbWVpL21haW4uYw0KPiArKysgYi9kcml2
ZXJzL21pc2MvbWVpL21haW4uYw0KPiBAQCAtNTA3LDcgKzUwNyw2IEBAIHN0YXRpYyBsb25nIG1l
aV9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50DQo+IGNtZCwgdW5zaWduZWQg
bG9uZyBkYXRhKQ0KPiAgCQlicmVhazsNCj4gDQo+ICAJZGVmYXVsdDoNCj4gLQkJZGV2X2Vycihk
ZXYtPmRldiwgIjogdW5zdXBwb3J0ZWQgaW9jdGwgJWQuXG4iLCBjbWQpOw0KPiAgCQlyZXRzID0g
LUVOT0lPQ1RMQ01EOw0KPiAgCX0NCj4gDQo+IC0tDQo+IDIuMTUuMQ0KDQo=
