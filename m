Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2B8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D263020855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfAQXIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:08:42 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33902 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfAQXIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:08:41 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5484214B9828F;
        Thu, 17 Jan 2019 15:08:41 -0800 (PST)
Date:   Thu, 17 Jan 2019 15:08:40 -0800 (PST)
Message-Id: <20190117.150840.156159177374324339.davem@davemloft.net>
To:     malat@debian.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] davicom: Annotate implicit fall through in
 dm9000_set_io
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190116194925.2181-1-malat@debian.org>
References: <20190116194925.2181-1-malat@debian.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 17 Jan 2019 15:08:41 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 16 Jan 2019 20:49:25 +0100

> There is a plan to build the kernel with -Wimplicit-fallthrough and
> this place in the code produced a warning (W=1).
> 
> This commit removes the following warning:
> 
>   include/linux/device.h:1480:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   drivers/net/ethernet/davicom/dm9000.c:397:3: note: in expansion of macro 'dev_dbg'
>   drivers/net/ethernet/davicom/dm9000.c:398:2: note: here
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied.
