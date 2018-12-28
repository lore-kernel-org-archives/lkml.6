Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59A0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD1620856
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbeL1AVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 19:21:10 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51944 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeL1AVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 19:21:09 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 60DF314E0980C;
        Thu, 27 Dec 2018 16:21:08 -0800 (PST)
Date:   Thu, 27 Dec 2018 16:21:07 -0800 (PST)
Message-Id: <20181227.162107.1305791820546855924.davem@davemloft.net>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, maxime.ripard@bootlin.com, wens@csie.org,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmicro: fix a missing check of clk_prepare
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181226025714.72643-1-kjlu@umn.edu>
References: <20181226025714.72643-1-kjlu@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 27 Dec 2018 16:21:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>
Date: Tue, 25 Dec 2018 20:57:14 -0600

> clk_prepare() could fail, so let's check its status, and if it fails,
> return its error code upstream.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Applied.
