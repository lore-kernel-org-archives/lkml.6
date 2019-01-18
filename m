Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8C2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 06:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E4C20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 06:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfARGEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 01:04:23 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37546 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfARGEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 01:04:22 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BE15D14B96685;
        Thu, 17 Jan 2019 22:04:21 -0800 (PST)
Date:   Thu, 17 Jan 2019 22:04:21 -0800 (PST)
Message-Id: <20190117.220421.456301701600223278.davem@davemloft.net>
To:     camelia.groza@nxp.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        oss@buserror.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: add missing phy driver features
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1547728413-20233-1-git-send-email-camelia.groza@nxp.com>
References: <1547728413-20233-1-git-send-email-camelia.groza@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 17 Jan 2019 22:04:22 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camelia Groza <camelia.groza@nxp.com>
Date: Thu, 17 Jan 2019 14:33:33 +0200

> The phy drivers for CS4340 and TN2020 are missing their
> features attributes. Add them.
> 
> Fixes: 719655a14971 ("net: phy: Replace phy driver features u32 with link_mode bitmap")
> Reported-by: Scott Wood <oss@buserror.net>
> Signed-off-by: Camelia Groza <camelia.groza@nxp.com>

Applied and queued up for -stable.
