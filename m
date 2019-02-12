Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C55EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089F7222B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbfBLVyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:54:07 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:58690 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732370AbfBLVyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:54:05 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7335E14C5F2F2;
        Tue, 12 Feb 2019 13:54:04 -0800 (PST)
Date:   Tue, 12 Feb 2019 13:54:01 -0800 (PST)
Message-Id: <20190212.135401.857430040745833995.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, jiri@resnulli.us,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rocker: Remove port_attr_bridge_flags_get
 assignment
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190212213905.26559-1-f.fainelli@gmail.com>
References: <20190212213905.26559-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Feb 2019 13:54:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQpEYXRlOiBUdWUs
IDEyIEZlYiAyMDE5IDEzOjM5OjA1IC0wODAwDQoNCj4gQWZ0ZXIgNjEwZDJiNjAxYmJhICgicm9j
a2VyOiBSZW1vdmUgZ2V0dGluZyBQT1JUX0JSSURHRV9GTEFHUyIpIHdlIG5vDQo+IGxvbmdlciBo
YXZlIGEgcG9ydF9hdHRyX2JyaWRnZV9mbGFnc19nZXQgbWVtYmVyIGluIHRoZSByb2NrZXJfd29y
bGRfb3BzDQo+IHN0cnVjdHJlLCBmaXggdGhhdC4NCj4gDQo+IEZpeGVzOiA2MTBkMmI2MDFiYmEg
KCJyb2NrZXI6IFJlbW92ZSBnZXR0aW5nIFBPUlRfQlJJREdFX0ZMQUdTIikNCj4gU2lnbmVkLW9m
Zi1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQoNCkFwcGxpZWQs
IEknbSBhbHNvIGdldHRpbmcgdGhpczoNCg0KZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gv
bWx4c3cvc3BlY3RydW1fc3dpdGNoZGV2LmM6IEluIGZ1bmN0aW9uIKFtbHhzd19zcF9wb3J0X2F0
dHJfZ2V0ojoNCmRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seHN3L3NwZWN0cnVtX3N3
aXRjaGRldi5jOjQzODoxOTogd2FybmluZzogdW51c2VkIHZhcmlhYmxlIKFtbHhzd19zcKIgWy1X
dW51c2VkLXZhcmlhYmxlXQ0KICBzdHJ1Y3QgbWx4c3dfc3AgKm1seHN3X3NwID0gbWx4c3dfc3Bf
cG9ydC0+bWx4c3dfc3A7DQogICAgICAgICAgICAgICAgICAgXn5+fn5+fn4NCg0KUmVsYXRlZD8N
Cg==
