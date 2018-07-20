Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6EAECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7137206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7137206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbeGTUC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:02:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53438 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388227AbeGTUC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:02:59 -0400
Received: from localhost (unknown [63.227.221.139])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F06D714735748;
        Fri, 20 Jul 2018 12:13:21 -0700 (PDT)
Date:   Fri, 20 Jul 2018 12:13:21 -0700 (PDT)
Message-Id: <20180720.121321.2077860831497547427.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     borisp@mellanox.com, aviadye@mellanox.com, davejwatson@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tls: Fix copy-paste error in tls_device_reencrypt
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180718132741.GA9480@embeddedor.com>
References: <20180718132741.GA9480@embeddedor.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 20 Jul 2018 12:13:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 18 Jul 2018 08:27:41 -0500

> It seems that the proper structure to use in this particular
> case is *skb_iter* instead of skb.
> 
> Addresses-Coverity-ID: 1471906 ("Copy-paste error")
> Fixes: 4799ac81e52a ("tls: Add rx inline crypto offload")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.
