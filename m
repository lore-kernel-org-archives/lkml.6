Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4176C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A672075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfBVXW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:22:27 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59756 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:22:26 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6CB3014AD9201;
        Fri, 22 Feb 2019 15:22:26 -0800 (PST)
Date:   Fri, 22 Feb 2019 15:22:26 -0800 (PST)
Message-Id: <20190222.152226.1935918245873046733.davem@davemloft.net>
To:     kalash@arista.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables >
 255
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190221002304.GA24732@us178.sjc.aristanetworks.com>
References: <20190221002304.GA24732@us178.sjc.aristanetworks.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 Feb 2019 15:22:26 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kalash Nainwal <kalash@arista.com>
Date: Wed, 20 Feb 2019 16:23:04 -0800

> Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255 to
> keep legacy software happy. This is similar to what was done for
> ipv4 in commit 709772e6e065 ("net: Fix routing tables with
> id > 255 for legacy software").
> 
> Signed-off-by: Kalash Nainwal <kalash@arista.com>

Applied and queued up for -stable.
