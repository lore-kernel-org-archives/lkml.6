Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BD0C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5BB217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbeLXSBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 13:01:24 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34978 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLXSBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 13:01:24 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4E8AC13407FA1;
        Mon, 24 Dec 2018 10:01:23 -0800 (PST)
Date:   Mon, 24 Dec 2018 10:01:22 -0800 (PST)
Message-Id: <20181224.100122.343912353497935720.davem@davemloft.net>
To:     leon@kernel.org
Cc:     fengguang.wu@intel.com, gavi@mellanox.com, kbuild-all@01.org,
        saeedm@mellanox.com, ogerlitz@mellanox.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: fix semicolon.cocci warnings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181223070613.GM3940@mtr-leonro.mtl.com>
References: <201812222032.13tR4nHr%fengguang.wu@intel.com>
        <20181222120216.GA74933@lkp-hsx03.lkp.intel.com>
        <20181223070613.GM3940@mtr-leonro.mtl.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Dec 2018 10:01:23 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leon@kernel.org>
Date: Sun, 23 Dec 2018 09:06:13 +0200

> Can you please apply this small fix?

Sure, I (eventually) will.  I'm just trying to figure out a few procedural
issues with handling the early net-next pull request before I start tossing
more changes on top.

Thanks!
