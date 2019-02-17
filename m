Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6E9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9512184E
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfBQXiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:38:25 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42764 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfBQXiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:38:25 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1813612339A63;
        Sun, 17 Feb 2019 15:38:24 -0800 (PST)
Date:   Sun, 17 Feb 2019 15:38:23 -0800 (PST)
Message-Id: <20190217.153823.1902309066603119738.davem@davemloft.net>
To:     alexandre.torgue@st.com
Cc:     peppe.cavallaro@st.com, joabreu@synopsys.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com
Subject: Re: [net, PATCH v2] net: stmmac: handle endianness in
 dwmac4_get_timestamp
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1550224149-30380-1-git-send-email-alexandre.torgue@st.com>
References: <1550224149-30380-1-git-send-email-alexandre.torgue@st.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 17 Feb 2019 15:38:24 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Torgue <alexandre.torgue@st.com>
Date: Fri, 15 Feb 2019 10:49:09 +0100

> GMAC IP is little-endian and used on several kind of CPU (big or little
> endian). Main callbacks functions of the stmmac drivers take care about
> it. It was not the case for dwmac4_get_timestamp function.
> 
> Fixes: ba1ffd74df74 ("stmmac: fix PTP support for GMAC4")
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

Please do not put an empty line between Fixes: and other tags.  All
tags are equal and should be placed together as a cohesive group.

Applied, thanks.
