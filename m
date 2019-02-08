Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68871C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E09021907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBHCPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:15:32 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55518 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfBHCPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:15:32 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7ED36108B8734;
        Thu,  7 Feb 2019 18:15:31 -0800 (PST)
Date:   Thu, 07 Feb 2019 18:15:30 -0800 (PST)
Message-Id: <20190207.181530.1190821370151974734.davem@davemloft.net>
To:     mdf@kernel.org
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net: fixed-phy: Add
 fixed_phy_register_with_gpiod() API
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190207201455.25071-1-mdf@kernel.org>
References: <20190207201455.25071-1-mdf@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Feb 2019 18:15:31 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>
Date: Thu,  7 Feb 2019 12:14:55 -0800

> Add fixed_phy_register_with_gpiod() API. It lets users create a
> fixed_phy instance that uses a GPIO descriptor which was obtained
> externally e.g. through platform data.
> This enables platform devices (non-DT based) to use GPIOs for link
> status.
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>

This doesn't apply cleanly to net-next, please respin.
