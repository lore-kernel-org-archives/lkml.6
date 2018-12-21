Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437BEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155CF21939
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389740AbeLUTZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:25:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51616 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbeLUTZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:25:11 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0B1E014B666DD;
        Fri, 21 Dec 2018 11:25:10 -0800 (PST)
Date:   Fri, 21 Dec 2018 11:25:07 -0800 (PST)
Message-Id: <20181221.112507.103897466549504781.davem@davemloft.net>
To:     ndesaulniers@google.com
Cc:     yamada.masahiro@socionext.com, frowand.list@gmail.com,
        mingo@kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: vdso: Drop implicit common-page-size linker flag
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181210223515.26332-1-ndesaulniers@google.com>
References: <20181210223515.26332-1-ndesaulniers@google.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 21 Dec 2018 11:25:10 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ndesaulniers@google.com
Date: Mon, 10 Dec 2018 14:35:13 -0800

> GNU linker's -z common-page-size's default value is based on the target
> architecture. arch/sparc/vdso/Makefile sets it to the architecture
> default, which is implicit and redundant. Drop it.
> 
> Link: https://lkml.kernel.org/r/20181206191231.192355-1-ndesaulniers@google.com
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Applied.
