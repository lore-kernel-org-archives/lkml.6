Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE711C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50CA20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50CA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbeKGEoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:44:20 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51150 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388240AbeKGEoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:44:20 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 342C71455115D;
        Tue,  6 Nov 2018 11:17:37 -0800 (PST)
Date:   Tue, 06 Nov 2018 11:17:36 -0800 (PST)
Message-Id: <20181106.111736.1149054212290410715.davem@davemloft.net>
To:     taoren@fb.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH net] net: phy: Allow BCM54616S PHY to setup internal
 TX/RX clock delay
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181105223540.1897084-1-taoren@fb.com>
References: <20181105223540.1897084-1-taoren@fb.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 06 Nov 2018 11:17:37 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <taoren@fb.com>
Date: Mon, 5 Nov 2018 14:35:40 -0800

> This patch allows users to enable/disable internal TX and/or RX clock
> delay for BCM54616S PHYs so as to satisfy RGMII timing specifications.
> 
> On a particular platform, whether TX and/or RX clock delay is required
> depends on how PHY connected to the MAC IP. This requirement can be
> specified through "phy-mode" property in the platform device tree.
> 
> The patch is inspired by commit 733336262b28 ("net: phy: Allow BCM5481x
> PHYs to setup internal TX/RX clock delay").
> 
> Signed-off-by: Tao Ren <taoren@fb.com>

This is fine for 'net', applied, thanks.
