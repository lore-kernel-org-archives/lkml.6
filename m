Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C781C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F32221872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfADUqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:46:30 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48480 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfADUqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:46:30 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4A1E414C2CC07;
        Fri,  4 Jan 2019 12:46:29 -0800 (PST)
Date:   Fri, 04 Jan 2019 12:46:26 -0800 (PST)
Message-Id: <20190104.124626.1177296586022194416.davem@davemloft.net>
To:     christophe.jaillet@wanadoo.fr
Cc:     sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] octeontx2-af: Fix a resource leak in an error handling
 path in 'cgx_probe()'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181229164222.15791-1-christophe.jaillet@wanadoo.fr>
References: <20181229164222.15791-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 04 Jan 2019 12:46:29 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sat, 29 Dec 2018 17:42:22 +0100

> If an error occurs after the call to 'pci_alloc_irq_vectors()', we must
> call 'pci_free_irq_vectors()' in order to avoid a	resource leak.
> 
> The same sequence is already in place in the corresponding 'cgx_remove()'
> function.
> 
> Fixes: 1463f382f58d ("octeontx2-af: Add support for CGX link management")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied and queued up for -stable.

Please fix the date and time on your computer, putting improper dates into
the email headers of your patch postings makes your patch appear out
of order in my patchwork queue.

Thank you.
