Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB99C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B852E2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfBVTuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:50:24 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57148 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfBVTuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:50:24 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9FDE514A872FC;
        Fri, 22 Feb 2019 11:50:23 -0800 (PST)
Date:   Fri, 22 Feb 2019 11:50:23 -0800 (PST)
Message-Id: <20190222.115023.1085574898692218507.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH] isdn_common: Mark expected switch fall-throughs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190220202526.GA24484@embeddedor>
References: <20190220202526.GA24484@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 Feb 2019 11:50:23 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIkd1c3Rhdm8gQS4gUi4gU2lsdmEiIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KRGF0
ZTogV2VkLCAyMCBGZWIgMjAxOSAxNDoyNToyNiAtMDYwMA0KDQo+IEluIHByZXBhcmF0aW9uIHRv
IGVuYWJsaW5nIC1XaW1wbGljaXQtZmFsbHRocm91Z2gsIG1hcmsgc3dpdGNoDQo+IGNhc2VzIHdo
ZXJlIHdlIGFyZSBleHBlY3RpbmcgdG8gZmFsbCB0aHJvdWdoLg0KPiANCj4gVGhpcyBwYXRjaCBm
aXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmdzOg0KPiANCj4gZHJpdmVycy9pc2RuL2k0bC9pc2Ru
X2NvbW1vbi5jOiBJbiBmdW5jdGlvbiChaXNkbl93aWxkbWF0ojoNCj4gZHJpdmVycy9pc2RuL2k0
bC9pc2RuX2NvbW1vbi5jOjE3Mzo1OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0
aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0NCj4gICAgIHArKzsNCj4gICAgIH5efg0K
PiBkcml2ZXJzL2lzZG4vaTRsL2lzZG5fY29tbW9uLmM6MTc0OjM6IG5vdGU6IGhlcmUNCj4gICAg
ZGVmYXVsdDoNCj4gICAgXn5+fn5+fg0KPiAgIENDIFtNXSAgZHJpdmVycy9sZWRzL2xlZHMtbHA4
Nzg4Lm8NCj4gICBDQyBbTV0gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3Bvd2VycGxh
eS9zbXVtZ3Ivc211MTBfc211bWdyLm8NCj4gZHJpdmVycy9pc2RuL2k0bC9pc2RuX2NvbW1vbi5j
OiBJbiBmdW5jdGlvbiChaXNkbl9zdGF0dXNfY2FsbGJhY2uiOg0KPiBkcml2ZXJzL2lzZG4vaTRs
L2lzZG5fY29tbW9uLmM6NzI5OjY6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50IG1heSBmYWxsIHRo
cm91Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XQ0KPiAgICBpZiAoZGl2ZXJ0X2lmKQ0KPiAg
ICAgICBeDQo+IGRyaXZlcnMvaXNkbi9pNGwvaXNkbl9jb21tb24uYzo3MzI6Mjogbm90ZTogaGVy
ZQ0KPiAgIGRlZmF1bHQ6DQo+ICAgXn5+fn5+fg0KPiANCj4gV2FybmluZyBsZXZlbCAzIHdhcyB1
c2VkOiAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTMNCj4gDQo+IE5vdGljZSB0aGF0LCBpbiB0aGlz
IHBhcnRpY3VsYXIgY2FzZSwgdGhlIGNvZGUgY29tbWVudCBpcyBtb2RpZmllZA0KPiBpbiBhY2Nv
cmRhbmNlIHdpdGggd2hhdCBHQ0MgaXMgZXhwZWN0aW5nIHRvIGZpbmQuDQo+IA0KPiBUaGlzIHBh
dGNoIGlzIHBhcnQgb2YgdGhlIG9uZ29pbmcgZWZmb3J0cyB0byBlbmFibGUNCj4gLVdpbXBsaWNp
dC1mYWxsdGhyb3VnaC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEg
PGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+DQoNCkFwcGxpZWQuDQo=
