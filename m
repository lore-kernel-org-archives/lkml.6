Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F14CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5002221929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389904AbeLUTZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:25:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51628 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbeLUTZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:25:15 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7F25814B666DD;
        Fri, 21 Dec 2018 11:25:14 -0800 (PST)
Date:   Fri, 21 Dec 2018 11:25:14 -0800 (PST)
Message-Id: <20181221.112514.2125394297623092093.davem@davemloft.net>
To:     clabbe@baylibre.com
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc: Set "ARCH: sunxx" information on the same line
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1544530269-15008-1-git-send-email-clabbe@baylibre.com>
References: <1544530269-15008-1-git-send-email-clabbe@baylibre.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 21 Dec 2018 11:25:14 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>
Date: Tue, 11 Dec 2018 12:11:09 +0000

> While checking boot log from SPARC qemu, I saw that the "ARCH: sunxx"
> information was split on two different line.
> This patchs merge both line together.
> In the meantime, thoses information need to be printed via pr_info
> since printk print them by default via the warning loglevel.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied.
