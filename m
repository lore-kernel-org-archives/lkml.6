Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C66C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A9020818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfBUUyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:54:03 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42740 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfBUUyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:54:02 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 57117145E74FB;
        Thu, 21 Feb 2019 12:54:02 -0800 (PST)
Date:   Thu, 21 Feb 2019 12:54:01 -0800 (PST)
Message-Id: <20190221.125401.2739546627720795.davem@davemloft.net>
To:     jannh@google.com
Cc:     netdev@vger.kernel.org, dmitry.tarnyagin@lockless.no,
        abi.dmitryt@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] MAINTAINERS: mark CAIF as orphan
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190221195816.136157-1-jannh@google.com>
References: <20190221195816.136157-1-jannh@google.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Feb 2019 12:54:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>
Date: Thu, 21 Feb 2019 20:58:16 +0100

> The listed address for the CAIF maintainer bounces with
> "553 5.3.0 <dmitry.tarnyagin@lockless.no>... No such user here", and the
> only existing email address of the maintainer in git history hasn't
> responded in a week.
> Therefore, remove the listed maintainer and mark CAIF as orphan.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Applied.
