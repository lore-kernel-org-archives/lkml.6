Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52D6C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E392075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E392075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936546AbeFRTml (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:42:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:7005 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936040AbeFRTmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:42:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 12:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,240,1526367600"; 
   d="scan'208";a="238196997"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2018 12:42:38 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 18 Jun 2018 12:42:37 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.86]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.202]) with mapi id 14.03.0319.002;
 Mon, 18 Jun 2018 12:42:37 -0700
From:   "Brown, Aaron F" <aaron.f.brown@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
Subject: RE: [PATCH] net: fix e1000.rst Documentation build errors
Thread-Topic: [PATCH] net: fix e1000.rst Documentation build errors
Thread-Index: AQHUBdM6BFinoldVPkiQ7g5DONoKBqRmadGQ
Date:   Mon, 18 Jun 2018 19:42:37 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96503FDC@ORSMSX101.amr.corp.intel.com>
References: <4e7a8aa5-cd19-3f57-cc60-6e6224d02a69@infradead.org>
In-Reply-To: <4e7a8aa5-cd19-3f57-cc60-6e6224d02a69@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSYW5keSBEdW5sYXAgW21haWx0bzpyZHVubGFwQGluZnJhZGVhZC5vcmddDQo+IFNl
bnQ6IFNhdHVyZGF5LCBKdW5lIDE2LCAyMDE4IDU6MzYgUE0NCj4gVG86IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IERhdmlkIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IGxpbnV4LQ0KPiBk
b2NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBMS01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnPjsgS2lyc2hlciwgSmVmZnJleSBUDQo+IDxqZWZmcmV5LnQua2lyc2hlckBpbnRlbC5jb20+
OyBCcm93biwgQWFyb24gRiA8YWFyb24uZi5icm93bkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSF0gbmV0OiBmaXggZTEwMDAucnN0IERvY3VtZW50YXRpb24gYnVpbGQgZXJyb3JzDQo+IA0K
PiBGcm9tOiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gDQo+IEZpeCBE
b2N1bWVudGF0aW9uIGJ1aWxkIGVycm9ycyBpbiBlMTAwMC5yc3QuICBTZXZlcmFsIHNlY3Rpb24g
dGl0bGVzIGFuZA0KPiB0aGVpciB1bmRlcmxpbmVzIHNob3VsZCBub3QgYmUgaW5kZW50ZWQuDQo+
IA0KPiBEb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvZTEwMDAucnN0OjM1ODogKFNFVkVSRS80KSBV
bmV4cGVjdGVkIHNlY3Rpb24NCj4gdGl0bGUuDQo+IA0KPiBGaXhlczogMjI4MDQ2ZTc2MTg5ICgi
RG9jdW1lbnRhdGlvbjogZTEwMDA6IFVwZGF0ZSBrZXJuZWwNCj4gZG9jdW1lbnRhdGlvbiIpDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4N
Cj4gQ2M6IEplZmYgS2lyc2hlciA8amVmZnJleS50LmtpcnNoZXJAaW50ZWwuY29tPg0KPiBDYzog
QWFyb24gQnJvd24gPGFhcm9uLmYuYnJvd25AaW50ZWwuY29tPg0KPiAtLS0NCj4gSXMgdGhlcmUg
YSBTcGhpbnggdmVyc2lvbiBwcm9ibGVtIGhlcmU/ICBUZXN0ZWQtYnk6IHNob3VsZCBpbmRpY2F0
ZQ0KPiB0aGF0IHRoZXJlIHdhcyBubyBlcnJvciBsaWtlIEkgYW0gc2VlaW5nLiANCg0KVGhlICJU
ZXN0ZWQtYnk6IiBmb3IgdGhpcyAoYW5kIHRoZSBlMTAwIHZhcmlhbnQpIHdhcyBlbnRpcmVseSBm
b2N1c2VkIG9uIGNvcnJlY3RuZXNzIG9mIHRoZSBkb2N1bWVudGF0aW9uIHRleHQsIHBhcmFtZXRl
cnMgbWF0Y2ggdGhlIGRyaXZlciwgVVJMcyB3ZXJlIGNvcnJlY3QsIGV0Yy4uLiAgSW4gcmV0cm9z
cGVjdCAiVGVzdGVkLWJ5OiIgaXMgbm90IGV4YWN0bHkgYWNjdXJhdGUgYW5kIEkgcHJvYmFibHkg
c2hvdWxkIGhhdmUgbGVmdCBpdCBhdCBhIHNpbXBsZXIgYWNrLg0KDQo+IA0KPiAgRG9jdW1lbnRh
dGlvbi9uZXR3b3JraW5nL2UxMDAwLnJzdCB8ICAgMTIgKysrKysrLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gLS0tIGxueC00
MTgtcmMxLm9yaWcvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2UxMDAwLnJzdA0KPiArKysgbG54
LTQxOC1yYzEvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2UxMDAwLnJzdA0KPiBAQCAtMzU0LDgg
KzM1NCw4IEBAIHByZXZpb3VzbHkgbWVudGlvbmVkIHRvIGZvcmNlIHRoZSBhZGFwdGUNCj4gIEFk
ZGl0aW9uYWwgQ29uZmlndXJhdGlvbnMNCj4gID09PT09PT09PT09PT09PT09PT09PT09PT0NCj4g
DQo+IC0gIEp1bWJvIEZyYW1lcw0KPiAtICAtLS0tLS0tLS0tLS0NCj4gK0p1bWJvIEZyYW1lcw0K
PiArLS0tLS0tLS0tLS0tDQo+ICAgIEp1bWJvIEZyYW1lcyBzdXBwb3J0IGlzIGVuYWJsZWQgYnkg
Y2hhbmdpbmcgdGhlIE1UVSB0byBhIHZhbHVlIGxhcmdlcg0KPiB0aGFuDQo+ICAgIHRoZSBkZWZh
dWx0IG9mIDE1MDAuICBVc2UgdGhlIGlmY29uZmlnIGNvbW1hbmQgdG8gaW5jcmVhc2UgdGhlIE1U
VSBzaXplLg0KPiAgICBGb3IgZXhhbXBsZTo6DQo+IEBAIC0zODksOCArMzg5LDggQEAgQWRkaXRp
b25hbCBDb25maWd1cmF0aW9ucw0KPiAgICAgICBJbnRlbChSKSBQUk8vMTAwMCBHaWdhYml0IFNl
cnZlciBBZGFwdGVyDQo+ICAgICAgIEludGVsKFIpIFBSTy8xMDAwIFBNIE5ldHdvcmsgQ29ubmVj
dGlvbg0KPiANCj4gLSAgZXRodG9vbA0KPiAtICAtLS0tLS0tDQo+ICtldGh0b29sDQo+ICstLS0t
LS0tDQo+ICAgIFRoZSBkcml2ZXIgdXRpbGl6ZXMgdGhlIGV0aHRvb2wgaW50ZXJmYWNlIGZvciBk
cml2ZXIgY29uZmlndXJhdGlvbiBhbmQNCj4gICAgZGlhZ25vc3RpY3MsIGFzIHdlbGwgYXMgZGlz
cGxheWluZyBzdGF0aXN0aWNhbCBpbmZvcm1hdGlvbi4gIFRoZSBldGh0b29sDQo+ICAgIHZlcnNp
b24gMS42IG9yIGxhdGVyIGlzIHJlcXVpcmVkIGZvciB0aGlzIGZ1bmN0aW9uYWxpdHkuDQo+IEBA
IC0zOTgsOCArMzk4LDggQEAgQWRkaXRpb25hbCBDb25maWd1cmF0aW9ucw0KPiAgICBUaGUgbGF0
ZXN0IHJlbGVhc2Ugb2YgZXRodG9vbCBjYW4gYmUgZm91bmQgZnJvbQ0KPiAgICBodHRwczovL3d3
dy5rZXJuZWwub3JnL3B1Yi9zb2Z0d2FyZS9uZXR3b3JrL2V0aHRvb2wvDQo+IA0KPiAtICBFbmFi
bGluZyBXYWtlIG9uIExBTiogKFdvTCkNCj4gLSAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ICtFbmFibGluZyBXYWtlIG9uIExBTiogKFdvTCkNCj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiAgICBXb0wgaXMgY29uZmlndXJlZCB0aHJvdWdoIHRoZSBldGh0b29sKiB1dGls
aXR5Lg0KPiANCj4gICAgV29MIHdpbGwgYmUgZW5hYmxlZCBvbiB0aGUgc3lzdGVtIGR1cmluZyB0
aGUgbmV4dCBzaHV0IGRvd24gb3IgcmVib290Lg0KPiANCg0K
