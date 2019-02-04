Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6565C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D452147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfBDEgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 23:36:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46958 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfBDEgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 23:36:36 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1C98614E07606;
        Sun,  3 Feb 2019 20:36:36 -0800 (PST)
Date:   Sun, 03 Feb 2019 20:36:35 -0800 (PST)
Message-Id: <20190203.203635.678182310282626016.davem@davemloft.net>
To:     sfr@canb.auug.org.au
Cc:     netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, deepa.kernel@gmail.com
Subject: Re: linux-next: build failure after merge of the net-next tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190204153446.03ffb5e4@canb.auug.org.au>
References: <20190204153446.03ffb5e4@canb.auug.org.au>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 Feb 2019 20:36:36 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 4 Feb 2019 15:34:46 +1100

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 4 Feb 2019 15:24:11 +1100
> Subject: [PATCH] socket: fix for Add SO_TIMESTAMP[NS]_NEW
> 
> Fixes: 887feae36aee ("socket: Add SO_TIMESTAMP[NS]_NEW")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks for fixing this.

Applied.
