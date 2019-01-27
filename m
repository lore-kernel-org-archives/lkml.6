Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B991AC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E67E2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfA0V1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 16:27:18 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38152 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfA0V1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 16:27:18 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7312614BA7CF1;
        Sun, 27 Jan 2019 13:27:17 -0800 (PST)
Date:   Sun, 27 Jan 2019 13:27:17 -0800 (PST)
Message-Id: <20190127.132717.354006286945654891.davem@davemloft.net>
To:     ccaione@baylibre.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: at803x: Use helpers to access MMD PHY
 registers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190125123510.20511-1-ccaione@baylibre.com>
References: <20190125123510.20511-1-ccaione@baylibre.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 27 Jan 2019 13:27:17 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 25 Jan 2019 12:35:10 +0000

> Libphy provides a standard set of helpers to access the MMD PHY
> registers. Use those instead of relying on custom driver-specific
> functions.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Applied to net-next.
