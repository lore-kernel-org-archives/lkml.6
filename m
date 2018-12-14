Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD30C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FE72086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbeLNWgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:36:33 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35634 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeLNWgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:36:32 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B824714E09825;
        Fri, 14 Dec 2018 14:36:31 -0800 (PST)
Date:   Fri, 14 Dec 2018 14:36:31 -0800 (PST)
Message-Id: <20181214.143631.1081032057703599919.davem@davemloft.net>
To:     salil.mehta@huawei.com
Cc:     yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH net-next 0/6] net: hns3: Add more commands to Debugfs
 in HNS3 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181214.143046.597375776514311090.davem@davemloft.net>
References: <20181211171330.20592-1-salil.mehta@huawei.com>
        <20181214.143046.597375776514311090.davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Dec 2018 14:36:32 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGF2aWQgTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KRGF0ZTogRnJpLCAxNCBE
ZWMgMjAxOCAxNDozMDo0NiAtMDgwMCAoUFNUKQ0KDQo+IEZyb206IFNhbGlsIE1laHRhIDxzYWxp
bC5tZWh0YUBodWF3ZWkuY29tPg0KPiBEYXRlOiBUdWUsIDExIERlYyAyMDE4IDE3OjEzOjI0ICsw
MDAwDQo+IA0KPj4gVGhpcyBwYXRjaC1zZXQgYWRkcyBmZXcgbW9yZSBkZWJ1Z2ZzIGNvbW1hbmRz
IHRvIEhOUzMgRXRoZXJuZXQNCj4+IERyaXZlci4gU3VwcG9ydCBoYXMgYmVlbiBhZGRlZCB0byBx
dWVyeSBpbmZvIHJlbGF0ZWQgdG8gYmVsb3cNCj4+IGl0ZW1zOg0KPj4gMS4gUGFja2V0IGJ1ZmZl
ciBkZXNjcmlwdG9yICgiZWNobyBiZCBpbmZvIFtxdWV1ZSBub10gW2JkIGluZGV4XSA+IGNtZCIp
DQo+PiAyLiBNYW5hZ2VyIHRhYmxlKCJlY2hvIGR1bXAgbW5nIHRibCA+IGNtZCIpDQo+PiAzLiBE
Znggc3RhdHVzIHJlZ2lzdGVyKCJlY2hvIGR1bXAgcmVnIHNzdSBbcHJ0IGlkXSA+IGNtZCIpDQo+
PiA0LiBEY2Igc3RhdHVzIHJlZ2lzdGVyKCJlY2hvIGR1bXAgcmVnIGRjYiBbcG9ydCBpZF0gPiBj
bWQiKQ0KPj4gNS4gUXVldWUgbWFwICgiZWNobyBxdWV1ZSBtYXAgW3F1ZXVlIG5vXSA+IGNtZCIp
DQo+PiA2LiBUbSBtYXAgKCJlY2hvIHRtIG1hcCBbcXVldWUgbm9dID4gY21kIikNCj4+IA0KPj4g
Tk9URTogQWJvdmUgY29tbWFuZHMgYXJlICpyZWFkLW9ubHkqIGFuZCBhcmUgb25seSBpbnRlbmRl
ZCB0bw0KPj4gcXVlcnkgdGhlIGluZm9ybWF0aW9uIGZyb20gdGhlIFNvQyhhbmQgZHVtcCBpbnNp
ZGUgdGhlIGtlcm5lbCwNCj4+IGZvciBub3cpIGFuZCBpbiBubyB3YXkgdHJpZXMgdG8gcGVyZm9y
bSB3cml0ZSBvcGVyYXRpb25zIGZvcg0KPj4gdGhlIHB1cnBvc2Ugb2YgY29uZmlndXJhdGlvbiBl
dGMuDQo+IA0KPiBTZXJpZXMgYXBwbGllZC4NCg0KQWN0dWFsbHksIHJldmVydGVkLg0KDQpQbGVh
c2UgZml4IHRoZXNlIHdhcm5pbmdzIGFuZCByZXN1Ym1pdCAod2l0aCBnY2MgdmVyc2lvbg0KImdj
YyAoR0NDKSA4LjIuMSAyMDE4MTEwNSAoUmVkIEhhdCA4LjIuMS01KSIpOg0KDQpJbiBmaWxlIGlu
Y2x1ZGVkIGZyb20gLi9pbmNsdWRlL2xpbnV4L2JpdG1hcC5oOjksDQogICAgICAgICAgICAgICAg
IGZyb20gLi9pbmNsdWRlL2xpbnV4L2NwdW1hc2suaDoxMiwNCiAgICAgICAgICAgICAgICAgZnJv
bSAuL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdW1hc2suaDo1LA0KICAgICAgICAgICAgICAgICBm
cm9tIC4vYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLmg6MTEsDQogICAgICAgICAgICAgICAgIGZy
b20gLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcm9jZXNzb3IuaDoyMSwNCiAgICAgICAgICAgICAg
ICAgZnJvbSAuL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmUuaDo4LA0KICAgICAgICAg
ICAgICAgICBmcm9tIC4vYXJjaC94ODYvaW5jbHVkZS9hc20vdGhyZWFkX2luZm8uaDo1MywNCiAg
ICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvdGhyZWFkX2luZm8uaDozOCwNCiAg
ICAgICAgICAgICAgICAgZnJvbSAuL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ByZWVtcHQuaDo3LA0K
ICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9wcmVlbXB0Lmg6ODEsDQogICAg
ICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3NwaW5sb2NrLmg6NTEsDQogICAgICAg
ICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3dhaXQuaDo5LA0KICAgICAgICAgICAgICAg
ICBmcm9tIC4vaW5jbHVkZS9saW51eC93YWl0X2JpdC5oOjgsDQogICAgICAgICAgICAgICAgIGZy
b20gLi9pbmNsdWRlL2xpbnV4L2ZzLmg6NiwNCiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1
ZGUvbGludXgvZGVidWdmcy5oOjE1LA0KICAgICAgICAgICAgICAgICBmcm9tIGRyaXZlcnMvbmV0
L2V0aGVybmV0L2hpc2lsaWNvbi9obnMzL2huczNfZGVidWdmcy5jOjQ6DQpJbiBmdW5jdGlvbiCh
c3RybmNhdKIsDQogICAgaW5saW5lZCBmcm9tIKFobnMzX2RiZ19oZWxwoiBhdCBkcml2ZXJzL25l
dC9ldGhlcm5ldC9oaXNpbGljb24vaG5zMy9obnMzX2RlYnVnZnMuYzoyNjM6MjoNCi4vaW5jbHVk
ZS9saW51eC9zdHJpbmcuaDozMjA6MTA6IHdhcm5pbmc6IKFfX2J1aWx0aW5fc3RybmNhdKIgc3Bl
Y2lmaWVkIGJvdW5kIDI1NiBlcXVhbHMgZGVzdGluYXRpb24gc2l6ZSBbLVdzdHJpbmdvcC1vdmVy
Zmxvdz1dDQogICByZXR1cm4gX19idWlsdGluX3N0cm5jYXQocCwgcSwgY291bnQpOw0KICAgICAg
ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KSW4gZnVuY3Rpb24goXN0cm5jYXSi
LA0KICAgIGlubGluZWQgZnJvbSChaG5zM19kYmdfaGVscKIgYXQgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaGlzaWxpY29uL2huczMvaG5zM19kZWJ1Z2ZzLmM6MjUyOjI6DQouL2luY2x1ZGUvbGludXgv
c3RyaW5nLmg6MzIwOjEwOiB3YXJuaW5nOiChX19idWlsdGluX3N0cm5jYXSiIHNwZWNpZmllZCBi
b3VuZCAyNTYgZXF1YWxzIGRlc3RpbmF0aW9uIHNpemUgWy1Xc3RyaW5nb3Atb3ZlcmZsb3c9XQ0K
ICAgcmV0dXJuIF9fYnVpbHRpbl9zdHJuY2F0KHAsIHEsIGNvdW50KTsNCiAgICAgICAgICBefn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAuL2luY2x1
ZGUvbGludXgvYml0bWFwLmg6OSwNCiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGlu
dXgvY3B1bWFzay5oOjEyLA0KICAgICAgICAgICAgICAgICBmcm9tIC4vYXJjaC94ODYvaW5jbHVk
ZS9hc20vY3B1bWFzay5oOjUsDQogICAgICAgICAgICAgICAgIGZyb20gLi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9tc3IuaDoxMSwNCiAgICAgICAgICAgICAgICAgZnJvbSAuL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3Byb2Nlc3Nvci5oOjIxLA0KICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9s
aW51eC9tdXRleC5oOjE5LA0KICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9r
ZXJuZnMuaDoxMywNCiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvc3lzZnMu
aDoxNiwNCiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgva29iamVjdC5oOjIw
LA0KICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9kZXZpY2UuaDoxNiwNCiAg
ICAgICAgICAgICAgICAgZnJvbSBkcml2ZXJzL25ldC9ldGhlcm5ldC9oaXNpbGljb24vaG5zMy9o
bnMzcGYvaGNsZ2VfZGVidWdmcy5jOjQ6DQpJbiBmdW5jdGlvbiChc3RybmNhdKIsDQogICAgaW5s
aW5lZCBmcm9tIKFoY2xnZV9kYmdfZHVtcF9tbmdfdGFibGWiIGF0IGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2hpc2lsaWNvbi9obnMzL2huczNwZi9oY2xnZV9kZWJ1Z2ZzLmM6Nzk1OjI6DQouL2luY2x1
ZGUvbGludXgvc3RyaW5nLmg6MzIwOjEwOiB3YXJuaW5nOiChX19idWlsdGluX3N0cm5jYXSiIHNw
ZWNpZmllZCBib3VuZCAyNTYgZXF1YWxzIGRlc3RpbmF0aW9uIHNpemUgWy1Xc3RyaW5nb3Atb3Zl
cmZsb3c9XQ0KICAgcmV0dXJuIF9fYnVpbHRpbl9zdHJuY2F0KHAsIHEsIGNvdW50KTsNCiAgICAg
ICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCg==
