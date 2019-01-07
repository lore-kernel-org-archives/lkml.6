Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81468C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7C5206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfAGTXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:23:35 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60392 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfAGTXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:23:34 -0500
Received: from localhost (unknown [144.121.20.163])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BB0AE14C892F7;
        Mon,  7 Jan 2019 11:23:33 -0800 (PST)
Date:   Mon, 07 Jan 2019 11:23:29 -0800 (PST)
Message-Id: <20190107.112329.202441308657115890.davem@davemloft.net>
To:     jgg@mellanox.com
Cc:     grygorii.strashko@ti.com, kishon@ti.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] phy: ti: Fix compilation failures without REGMAP
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190107175407.GA5612@ziepe.ca>
References: <20190107175407.GA5612@ziepe.ca>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 07 Jan 2019 11:23:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPg0KRGF0ZTogTW9uLCA3IEph
biAyMDE5IDE3OjU0OjE0ICswMDAwDQoNCj4gVGhpcyBkcml2ZXIgcmVxdWlyZXMgcmVnbWFwIG9y
IHRoZSBjb21waWxlIGZhaWxzOg0KPiANCj4gZHJpdmVycy9waHkvdGkvcGh5LWdtaWktc2VsLmM6
NDM6Mjc6IGVycm9yOiBhcnJheSB0eXBlIGhhcyBpbmNvbXBsZXRlIGVsZW1lbnQgdHlwZSChc3Ry
dWN0IHJlZ19maWVsZKINCj4gICBjb25zdCBzdHJ1Y3QgcmVnX2ZpZWxkICgqcmVnZmllbGRzKVtQ
SFlfR01JSV9TRUxfTEFTVF07DQo+IA0KPiBBZGQgaXQgdG8ga2NvbmZpZy4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEphc29uIEd1bnRob3JwZSA8amdnQG1lbGxhbm94LmNvbT4NCg0KQXBwbGllZC4N
Cg==
