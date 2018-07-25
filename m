Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE75C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68FE20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68FE20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbeGYVQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:16:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55176 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbeGYVQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:16:25 -0400
Received: from localhost (unknown [172.58.43.97])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 54D3012429EF0;
        Wed, 25 Jul 2018 13:03:12 -0700 (PDT)
Date:   Wed, 25 Jul 2018 13:03:10 -0700 (PDT)
Message-Id: <20180725.130310.1544958278484226871.davem@davemloft.net>
To:     camelia.groza@nxp.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, rmk+kernel@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: prevent PHYs w/o Clause 22 regs
 from calling genphy_config_aneg
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1532358375-8146-1-git-send-email-camelia.groza@nxp.com>
References: <1532358375-8146-1-git-send-email-camelia.groza@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 25 Jul 2018 13:03:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camelia Groza <camelia.groza@nxp.com>
Date: Mon, 23 Jul 2018 18:06:15 +0300

> genphy_config_aneg() should be called only by PHYs that implement
> the Clause 22 register set. Prevent Clause 45 PHYs that don't implement
> the register set from calling the genphy function.
> 
> Signed-off-by: Camelia Groza <camelia.groza@nxp.com>

Applied, thank you.
