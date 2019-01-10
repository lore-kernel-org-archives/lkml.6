Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D76C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3C6206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfAJICI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:02:08 -0500
Received: from mx.socionext.com ([202.248.49.38]:22696 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfAJICI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:02:08 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 10 Jan 2019 17:02:05 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 61CF660062;
        Thu, 10 Jan 2019 17:02:05 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Thu, 10 Jan 2019 17:02:05 +0900
Received: from SOC-EX01V.e01.socionext.com (10.213.24.21) by
 SOC-EX02V.e01.socionext.com (10.213.24.22) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Thu, 10 Jan 2019 17:01:53 +0900
Received: from SOC-EX01V.e01.socionext.com ([10.213.24.21]) by
 SOC-EX01V.e01.socionext.com ([10.213.24.21]) with mapi id 15.00.0995.028;
 Thu, 10 Jan 2019 17:01:53 +0900
From:   <yamada.masahiro@socionext.com>
To:     <robh@kernel.org>, <arm@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <afaerber@suse.de>, <manivannan.sadhasivam@linaro.org>,
        <tsahee@annapurnalabs.com>, <antoine.tenart@bootlin.com>,
        <maxime.ripard@bootlin.com>, <wens@csie.org>,
        <dinguyen@kernel.org>, <khilman@baylibre.com>, <dhdang@apm.com>,
        <liviu.dudau@arm.com>, <sudeep.holla@arm.com>,
        <lorenzo.pieralisi@arm.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <rrichter@cavium.com>, <jnair@caviumnetworks.com>,
        <kgene@kernel.org>, <krzk@kernel.org>, <xuwei5@hisilicon.com>,
        <chanho.min@lge.com>, <jason@lakedaemon.net>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <matthias.bgg@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andy.gross@linaro.org>,
        <david.brown@linaro.org>, <horms@verge.net.au>,
        <magnus.damm@gmail.com>, <heiko@sntech.de>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        <Jisheng.Zhang@synaptics.com>, <t-kristo@ti.com>, <nm@ti.com>,
        <jun.nie@linaro.org>, <shawnguo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>, <mark.rutland@arm.com>,
        <will.deacon@arm.com>, <michal.simek@xilinx.com>
Subject: RE: [PATCH] arm64: dts: Remove inconsistent use of 'arm,armv8'
 compatible string
Thread-Topic: [PATCH] arm64: dts: Remove inconsistent use of 'arm,armv8'
 compatible string
Thread-Index: AQHUqFoPwZlgCUSeDkSxOmzH7nYu1aWoIxIA
Date:   Thu, 10 Jan 2019 08:01:52 +0000
Message-ID: <8e2a312104924025ad4d37afa40d147d@SOC-EX01V.e01.socionext.com>
References: <20190109202934.29304-1-robh@kernel.org>
In-Reply-To: <20190109202934.29304-1-robh@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: POLICY180220
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgW21h
aWx0bzpyb2JoQGtlcm5lbC5vcmddDQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDEwLCAyMDE5
IDU6MzAgQU0NCj4gVG86IGFybUBrZXJuZWwub3JnDQo+IENjOiBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW5kcmVhcw0KPiBGw6RyYmVy
IDxhZmFlcmJlckBzdXNlLmRlPjsgTWFuaXZhbm5hbiBTYWRoYXNpdmFtDQo+IDxtYW5pdmFubmFu
LnNhZGhhc2l2YW1AbGluYXJvLm9yZz47IFRzYWhlZSBaaWRlbmJlcmcNCj4gPHRzYWhlZUBhbm5h
cHVybmFsYWJzLmNvbT47IEFudG9pbmUgVGVuYXJ0IDxhbnRvaW5lLnRlbmFydEBib290bGluLmNv
bT47DQo+IE1heGltZSBSaXBhcmQgPG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb20+OyBDaGVuLVl1
IFRzYWkgPHdlbnNAY3NpZS5vcmc+Ow0KPiBEaW5oIE5ndXllbiA8ZGluZ3V5ZW5Aa2VybmVsLm9y
Zz47IEtldmluIEhpbG1hbiA8a2hpbG1hbkBiYXlsaWJyZS5jb20+Ow0KPiBEdWMgRGFuZyA8ZGhk
YW5nQGFwbS5jb20+OyBMaXZpdSBEdWRhdSA8bGl2aXUuZHVkYXVAYXJtLmNvbT47IFN1ZGVlcCBI
b2xsYQ0KPiA8c3VkZWVwLmhvbGxhQGFybS5jb20+OyBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56
by5waWVyYWxpc2lAYXJtLmNvbT47DQo+IFJheSBKdWkgPHJqdWlAYnJvYWRjb20uY29tPjsgU2Nv
dHQgQnJhbmRlbiA8c2JyYW5kZW5AYnJvYWRjb20uY29tPjsNCj4gYmNtLWtlcm5lbC1mZWVkYmFj
ay1saXN0QGJyb2FkY29tLmNvbTsgUm9iZXJ0IFJpY2h0ZXINCj4gPHJyaWNodGVyQGNhdml1bS5j
b20+OyBKYXlhY2hhbmRyYW4gQyA8am5haXJAY2F2aXVtbmV0d29ya3MuY29tPjsgS3VramluDQo+
IEtpbSA8a2dlbmVAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVs
Lm9yZz47IFdlaSBYdQ0KPiA8eHV3ZWk1QGhpc2lsaWNvbi5jb20+OyBDaGFuaG8gTWluIDxjaGFu
aG8ubWluQGxnZS5jb20+OyBKYXNvbiBDb29wZXINCj4gPGphc29uQGxha2VkYWVtb24ubmV0Pjsg
QW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPjsgR3JlZ29yeSBDbGVtZW50DQo+IDxncmVnb3J5
LmNsZW1lbnRAYm9vdGxpbi5jb20+OyBTZWJhc3RpYW4gSGVzc2VsYmFydGgNCj4gPHNlYmFzdGlh
bi5oZXNzZWxiYXJ0aEBnbWFpbC5jb20+OyBNYXR0aGlhcyBCcnVnZ2VyDQo+IDxtYXR0aGlhcy5i
Z2dAZ21haWwuY29tPjsgVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT47
DQo+IEpvbmF0aGFuIEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5jb20+OyBBbmR5IEdyb3NzDQo+
IDxhbmR5Lmdyb3NzQGxpbmFyby5vcmc+OyBEYXZpZCBCcm93biA8ZGF2aWQuYnJvd25AbGluYXJv
Lm9yZz47IFNpbW9uDQo+IEhvcm1hbiA8aG9ybXNAdmVyZ2UubmV0LmF1PjsgTWFnbnVzIERhbW0g
PG1hZ251cy5kYW1tQGdtYWlsLmNvbT47IEhlaWtvDQo+IFN0dWVibmVyIDxoZWlrb0BzbnRlY2gu
ZGU+OyBZYW1hZGEsIE1hc2FoaXJvL+WxseeUsCDnnJ/lvJgNCj4gPHlhbWFkYS5tYXNhaGlyb0Bz
b2Npb25leHQuY29tPjsgT3Jzb24gWmhhaSA8b3Jzb256aGFpQGdtYWlsLmNvbT47DQo+IEJhb2xp
biBXYW5nIDxiYW9saW4ud2FuZ0BsaW5hcm8ub3JnPjsgQ2h1bnlhbiBaaGFuZw0KPiA8emhhbmcu
bHlyYUBnbWFpbC5jb20+OyBKaXNoZW5nIFpoYW5nIDxKaXNoZW5nLlpoYW5nQHN5bmFwdGljcy5j
b20+Ow0KPiBUZXJvIEtyaXN0byA8dC1rcmlzdG9AdGkuY29tPjsgTmlzaGFudGggTWVub24gPG5t
QHRpLmNvbT47IEp1biBOaWUNCj4gPGp1bi5uaWVAbGluYXJvLm9yZz47IFNoYXduIEd1byA8c2hh
d25ndW9Aa2VybmVsLm9yZz47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsNCj4gbGludXgtYW1sb2dpY0BsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1zYW1zdW5nLXNv
Y0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LXRlZ3JhQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLW1zbUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LXJlbmVzYXMtc29jQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtcm9ja2No
aXBAbGlzdHMuaW5mcmFkZWFkLm9yZzsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNv
bT47DQo+IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPjsgTWljaGFsIFNpbWVrIDxt
aWNoYWwuc2ltZWtAeGlsaW54LmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBhcm02NDogZHRzOiBS
ZW1vdmUgaW5jb25zaXN0ZW50IHVzZSBvZiAnYXJtLGFybXY4Jw0KPiBjb21wYXRpYmxlIHN0cmlu
Zw0KPiANCj4gVGhlICdhcm0sYXJtdjgnIGNvbXBhdGlibGUgc3RyaW5nIGlzIG9ubHkgZm9yIHNv
ZnR3YXJlIG1vZGVscy4gSXQgYWRkcw0KPiBsaXR0bGUgdmFsdWUgb3RoZXJ3aXNlIGFuZCBpcyBp
bmNvbnNpc3RlbnRseSB1c2VkIGFzIGEgZmFsbGJhY2sgb24gc29tZQ0KPiBwbGF0Zm9ybXMuIFJl
bW92ZSBpdCBmcm9tIHRob3NlIHBsYXRmb3Jtcy4NCj4gDQo+IFRoaXMgZml4ZXMgd2FybmluZ3Mg
Z2VuZXJhdGVkIGJ5IHRoZSBEVCBzY2hlbWEuDQo+IA0KPiBSZXBvcnRlZC1ieTogTWljaGFsIFNp
bWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT4NCj4gQ2M6IE1hcmsgUnV0bGFuZCA8bWFyay5y
dXRsYW5kQGFybS5jb20+DQo+IENjOiBXaWxsIERlYWNvbiA8d2lsbC5kZWFjb25AYXJtLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gLS0tDQo+
IGFybXNvYyBmb2xrcywgUGxlYXNlIGFwcGx5IGRpcmVjdGx5Lg0KPiANCj4gTm90ZSB0aGF0IHRo
ZXJlJ3Mgc3RpbGwgYSBjYXNlIGxlZnQgaW4gbXNtODk5OCB0aGF0IG5lZWRzIGEgbmV3DQo+IGNv
bXBhdGlibGUgc3RyaW5nLg0KPiANCj4gUm9iDQoNCls+IF0gDQoNCj4gIC4uLi9ib290L2R0cy9z
b2Npb25leHQvdW5pcGhpZXItbGQxMS5kdHNpICAgICB8ICAgNCArLQ0KPiAgLi4uL2Jvb3QvZHRz
L3NvY2lvbmV4dC91bmlwaGllci1sZDIwLmR0c2kgICAgIHwgICA4ICstDQo+ICAuLi4vYm9vdC9k
dHMvc29jaW9uZXh0L3VuaXBoaWVyLXB4czMuZHRzaSAgICAgfCAgIDggKy0NCg0KDQpGb3IgdW5p
cGhpZXIsDQoNCkFja2VkLWJ5OiBNYXNhaGlybyBZYW1hZGEgPHlhbWFkYS5tYXNhaGlyb0Bzb2Np
b25leHQuY29tPg0KDQoNCkJUVywgZG8geW91IGhhdmUgYSBwbGFuIHRvIGZpeCBmaWxlcyB1bmRl
cg0KRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzLyA/DQoNCg==
