Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18397C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E445E20868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfAWBhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:37:25 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38980 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfAWBhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 20:37:24 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E421B14D63A88;
        Tue, 22 Jan 2019 17:37:23 -0800 (PST)
Date:   Tue, 22 Jan 2019 17:37:23 -0800 (PST)
Message-Id: <20190122.173723.1609622837834592384.davem@davemloft.net>
To:     panfilov.artyom@gmail.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/1] net: stmmac: implement the SIOCGHWTSTAMP
 ioctl
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190120160515.26473-1-panfilov.artyom@gmail.com>
References: <20190120160515.26473-1-panfilov.artyom@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 22 Jan 2019 17:37:24 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Panfilov <panfilov.artyom@gmail.com>
Date: Sun, 20 Jan 2019 19:05:15 +0300

> This patch adds support for the SIOCGHWTSTAMP ioctl which enables user
> processes to read the current hwtstamp_config settings
> non-destructively.
> 
> Signed-off-by: Artem Panfilov <panfilov.artyom@gmail.com>

Applied, thanks.
