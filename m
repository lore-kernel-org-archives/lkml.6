Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73A5C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC472147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfBDE2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 23:28:02 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46886 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfBDE2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 23:28:02 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6E3EF14E05BF1;
        Sun,  3 Feb 2019 20:28:01 -0800 (PST)
Date:   Sun, 03 Feb 2019 20:28:00 -0800 (PST)
Message-Id: <20190203.202800.108022659263277392.davem@davemloft.net>
To:     joe@perches.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdevice.h: Add __cold to netdev_<level> logging
 functions
From:   David Miller <davem@davemloft.net>
In-Reply-To: <bf397da97e7ed127a838126bb6600a82d63f32f9.camel@perches.com>
References: <bf397da97e7ed127a838126bb6600a82d63f32f9.camel@perches.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 Feb 2019 20:28:01 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Sat, 02 Feb 2019 19:47:25 -0800

> Add __cold to the netdev_<level> logging functions similar to
> the use of __cold in the generic printk function.
> 
> Using __cold moves all the netdev_<level> logging functions
> out-of-line possibly improving code locality and runtime
> performance.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Sure, let's give this a try.

I'll push this out to net-next when my build testing completes.

Thanks.
