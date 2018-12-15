Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B494C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A75206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbeLOTWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 14:22:00 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53794 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeLOTV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 14:21:58 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 226BF14E89C6C;
        Sat, 15 Dec 2018 11:21:58 -0800 (PST)
Date:   Sat, 15 Dec 2018 11:21:57 -0800 (PST)
Message-Id: <20181215.112157.1319304722578848217.davem@davemloft.net>
To:     tiny.windzz@gmail.com
Cc:     ganeshgr@chelsio.com, leedom@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxgb4: remove DEFINE_SIMPLE_DEBUGFS_FILE()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181215075930.26316-1-tiny.windzz@gmail.com>
References: <20181215075930.26316-1-tiny.windzz@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 15 Dec 2018 11:21:58 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>
Date: Sat, 15 Dec 2018 02:59:30 -0500

> We already have the DEFINE_SHOW_ATTRIBUTE. There is no need to define
> such a macro, so remove DEFINE_SIMPLE_DEBUGFS_FILE. Also use the
> DEFINE_SHOW_ATTRIBUTE macro to simplify some code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied.
