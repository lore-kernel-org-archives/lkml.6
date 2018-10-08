Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E5DC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6726C2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6726C2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJHNH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:07:56 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48288 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeJHNH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:07:56 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 353C2142D4FB1;
        Sun,  7 Oct 2018 22:57:56 -0700 (PDT)
Date:   Sun, 07 Oct 2018 22:57:55 -0700 (PDT)
Message-Id: <20181007.225755.347915466258746806.davem@davemloft.net>
To:     yamada.masahiro@socionext.com
Cc:     sparclinux@vger.kernel.org, shannon.nelson@oracle.com,
        linux-kernel@vger.kernel.org, nick.alcock@oracle.com,
        nagarathnam.muthusamy@oracle.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH] sparc: vdso: clean-up vdso Makefile
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1536723553-21287-1-git-send-email-yamada.masahiro@socionext.com>
References: <1536723553-21287-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 07 Oct 2018 22:57:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 12 Sep 2018 12:39:13 +0900

> arch/sparc/vdso/Makefile is a replica of arch/x86/entry/vdso/Makefile.
> 
> Clean-up the Makefile in the same way as I did for x86:
> 
>  - Remove unnecessary export
>  - Put the generated linker script to $(obj)/ instead of $(src)/
>  - Simplify cmd_vdso2c
> 
> The corresponding x86 commits are:
> 
>  - 61615faf0a89 ("x86/build/vdso: Remove unnecessary export in Makefile")
>  - 1742ed2088cc ("x86/build/vdso: Put generated linker scripts to $(obj)/")
>  - c5fcdbf15523 ("x86/build/vdso: Simplify 'cmd_vdso2c'")
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied.
