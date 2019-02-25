Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B8AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D886420842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfBYW2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:28:25 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47132 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfBYW2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 17:28:25 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 96A0B14EF9846;
        Mon, 25 Feb 2019 14:28:24 -0800 (PST)
Date:   Mon, 25 Feb 2019 14:28:23 -0800 (PST)
Message-Id: <20190225.142823.1371426320630014372.davem@davemloft.net>
To:     mail@timurcelik.de
Cc:     eric.dumazet@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tun: remove unnecessary memory barrier
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190225201313.GA30005@timur-laptop.fritz.box>
References: <b727b3bb-ec46-12bf-dd38-0363c9ca5854@gmail.com>
        <20190225.102548.247362521843809607.davem@davemloft.net>
        <20190225201313.GA30005@timur-laptop.fritz.box>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 25 Feb 2019 14:28:24 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timur Celik <mail@timurcelik.de>
Date: Mon, 25 Feb 2019 21:13:13 +0100

> Replace set_current_state with __set_current_state since no memory
> barrier is needed at this point.
> 
> Signed-off-by: Timur Celik <mail@timurcelik.de>

Applied, thanks.
