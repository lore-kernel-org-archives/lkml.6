Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3811DC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01ABC2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfAWRIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:08:07 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47008 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfAWRIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:08:04 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7DD9D14ECF0EB;
        Wed, 23 Jan 2019 09:08:03 -0800 (PST)
Date:   Wed, 23 Jan 2019 09:08:03 -0800 (PST)
Message-Id: <20190123.090803.438719975498577995.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     tariqt@mellanox.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx4: Mark expected switch fall-through
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190123080511.GA32528@embeddedor>
References: <20190123080511.GA32528@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 23 Jan 2019 09:08:03 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIkd1c3Rhdm8gQS4gUi4gU2lsdmEiIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPg0KRGF0
ZTogV2VkLCAyMyBKYW4gMjAxOSAwMjowNToxMSAtMDYwMA0KDQo+IEluIHByZXBhcmF0aW9uIHRv
IGVuYWJsaW5nIC1XaW1wbGljaXQtZmFsbHRocm91Z2gsIG1hcmsgc3dpdGNoIGNhc2VzDQo+IHdo
ZXJlIHdlIGFyZSBleHBlY3RpbmcgdG8gZmFsbCB0aHJvdWdoLg0KPiANCj4gVGhpcyBwYXRjaCBm
aXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmc6DQo+IA0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9t
ZWxsYW5veC9tbHg0L2VxLmM6IEluIGZ1bmN0aW9uIKFtbHg0X2VxX2ludKI6DQo+IGRyaXZlcnMv
bmV0L2V0aGVybmV0L21lbGxhbm94L21seDQvbWx4NC5oOjIxOTo1OiB3YXJuaW5nOiB0aGlzIHN0
YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0NCj4gICBp
ZiAobWx4NF9kZWJ1Z19sZXZlbCkgICAgICBcDQo+ICAgICAgXg0KPiBkcml2ZXJzL25ldC9ldGhl
cm5ldC9tZWxsYW5veC9tbHg0L2VxLmM6NTU4OjQ6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNy
byChbWx4NF9kYmeiDQo+ICAgICBtbHg0X2RiZyhkZXYsICIlczogTUxYNF9FVkVOVF9UWVBFX1NS
UV9MSU1JVC4gc3JxX25vPTB4JXgsIGVxIDB4JXhcbiIsDQo+ICAgICBefn5+fn5+fg0KPiBkcml2
ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg0L2VxLmM6NTYxOjM6IG5vdGU6IGhlcmUNCj4g
ICAgY2FzZSBNTFg0X0VWRU5UX1RZUEVfU1JRX0NBVEFTX0VSUk9SOg0KPiAgICBefn5+DQo+IA0K
PiBXYXJuaW5nIGxldmVsIDMgd2FzIHVzZWQ6IC1XaW1wbGljaXQtZmFsbHRocm91Z2g9Mw0KPiAN
Cj4gVGhpcyBwYXRjaCBpcyBwYXJ0IG9mIHRoZSBvbmdvaW5nIGVmZm9ydHMgdG8gZW5hYmxpbmcN
Cj4gLVdpbXBsaWNpdC1mYWxsdGhyb3VnaC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8g
QS4gUi4gU2lsdmEgPGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+DQoNCkFwcGxpZWQuDQo=
