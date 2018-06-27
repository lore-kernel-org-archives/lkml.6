Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60EDC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DA22648B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DA22648B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbeF0JRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:17:33 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53158 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbeF0JRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:17:31 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A1E94142A39A3;
        Wed, 27 Jun 2018 02:17:27 -0700 (PDT)
Date:   Wed, 27 Jun 2018 18:17:23 +0900 (KST)
Message-Id: <20180627.181723.1142068438004890978.davem@davemloft.net>
To:     david.wu@rock-chips.com
Cc:     heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com,
        huangtao@rock-chips.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: ethernet: stmmac: dwmac-rk: Add GMAC support
 for px30
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1530001173-21935-1-git-send-email-david.wu@rock-chips.com>
References: <1530001173-21935-1-git-send-email-david.wu@rock-chips.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 27 Jun 2018 02:17:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Wu <david.wu@rock-chips.com>
Date: Tue, 26 Jun 2018 16:19:33 +0800

> Add constants and callback functions for the dwmac on px30 Soc.
> The base structure is the same, but registers and the bits in
> them are moved slightly, and add the clk_mac_speed for selecting
> mac speed.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>

This patch doesn't apply to net-next.
