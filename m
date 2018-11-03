Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CE8C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D5B2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D5B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeKCPoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 11:44:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46130 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKCPoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 11:44:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E204114525CCC;
        Fri,  2 Nov 2018 23:33:57 -0700 (PDT)
Date:   Fri, 02 Nov 2018 23:33:57 -0700 (PDT)
Message-Id: <20181102.233357.1129560140046922258.davem@davemloft.net>
To:     malat@debian.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: move
 =?iso-8859-7?B?oV9femVyb2NvcHlfc2dfZnJvbV9pdGVyog==?= prototype to header
 file <linux/skbuff.h>
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181031113500.3763-1-malat@debian.org>
References: <20181031113500.3763-1-malat@debian.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 02 Nov 2018 23:33:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWF0aGlldSBNYWxhdGVycmUgPG1hbGF0QGRlYmlhbi5vcmc+DQpEYXRlOiBXZWQsIDMx
IE9jdCAyMDE4IDEyOjM0OjU5ICswMTAwDQoNCj4gVGhpcyBtYWtlcyBpdCBjbGVhciB0aGUgZnVu
Y3Rpb24gaXMgcGFydCBvZiB0aGUgQVBJLiBBbHNvIHRoaXMgd2lsbA0KPiByZW1vdmUgYSB3YXJu
aW5nIHRyaWdnZXJlZCBhdCBXPTE6DQo+IA0KPiAgIG5ldC9jb3JlL2RhdGFncmFtLmM6NTgxOjU6
IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3IgoV9femVyb2NvcHlfc2dfZnJvbV9p
dGVyoiBbLVdtaXNzaW5nLXByb3RvdHlwZXNdDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1
IE1hbGF0ZXJyZSA8bWFsYXRAZGViaWFuLm9yZz4NCg0KSXQncyBub3QgcGFydCBvZiB0aGUgIkFQ
SSIsIGFuZCBpdCBzaG91bGRuJ3QgZXZlbiBiZSBleHBvcnRlZCB0bw0KbW9kdWxlcy4NCg0KT25s
eSBuZXQvY29yZS9za2J1ZmYuYyBjYWxscyBpdCwgYW5kIHRoYXQgaXMgbmV2ZXIgbW9kdWxhci4N
Cg==
