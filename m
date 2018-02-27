Return-Path: <tomas.winkler@intel.com>
X-Google-Smtp-Source: AH8x225cFnfD2AzBO/QkKTBepJV6PFL68JieVH86gj0BGmZJPVpr/wVqO+rVrEDxalPsa92K7TK+
ARC-Seal: i=1; a=rsa-sha256; t=1519768075; cv=none;
        d=google.com; s=arc-20160816;
        b=xFrWLiu0KK0xKYQAXWaL6iblvgwDcvLdnA0finVaVlOfjUGWAbcronGywUSSWah7V4
         XPbRUlZlx/sWHBHwIFJpSc/k5+wqMbIZfWcvT+1gsG+nYGd1cuvSOaIrqFYIq8J2u/X7
         m2f5hiKMAH5A00XZ9kRZ5dS/ueBDEJlt7ef9EuVXCD4iHSqRjgTjGOaiTbEPwKeR1GgS
         NA2LwxjRbD2cwQwaNQQjhXG+Skcm7QiNyFcJFEBK8k8reH2hr5crNx/pjAxktkU6EJRi
         vUc+IiFIwTmrn8c0gp3Vts0t3ijyW7hWrNSzHtfcTC93knVIcGxQLHplX1sCVg1v+MRb
         tmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=Wh/y0FLEGe1dzmgpiuksLW13eRWnLrTsSesAHyhGRp8=;
        b=viGCdR0VoEZZ84EsiL31r9pYkPQMvZ9xROa/P+G0/OS9dcEY5a7SrXBhBVvTDosJ2X
         enSUiBebago+/7LBusgwhfrxeQeFsEG/uZmk7XXEgIdGMmaQphcnA80wvU03xCwaz4i6
         eDbvmfHtMquBc1r8U3C6yCDJRkXz1Nptte16C1rqm93yDNTM8Ex6ZBRmnZKwjOSGqD/I
         cAWWoKPb5FkKKUiD0Up8WQ7dO1GbtjwHmOGnsxRmrVFvqiYphAWc+frAdlZjOvI1PBrJ
         Nb0yncfk/8AsQ2fVHVZL9hOSOldcklAcsCmdjcp4VN/MQsjPYT7xQRvz5PknN5JHC+1W
         Dutg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tomas.winkler@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=tomas.winkler@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tomas.winkler@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=tomas.winkler@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,402,1515484800";
   d="scan'208";a="20659706"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Colin Ian King <colin.king@canonical.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: remove dev_err message on an unsupported ioctl
Thread-Topic: [PATCH] mei: remove dev_err message on an unsupported ioctl
Thread-Index: AQHTr+cBWLhVLGez8kOOfhAUJlAh/6O4fpMA///hpYCAAGj7UA==
Date: Tue, 27 Feb 2018 21:47:51 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422A748@hasmsx108.ger.corp.intel.com>
References: <20180227162105.14113-1-colin.king@canonical.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9422A4CC@hasmsx108.ger.corp.intel.com>
 <42c81e25-52be-a80e-f304-765c9a71b328@canonical.com>
In-Reply-To: <42c81e25-52be-a80e-f304-765c9a71b328@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDc1ZmU0MDMtZTNmNS00YTU2LWFlMTUtYTcwZmEyNzRlNTMwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJRbXhsU1dzZUlwaXJldU9NS2JnU1wvMXNtVG1JVXg2YW56ZXpXcTMzSW5yTWh1Q3lSOXhvWEdCd2JrM3dEd1BnNyJ9
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.252.4.156]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593571772960941030?=
X-GMAIL-MSGID: =?utf-8?q?1593592329590167960?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQo+IE9uIDI3LzAyLzE4IDE3OjI2LCBXaW5rbGVyLCBUb21hcyB3cm90ZToNCj4gPj4NCj4gPj4g
RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gPj4NCj4g
Pj4gQ3VycmVudGx5IHRoZSBkcml2ZXIgc3BhbXMgdGhlIGtlcm5lbCBsb2cgb24gdW5zdXBwb3J0
ZWQgaW9jdGxzIHdoaWNoDQo+ID4+IGlzIHVubmVjZXNzYXJ5IGFzIHRoZSBpb2N0bCByZXR1cm5z
IC1FTk9JT0NUTENNRCB0byBpbmRpY2F0ZSB0aGlzDQo+IGFueXdheS4NCj4gPj4gSSBzdXNwZWN0
IHRoaXMgd2FzIG9yaWdpbmFsbHkgZm9yIGRlYnVnZ2luZyBwdXJwb3NlcyBidXQgaXQgcmVhbGx5
IGlzDQo+ID4+IG5vdCByZXF1aXJlZCBzbyByZW1vdmUgaXQuDQo+ID4+DQo+ID4NCj4gPiBUaGlz
IGlzIHJhdGhlciBzdHJhbmdlIGFzIG1vc3Qgb2YgdGhlIGxlZ2ltaXQgYXBwbGljYXRpb25zIGFy
ZSB1c2luZw0KPiA+IG9uZSBJT0NUTCBmcm9tIGtlcm5lbCAzLjAgRG8geW91IGhhdmUgYW55IHJl
ZmVyZW5jZSB3aGVyZSB0aGlzIGNhbGwgaXMNCj4gb3JpZ2luYXRlZCBmcm9tLCBmcmFua2x5IHRo
aXMgaXMgdGhlIGZpcnN0IHRpbWUgSSBnb3Qgc3VjaCBjb21wbGFpbi4NCj4gDQo+IEkgaGl0IHRo
aXMgd2hpbGUgc3RyZXNzaW5nIHRoZSBrZXJuZWwgd2l0aCBteSBzdHJlc3Mtbmcga2VybmVsIHN0
cmVzc2luZyB0b29sOw0KPiB0aGlzIHdhcyBub3QgdXNpbmcgdGhlIGxlZ2l0aW1hdGUgaW9jdGxz
ICh0byBzZWUgaWYgdGhpbmdzDQo+IGV4cGxvZGUpIGFuZCBJIGdvdCBhIHJhdGhlciBmdWxsIGtl
cm5lbCBsb2cuIFNvIGl0IHdhcyBiZWluZyBhYnVzZWQgc29tZXdoYXQNCj4gOy0pDQoNCk9rYXks
IHRoYW5rcyBmb3IgdGhlIGluZm8uDQoNCg==
