Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE886C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350572075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350572075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeJaAfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:35:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:12297 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeJaAfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:35:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 08:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="82110376"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga007.fm.intel.com with ESMTP; 30 Oct 2018 08:41:07 -0700
Received: from orsmsx113.amr.corp.intel.com ([169.254.9.125]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.228]) with mapi id 14.03.0415.000;
 Tue, 30 Oct 2018 08:41:06 -0700
From:   "Gross, Mark" <mark.gross@intel.com>
To:     Colin King <colin.king@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tlclk: lean an indentation issue, remove extraneous tabs
Thread-Topic: [PATCH] tlclk: lean an indentation issue, remove extraneous
 tabs
Thread-Index: AQHUcEepQ4LgUi9ngE24LQbG+Y4xuaU37SIQ
Date:   Tue, 30 Oct 2018 15:41:06 +0000
Message-ID: <BD75D217E5BAC84080F8EFB258297637DBD8401D@ORSMSX113.amr.corp.intel.com>
References: <20181030115650.21104-1-colin.king@canonical.com>
In-Reply-To: <20181030115650.21104-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWQ0NjMwYjUtYzY2MC00ZTgxLWJmZGItY2ExMmZlOTY3YzFmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSzlFbTJHVCtOWTBtSFRUZjdBNE92ZXQ4VjcxR09yZ1A1K3FNRklyYmdiWWxkM0xyUTZxMkczYUNpUGxYM3I1KyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va3MgY29vbCB0byBtZS4NCg0KUmV2aWV3ZWQtYnkgPG1hcmsuZ3Jvc3NAaW50ZWwuY29tPg0K
DQotLW1hcmsNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb2xpbiBL
aW5nIFttYWlsdG86Y29saW4ua2luZ0BjYW5vbmljYWwuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBP
Y3RvYmVyIDMwLCAyMDE4IDQ6NTcgQU0NCj4gVG86IEdyb3NzLCBNYXJrIDxtYXJrLmdyb3NzQGlu
dGVsLmNvbT47IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+Ow0KPiBHcmVnIEtyb2FoLUhh
cnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBDYzoga2VybmVsLWphbml0b3Jz
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBbUEFUQ0hdIHRsY2xrOiBsZWFuIGFuIGluZGVudGF0aW9uIGlzc3VlLCByZW1vdmUgZXh0cmFu
ZW91cyB0YWJzDQo+IA0KPiBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmlj
YWwuY29tPg0KPiANCj4gVHJpdmlhbCBmaXggdG8gY2xlYW4gdXAgYW4gaW5kZW50YXRpb24gaXNz
dWUsIHJlbW92ZSB0YWJzDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29s
aW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvY2hhci90bGNsay5jIHwg
ODQgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2NoYXIvdGxjbGsuYyBiL2RyaXZlcnMvY2hhci90bGNsay5jIGluZGV4
DQo+IDhlZWI0MTkwMjA3ZC4uYTBmMmMwNTA2MTc2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2No
YXIvdGxjbGsuYw0KPiArKysgYi9kcml2ZXJzL2NoYXIvdGxjbGsuYw0KPiBAQCAtNTA2LDI3ICs1
MDYsMjcgQEAgc3RhdGljIHNzaXplX3QNCj4gc3RvcmVfc2VsZWN0X2FtY2IyX3RyYW5zbWl0X2Ns
b2NrKHN0cnVjdCBkZXZpY2UgKmQsDQo+IA0KPiAgCXZhbCA9ICh1bnNpZ25lZCBjaGFyKXRtcDsN
Cj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmZXZlbnRfbG9jaywgZmxhZ3MpOw0KPiAtCQlpZiAoKHZh
bCA9PSBDTEtfOGtIeikgfHwgKHZhbCA9PSBDTEtfMTZfMzg0TUh6KSkgew0KPiAtCQkJU0VUX1BP
UlRfQklUUyhUTENMS19SRUczLCAweGM3LCAweDI4KTsNCj4gLQkJCVNFVF9QT1JUX0JJVFMoVExD
TEtfUkVHMSwgMHhmYiwgfnZhbCk7DQo+IC0JCX0gZWxzZSBpZiAodmFsID49IENMS184XzU5Mk1I
eikgew0KPiAtCQkJU0VUX1BPUlRfQklUUyhUTENMS19SRUczLCAweGM3LCAweDM4KTsNCj4gLQkJ
CXN3aXRjaCAodmFsKSB7DQo+IC0JCQljYXNlIENMS184XzU5Mk1IejoNCj4gLQkJCQlTRVRfUE9S
VF9CSVRTKFRMQ0xLX1JFRzAsIDB4ZmMsIDIpOw0KPiAtCQkJCWJyZWFrOw0KPiAtCQkJY2FzZSBD
TEtfMTFfMTg0TUh6Og0KPiAtCQkJCVNFVF9QT1JUX0JJVFMoVExDTEtfUkVHMCwgMHhmYywgMCk7
DQo+IC0JCQkJYnJlYWs7DQo+IC0JCQljYXNlIENMS18zNF8zNjhNSHo6DQo+IC0JCQkJU0VUX1BP
UlRfQklUUyhUTENMS19SRUcwLCAweGZjLCAzKTsNCj4gLQkJCQlicmVhazsNCj4gLQkJCWNhc2Ug
Q0xLXzQ0XzczNk1IejoNCj4gLQkJCQlTRVRfUE9SVF9CSVRTKFRMQ0xLX1JFRzAsIDB4ZmMsIDEp
Ow0KPiAtCQkJCWJyZWFrOw0KPiAtCQkJfQ0KPiAtCQl9IGVsc2UNCj4gLQkJCVNFVF9QT1JUX0JJ
VFMoVExDTEtfUkVHMywgMHhjNywgdmFsIDw8IDMpOw0KPiArCWlmICgodmFsID09IENMS184a0h6
KSB8fCAodmFsID09IENMS18xNl8zODRNSHopKSB7DQo+ICsJCVNFVF9QT1JUX0JJVFMoVExDTEtf
UkVHMywgMHhjNywgMHgyOCk7DQo+ICsJCVNFVF9QT1JUX0JJVFMoVExDTEtfUkVHMSwgMHhmYiwg
fnZhbCk7DQo+ICsJfSBlbHNlIGlmICh2YWwgPj0gQ0xLXzhfNTkyTUh6KSB7DQo+ICsJCVNFVF9Q
T1JUX0JJVFMoVExDTEtfUkVHMywgMHhjNywgMHgzOCk7DQo+ICsJCXN3aXRjaCAodmFsKSB7DQo+
ICsJCWNhc2UgQ0xLXzhfNTkyTUh6Og0KPiArCQkJU0VUX1BPUlRfQklUUyhUTENMS19SRUcwLCAw
eGZjLCAyKTsNCj4gKwkJCWJyZWFrOw0KPiArCQljYXNlIENMS18xMV8xODRNSHo6DQo+ICsJCQlT
RVRfUE9SVF9CSVRTKFRMQ0xLX1JFRzAsIDB4ZmMsIDApOw0KPiArCQkJYnJlYWs7DQo+ICsJCWNh
c2UgQ0xLXzM0XzM2OE1IejoNCj4gKwkJCVNFVF9QT1JUX0JJVFMoVExDTEtfUkVHMCwgMHhmYywg
Myk7DQo+ICsJCQlicmVhazsNCj4gKwkJY2FzZSBDTEtfNDRfNzM2TUh6Og0KPiArCQkJU0VUX1BP
UlRfQklUUyhUTENMS19SRUcwLCAweGZjLCAxKTsNCj4gKwkJCWJyZWFrOw0KPiArCQl9DQo+ICsJ
fSBlbHNlDQo+ICsJCVNFVF9QT1JUX0JJVFMoVExDTEtfUkVHMywgMHhjNywgdmFsIDw8IDMpOw0K
PiANCj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZldmVudF9sb2NrLCBmbGFncyk7DQo+IA0K
PiBAQCAtNTQ4LDI3ICs1NDgsMjcgQEAgc3RhdGljIHNzaXplX3QNCj4gc3RvcmVfc2VsZWN0X2Ft
Y2IxX3RyYW5zbWl0X2Nsb2NrKHN0cnVjdCBkZXZpY2UgKmQsDQo+IA0KPiAgCXZhbCA9ICh1bnNp
Z25lZCBjaGFyKXRtcDsNCj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmZXZlbnRfbG9jaywgZmxhZ3Mp
Ow0KPiAtCQlpZiAoKHZhbCA9PSBDTEtfOGtIeikgfHwgKHZhbCA9PSBDTEtfMTZfMzg0TUh6KSkg
ew0KPiAtCQkJU0VUX1BPUlRfQklUUyhUTENMS19SRUczLCAweGY4LCAweDUpOw0KPiAtCQkJU0VU
X1BPUlRfQklUUyhUTENMS19SRUcxLCAweGZiLCB+dmFsKTsNCj4gLQkJfSBlbHNlIGlmICh2YWwg
Pj0gQ0xLXzhfNTkyTUh6KSB7DQo+IC0JCQlTRVRfUE9SVF9CSVRTKFRMQ0xLX1JFRzMsIDB4Zjgs
IDB4Nyk7DQo+IC0JCQlzd2l0Y2ggKHZhbCkgew0KPiAtCQkJY2FzZSBDTEtfOF81OTJNSHo6DQo+
IC0JCQkJU0VUX1BPUlRfQklUUyhUTENMS19SRUcwLCAweGZjLCAyKTsNCj4gLQkJCQlicmVhazsN
Cj4gLQkJCWNhc2UgQ0xLXzExXzE4NE1IejoNCj4gLQkJCQlTRVRfUE9SVF9CSVRTKFRMQ0xLX1JF
RzAsIDB4ZmMsIDApOw0KPiAtCQkJCWJyZWFrOw0KPiAtCQkJY2FzZSBDTEtfMzRfMzY4TUh6Og0K
PiAtCQkJCVNFVF9QT1JUX0JJVFMoVExDTEtfUkVHMCwgMHhmYywgMyk7DQo+IC0JCQkJYnJlYWs7
DQo+IC0JCQljYXNlIENMS180NF83MzZNSHo6DQo+IC0JCQkJU0VUX1BPUlRfQklUUyhUTENMS19S
RUcwLCAweGZjLCAxKTsNCj4gLQkJCQlicmVhazsNCj4gLQkJCX0NCj4gLQkJfSBlbHNlDQo+IC0J
CQlTRVRfUE9SVF9CSVRTKFRMQ0xLX1JFRzMsIDB4ZjgsIHZhbCk7DQo+ICsJaWYgKCh2YWwgPT0g
Q0xLXzhrSHopIHx8ICh2YWwgPT0gQ0xLXzE2XzM4NE1IeikpIHsNCj4gKwkJU0VUX1BPUlRfQklU
UyhUTENMS19SRUczLCAweGY4LCAweDUpOw0KPiArCQlTRVRfUE9SVF9CSVRTKFRMQ0xLX1JFRzEs
IDB4ZmIsIH52YWwpOw0KPiArCX0gZWxzZSBpZiAodmFsID49IENMS184XzU5Mk1Ieikgew0KPiAr
CQlTRVRfUE9SVF9CSVRTKFRMQ0xLX1JFRzMsIDB4ZjgsIDB4Nyk7DQo+ICsJCXN3aXRjaCAodmFs
KSB7DQo+ICsJCWNhc2UgQ0xLXzhfNTkyTUh6Og0KPiArCQkJU0VUX1BPUlRfQklUUyhUTENMS19S
RUcwLCAweGZjLCAyKTsNCj4gKwkJCWJyZWFrOw0KPiArCQljYXNlIENMS18xMV8xODRNSHo6DQo+
ICsJCQlTRVRfUE9SVF9CSVRTKFRMQ0xLX1JFRzAsIDB4ZmMsIDApOw0KPiArCQkJYnJlYWs7DQo+
ICsJCWNhc2UgQ0xLXzM0XzM2OE1IejoNCj4gKwkJCVNFVF9QT1JUX0JJVFMoVExDTEtfUkVHMCwg
MHhmYywgMyk7DQo+ICsJCQlicmVhazsNCj4gKwkJY2FzZSBDTEtfNDRfNzM2TUh6Og0KPiArCQkJ
U0VUX1BPUlRfQklUUyhUTENMS19SRUcwLCAweGZjLCAxKTsNCj4gKwkJCWJyZWFrOw0KPiArCQl9
DQo+ICsJfSBlbHNlDQo+ICsJCVNFVF9QT1JUX0JJVFMoVExDTEtfUkVHMywgMHhmOCwgdmFsKTsN
Cj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZldmVudF9sb2NrLCBmbGFncyk7DQo+IA0KPiAg
CXJldHVybiBzdHJubGVuKGJ1ZiwgY291bnQpOw0KPiAtLQ0KPiAyLjE5LjENCg0K
