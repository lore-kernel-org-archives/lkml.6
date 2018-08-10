Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A5AC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C68622448
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C68622448
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeHJTxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:53:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54044 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeHJTxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:53:30 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 71BF51418A227;
        Fri, 10 Aug 2018 10:22:45 -0700 (PDT)
Date:   Fri, 10 Aug 2018 10:22:41 -0700 (PDT)
Message-Id: <20180810.102241.127503497869381092.davem@davemloft.net>
To:     krzk@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        avagin@gmail.com
Subject: Re: [PATCH] net: Provide stub for __netif_set_xps_queue if there
 is no CONFIG_XPS
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1533890863-32341-1-git-send-email-krzk@kernel.org>
References: <1533890863-32341-1-git-send-email-krzk@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 10 Aug 2018 10:22:45 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KRGF0ZTogRnJpLCAx
MCBBdWcgMjAxOCAxMDo0Nzo0MyArMDIwMA0KDQo+IEJ1aWxkaW5nIHZpcnRpb19uZXQgZHJpdmVy
IHdpdGhvdXQgQ09ORklHX1hQUyBmYWlscyB3aXRoOg0KPiANCj4gICAgIGRyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYzogSW4gZnVuY3Rpb24goXZpcnRuZXRfc2V0X2FmZmluaXR5ojoNCj4gICAgIGRy
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYzoxOTEwOjM6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlv
biBvZiBmdW5jdGlvbiChX19uZXRpZl9zZXRfeHBzX3F1ZXVloiBbLVdlcnJvcj1pbXBsaWNpdC1m
dW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gICAgICAgIF9fbmV0aWZfc2V0X3hwc19xdWV1ZSh2aS0+
ZGV2LCBtYXNrLCBpLCBmYWxzZSk7DQo+ICAgICAgICBeDQo+IEZpeGVzOiA0ZDk5ZjY2MDJjYjUg
KCJuZXQ6IGFsbG93IHRvIGNhbGwgbmV0aWZfcmVzZXRfeHBzX3F1ZXVlcygpIHVuZGVyIGNwdXNf
cmVhZF9sb2NrIikNCj4gU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0Br
ZXJuZWwub3JnPg0KDQpBcHBsaWVkLCB0aGFuayB5b3UuDQo=
