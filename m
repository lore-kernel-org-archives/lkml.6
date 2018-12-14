Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D424C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FAF208CD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbeLNV1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:27:24 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33958 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730757AbeLNV1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:27:23 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9F87814DF1C8C;
        Fri, 14 Dec 2018 13:27:22 -0800 (PST)
Date:   Fri, 14 Dec 2018 13:27:22 -0800 (PST)
Message-Id: <20181214.132722.1406978308882485818.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     ajk@comnets.uni-bremen.de, paulus@samba.org,
        viro@zeniv.linux.org.uk, colin.king@canonical.com,
        linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org
Subject: Re: [PATCH] hamradio, ppp: change semaphore to completion
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181210215318.1982562-1-arnd@arndb.de>
References: <20181210215318.1982562-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Dec 2018 13:27:23 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Dec 2018 22:52:56 +0100

> ppp and hamradio have copies of the same code that uses a semaphore
> in place of a completion for historic reasons. Make it use the
> proper interface instead in all copies.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
