Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74690C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5DF20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfAQTd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:33:29 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59256 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfAQTd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:33:29 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5C07310170454;
        Thu, 17 Jan 2019 11:33:28 -0800 (PST)
Date:   Thu, 17 Jan 2019 11:33:27 -0800 (PST)
Message-Id: <20190117.113327.372281269819882744.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Add helpers to determine if PHY
 driver is generic
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190115230936.28890-1-f.fainelli@gmail.com>
References: <20190115230936.28890-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 17 Jan 2019 11:33:28 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 15 Jan 2019 15:09:35 -0800

> We are already checking in phy_detach() that the PHY driver is of
> generic kind (1G or 10G) and we are going to make use of that in the SFP
> layer as well for 1000BaseT SFP modules, so expose helper functions to
> return that information.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied.
