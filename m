Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A1BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392842186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DI6BsWWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfBFN3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:29:13 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:41027 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfBFN3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CZLteNmu1ojUSzpXxdxdypGT5Y/svXQ2qa+KrA4XoRo=; b=DI6BsWWY+onJoCw6f4fVos0T60
        Lrdvw4SkZvpAJTPbA4P/citL7m6HdrkpOHrsWQRhF87UsdwNrmuVjgpF0F7aCeEozOmmw/AhieOfS
        FJI2ITf5ZNLzN+dUbWXF0Y2NXVu4J41PWmbzoG3MpODcz6axBJFSOdRYYaD7PWAr2e4Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1grNGG-0005rE-8D; Wed, 06 Feb 2019 14:29:08 +0100
Date:   Wed, 6 Feb 2019 14:29:08 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Paul Zimmerman <pauldzim@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] r8169: Load MAC address from device tree if
 present
Message-ID: <20190206132908.GE20405@lunn.ch>
References: <20190206123018.24802-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206123018.24802-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 01:30:17PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> If the system was booted using a device tree and if the device tree
> contains a MAC address, use it instead of reading one from the EEPROM.
> This is useful in situations where the EEPROM isn't properly programmed
> or where the firmware wants to override the existing MAC address.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
