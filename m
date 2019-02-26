Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4E0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C812184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfBZAXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:23:04 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48364 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbfBZAXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:23:04 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3997114F00463;
        Mon, 25 Feb 2019 16:23:03 -0800 (PST)
Date:   Mon, 25 Feb 2019 16:23:00 -0800 (PST)
Message-Id: <20190225.162300.209654917842732349.davem@davemloft.net>
To:     firoz.khan@linaro.org
Cc:     viro@zeniv.linux.org.uk, sparclinux@vger.kernel.org,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH 0/3] sparc: Unify the system call scripts
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
References: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 25 Feb 2019 16:23:03 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Firoz Khan <firoz.khan@linaro.org>
Date: Wed,  2 Jan 2019 21:22:50 +0530

> System call table generation support is provided for
> alpha, ia64, m68k, microblaze, mips, parisc, powerpc,
> sh, sparc and xtensa architectures. The implementat-
> ions are almost similar across all the above archte-
> ctures. In order to reduce the source code across all
> the above architectures, create common ".sh" files and
> keep it in the common directory, script/. This will 
> be a generic scripts which can use for all the above
> architectures.
> 
> This patch depends on;
>  https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/

Can you please merge this series in with that dependency
then?

Acked-by: David S. Miller <davem@davemloft.net>
