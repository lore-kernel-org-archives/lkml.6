Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EECC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0282064E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0282064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeHVLcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 07:32:54 -0400
Received: from mx1.unisoc.com ([222.66.158.135]:59226 "EHLO SHSQR01.unisoc.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727772AbeHVLcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 07:32:53 -0400
X-Greylist: delayed 3030 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2018 07:32:53 EDT
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id w7M7ITav053044
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 15:18:29 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id w7M7GTXM047422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 22 Aug 2018 15:16:30 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from BJMBX02.spreadtrum.com (10.0.64.8) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 22 Aug 2018
 15:16:46 +0800
Received: from BJMBX02.spreadtrum.com ([::1]) by BJMBX02.spreadtrum.com
 ([fe80::1d12:43ae:e774:667f%19]) with mapi id 15.00.0847.030; Wed, 22 Aug
 2018 15:16:34 +0800
From:   =?gb2312?B?Q2h1bnlhbiBaaGFuZyAo1cW0utHeKQ==?= 
        <Chunyan.Zhang@unisoc.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V5 00/10] mmc: add support for sdhci 4.0
Thread-Topic: [PATCH V5 00/10] mmc: add support for sdhci 4.0
Thread-Index: AQHUOeca04hghWcTWk2ygzqz54fiYaTLWm+M
Date:   Wed, 22 Aug 2018 07:16:34 +0000
Message-ID: <2195f45cb5ce4cb5903ac213d05135ce@BJMBX02.spreadtrum.com>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>,<CAAfSe-sJYD4_9KGo+z8UzYHkdP15qz4=5U42_cT9tA9+B4bk1Q@mail.gmail.com>
In-Reply-To: <CAAfSe-sJYD4_9KGo+z8UzYHkdP15qz4=5U42_cT9tA9+B4bk1Q@mail.gmail.com>
Accept-Language: en-US, zh-CN, en-HK
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.93.65]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com w7M7GTXM047422
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAxNiBBdWcgMjAxOCBhdCAxNTo1NCwgQ2h1bnlhbiBaaGFuZyA8emhhbmcuY2h1bnlh
bkBsaW5hcm8ub3JnPiB3cm90ZToNCj4NCj4gRnJvbSB0aGUgU0QgaG9zdCBjb250cm9sbGVyIHZl
cnNpb24gNC4wIG9uLCBTREhDSSBpbXBsZW1lbnRhdGlvbiBlaXRoZXINCj4gaXMgdmVyc2lvbiAz
IGNvbXBhdGlibGUgb3IgdmVyc2lvbiA0IG1vZGUuIFRoaXMgcGF0Y2gtc2V0IGNvdmVycyB0aG9z
ZQ0KPiBjaGFuZ2VzIHdoaWNoIGFyZSBjb21tb24gZm9yIFNESENJIDQuMCB2ZXJzaW9uLCByZWdh
cmRsZXNzIG9mIHdoZXRoZXINCj4gdGhleSBhcmUgdXNlZCB3aXRoIFNEIG9yIGVNTUMgc3RvcmFn
ZSBkZXZpY2VzLg0KPg0KPiBUaGlzIHBhdGNoc2V0IGFsc28gYWRkZWQgYSBuZXcgc2RoY2kgZHJp
dmVyIGZvciBTcHJlYWR0cnVtJ3MgY29udHJvbGxlcg0KPiB3aGljaCBzdXBwb3J0cyB2NC4wIG1v
ZGUuDQo+DQo+IFRoaXMgcGF0Y2hzZXQgaGFzIGJlZW4gdGVzdGVkIG9uIFNwcmVhZHRydW0ncyBt
b2JpbGUgcGhvbmUsIGVtbWMgY2FuIGJlDQo+IGluaXRpYWxpemVkLCBtb3VudGVkLCByZWFkIGFu
ZCB3cml0dGVuLCB3aXRoIHRoZXNlIGNoYW5nZXMgZm9yIGNvbW1vbg0KPiBzZGhjaSBmcmFtZXdv
cmsgYW5kIHNkaGNpLXNwcmQgZHJpdmVyLg0KPg0KPiBDaGFuZ2VzIGZyb20gVjQ6DQo+ICogQWRk
cmVzc2VkIEFkcmlhbidzIGNvbW1lbnRzOg0KPiAtIEVuYWJsZSB2NCBtb2RlIGluIF9fc2RoY2lf
cmVhZF9jYXBzKCkgYW5kIHNkaGNpX2luaXQoKSBpbnN0ZWFkIG9mIHNkaGNpX2RvX3Jlc2V0KCk7
DQo+IC0gTW92ZSB0aGUgYWRkZWQgbWVtYmVyICd2NF9tb2RlJyB0byBmb2xsb3dpbmcgd2l0aCBv
dGhlciBib29sczsNCj4gLSBBZGQgbW9yZSBjb21tZW50cyBpbiB0aGUgYWRkZWQgZnVuY3Rpb24g
c2RoY2lfY29uZmlnX2RtYSgpOw0KPiAtIEluc3RlYWQgb2YgZW5hYmxpbmcgYXV0by1DTUQyMyBp
biBpbml0LCBlbmFibGVkIGl0IG9ubHkgaWYgcmVjZWl2aW5nIHNiYyBmcm9tDQo+ICAgY2FyZHMg
YW5kIHRoZSBhcmd1bWVudCBpcyBzdWl0YWJsZSBmb3IgaG9zdCB0byBkZWFsIHdpdGg7DQo+IC0g
TWFrZSB0aGUgYWRkaXRpb24gb2YgdGhlIFNESENJX1NQRUNfNHh4IGRlZmluZXMgYSBzZXBhcmF0
ZSBwYXRjaDsNCj4gLSBEaXNhYmxlIGF1dG8tQ01EMjMgaWYgc3R1ZmYgYml0cyBpcyBzZXQgaW4g
dGhlIGFyZ3VtZW50IG9mIENNRDIzIGluIHNkaGNpX3JlcXVlc3QoKS4NCj4NCj4gKiBGb3IgVjQg
bW9kZSwgU0RNQSBhbHNvIGNhbiB1c2UgYXV0by1DTUQyMywgYWRqdXN0ZWQgaG9zdC0+ZmxhZ3Mg
aW4gc2RoY2lfc2V0dXBfaG9zdCgpLg0KPg0KPiBQcmV2aW91cyBwYXRjaCBzZXJpZXM6DQo+IHY0
OiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC83LzIzLzI2OQ0KPiB2MzogaHR0cHM6Ly9sa21s
Lm9yZy9sa21sLzIwMTgvNy84LzIzOQ0KPiB2MjogaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgv
Ni8xNC85MzYNCj4gdjE6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzYvOC8xMDgNCj4NCj4g
Q2h1bnlhbiBaaGFuZyAoMTApOg0KPiAgIG1tYzogc2RoY2k6IEFkZCB2ZXJzaW9uIFY0IGRlZmlu
aXRpb24NCj4gICBtbWM6IHNkaGNpOiBBZGQgc2QgaG9zdCB2NCBtb2RlDQo+ICAgbW1jOiBzZGhj
aTogQ2hhbmdlIFNETUEgYWRkcmVzcyByZWdpc3RlciBmb3IgdjQgbW9kZQ0KPiAgIG1tYzogc2Ro
Y2k6IEFkZCBBRE1BMiA2NC1iaXQgYWRkcmVzc2luZyBzdXBwb3J0IGZvciBWNCBtb2RlDQo+ICAg
bW1jOiBzZGhjaTogQWRkIDMyLWJpdCBibG9jayBjb3VudCBzdXBwb3J0IGZvciB2NCBtb2RlDQo+
ICAgbW1jOiBzZGhjaTogRGlzYWJsZSBhdXRvLUNNRDIzIGlmIHN0dWZmIGJpdHMgaXMgc2V0IGlu
IENNRDIzIGFyZ3VtZW50DQo+ICAgbW1jOiBzZGhjaTogQWRkIEF1dG8gQ01EIEF1dG8gU2VsZWN0
IHN1cHBvcnQNCj4gICBtbWM6IHNkaGNpOiBTRE1BIG1heSB1c2UgQXV0by1DTUQyMyBpbiB2NCBt
b2RlDQo+ICAgbW1jOiBzZGhjaS1zcHJkOiBBZGQgU3ByZWFkdHJ1bSdzIGluaXRpYWwgaG9zdCBj
b250cm9sbGVyDQo+ICAgZHQtYmluZGluZ3M6IHNkaGNpLXNwcmQ6IEFkZCBiaW5kaW5ncyBmb3Ig
dGhlIHNkaGNpLXNwcmQgY29udHJvbGxlcg0KPg0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
bW1jL3NkaGNpLXNwcmQudHh0ICAgICAgICAgfCAgNDEgKysNCj4gIGRyaXZlcnMvbW1jL2hvc3Qv
S2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEzICsNCj4gIGRyaXZlcnMvbW1j
L2hvc3QvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gIGRyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktc3ByZC5jICAgICAgICAgICAgICAgICAgICAgIHwgNDY0ICsrKysr
KysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAyNTEgKysrKysrKystLS0NCj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2kuaCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIyICstDQo+ICA2IGZpbGVzIGNoYW5n
ZWQsIDc0MSBpbnNlcnRpb25zKCspLCA1MSBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3NkaGNpLXNwcmQudHh0
DQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1zcHJkLmMNCj4N
Cj4gLS0NCj4gMi43LjQNCj4NCg==
