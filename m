Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9767C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B99A217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbeLPTNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:13:42 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46382 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730688AbeLPTNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:13:42 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8DACD14EE058D;
        Sun, 16 Dec 2018 11:13:41 -0800 (PST)
Date:   Sun, 16 Dec 2018 11:13:40 -0800 (PST)
Message-Id: <20181216.111340.1916211375637201418.davem@davemloft.net>
To:     pabeni@redhat.com
Cc:     netdev@vger.kernel.org, eric.dumazet@gmail.com, pjt@google.com,
        linux-kernel@vger.kernel.org, ecree@solarflare.com,
        dwmw2@infradead.org
Subject: Re: [PATCH net-next v3 0/4] net: mitigate retpoline overhead
From:   David Miller <davem@davemloft.net>
In-Reply-To: <2444a44091ae292166c6cad1e31fd85ed2b77fe7.camel@redhat.com>
References: <cover.1544784419.git.pabeni@redhat.com>
        <20181215.132333.867660599141318055.davem@davemloft.net>
        <2444a44091ae292166c6cad1e31fd85ed2b77fe7.camel@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 16 Dec 2018 11:13:41 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>
Date: Sun, 16 Dec 2018 19:55:40 +0100

> Again, I messed it! I'm really sorry to waste everybody's time.
> I was unable to give proper coverage with different configs. I tested
> vs.:
> 
> CONFIG_IPV6=ymn
> CONFIG_INET=yn
> 
> but
> 
> # CONFIG_RETPOLINE is not set
> 
> fooled me. The following patch should fix.

Please submit this formally with a proper signoff and let's see where
it goes.
