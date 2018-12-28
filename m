Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DF9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE1F20856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeL1ATs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 19:19:48 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51890 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeL1ATs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 19:19:48 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7FE8014E09552;
        Thu, 27 Dec 2018 16:19:47 -0800 (PST)
Date:   Thu, 27 Dec 2018 16:19:47 -0800 (PST)
Message-Id: <20181227.161947.1406076950297831978.davem@davemloft.net>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, arjun@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: chelsio: Add a missing check on cudg_get_buffer
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181224212121.25596-1-pakki001@umn.edu>
References: <20181224212121.25596-1-pakki001@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 27 Dec 2018 16:19:47 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>
Date: Mon, 24 Dec 2018 15:21:21 -0600

> cudbg_collect_hw_sched() could fail when the function cudg_get_buffer()
> returns an error. The fix adds a check to the latter function returning
> error on failure
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Applied.
