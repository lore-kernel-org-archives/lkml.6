Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB96C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929ED20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbfAPWN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:13:59 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45562 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732666AbfAPWN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:13:59 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 84B5712690F72;
        Wed, 16 Jan 2019 14:13:58 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:13:57 -0800 (PST)
Message-Id: <20190116.141357.190931605071987791.davem@davemloft.net>
To:     sfr@canb.auug.org.au
Cc:     netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, ytht.net@gmail.com,
        stefanha@redhat.com
Subject: Re: linux-next: Signed-off-by missing for commit in the net-next
 tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190117080619.5a632a41@canb.auug.org.au>
References: <20190117080619.5a632a41@canb.auug.org.au>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 16 Jan 2019 14:13:58 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 17 Jan 2019 08:06:19 +1100

> Hi all,
> 
> Commit
> 
>   a22d3251423f ("Fix ERROR:do not initialise statics to 0 in af_vsock.c")
> 
> is missing a Signed-off-by from its author.

I know, I caught it right after I pushed out, sorry :(

I really have to go back to working on that automation so this stops
happening.  My bad.
