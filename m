Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62A0C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 03:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB0920C01
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 03:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfA1Doq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 22:44:46 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40362 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfA1Doq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 22:44:46 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D62481496F05E;
        Sun, 27 Jan 2019 19:44:42 -0800 (PST)
Date:   Sun, 27 Jan 2019 19:44:40 -0800 (PST)
Message-Id: <20190127.194440.2287944704136477403.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     miquel.raynal@bootlin.com, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, antoine.tenart@bootlin.com,
        maxime.chevallier@bootlin.com, nadavh@marvell.com
Subject: Re: [PATCH net-next v2 0/2] mv88e6xxx DSA suspend to RAM support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190127214652.GB32046@lunn.ch>
References: <20190125095507.29334-1-miquel.raynal@bootlin.com>
        <20190127.132250.578158295862987283.davem@davemloft.net>
        <20190127214652.GB32046@lunn.ch>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 27 Jan 2019 19:44:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 27 Jan 2019 22:46:52 +0100

> I think you are replying to the wrong patch? This comment fits to
>
> https://www.spinics.net/lists/netdev/msg546662.html

I noticed that right after I hit send, you are right.

Sorry for the confusion.

> Although i don't like it, i think for the moment we are going to have
> to accept the proposed fix.

Indeed.
