Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C181C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CB621903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389892AbeLURGx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:06:53 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49046 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732195AbeLURGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:06:52 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 10C2314A9936B;
        Fri, 21 Dec 2018 09:06:52 -0800 (PST)
Date:   Fri, 21 Dec 2018 09:06:51 -0800 (PST)
Message-Id: <20181221.090651.1241372602429144964.davem@davemloft.net>
To:     linus.luessing@c0d3.blue
Cc:     netdev@vger.kernel.org, roopa@cumulusnetworks.com,
        nikolay@cumulusnetworks.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, bridge@lists.linux-foundation.org,
        b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] bridge: implement Multicast Router
 Discovery (RFC4286)
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181221151511.14923-1-linus.luessing@c0d3.blue>
References: <20181221151511.14923-1-linus.luessing@c0d3.blue>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 21 Dec 2018 09:06:52 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Lüssing <linus.luessing@c0d3.blue>
Date: Fri, 21 Dec 2018 16:15:07 +0100

> This patchset adds initial Multicast Router Discovery support to
> the Linux bridge (RFC4286). With MRD it is possible to detect multicast
> routers and mark bridge ports and forward multicast packets to such routers
> accordingly.
 ...

The net-next tree is currently closed, please resubmit this when it opens
back up again.

Thank you.
