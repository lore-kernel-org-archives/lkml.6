Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D55C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C25B27F40
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C25B27F40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936539AbeF2NTa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:19:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45132 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932776AbeF2NT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:19:29 -0400
Received: from localhost (unknown [183.108.164.149])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EF6BF143D297B;
        Fri, 29 Jun 2018 06:19:26 -0700 (PDT)
Date:   Fri, 29 Jun 2018 22:19:25 +0900 (KST)
Message-Id: <20180629.221925.1974171391493646561.davem@davemloft.net>
To:     david.wu@rock-chips.com
Cc:     heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com,
        huangtao@rock-chips.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] net: ethernet: stmmac: dwmac-rk: Add GMAC support
 for px30
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1530149601-23337-1-git-send-email-david.wu@rock-chips.com>
References: <1530149601-23337-1-git-send-email-david.wu@rock-chips.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 29 Jun 2018 06:19:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Wu <david.wu@rock-chips.com>
Date: Thu, 28 Jun 2018 09:33:21 +0800

> Add constants and callback functions for the dwmac on px30 Soc.
> The base structure is the same, but registers and the bits in
> them are moved slightly, and add the clk_mac_speed for selecting
> mac speed.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>

Applied.
