Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A28C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562E820661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562E820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeH3GwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:52:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40074 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeH3GwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:52:19 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F12B4108F8649;
        Wed, 29 Aug 2018 19:52:24 -0700 (PDT)
Date:   Wed, 29 Aug 2018 19:52:24 -0700 (PDT)
Message-Id: <20180829.195224.512202790760491291.davem@davemloft.net>
To:     opendmb@gmail.com
Cc:     f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: use MAC link status for fixed phy
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1535484795-31871-1-git-send-email-opendmb@gmail.com>
References: <1535484795-31871-1-git-send-email-opendmb@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 29 Aug 2018 19:52:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>
Date: Tue, 28 Aug 2018 12:33:15 -0700

> When using the fixed PHY with GENET (e.g. MOCA) the PHY link
> status can be determined from the internal link status captured
> by the MAC. This allows the PHY state machine to use the correct
> link state with the fixed PHY even if MAC link event interrupts
> are missed when the net device is opened.
> 
> Fixes: 8d88c6e ("net: bcmgenet: enable MoCA link state change detection")
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Applied with fixed Fixes: tag SHA1-ID and queued up for -stable.
