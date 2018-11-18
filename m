Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679B5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8072080F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1zqryQbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8072080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeKSDZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:25:06 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:39521 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbeKSDZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=la3wqDlJOcQ3fFGsZKL88toMUAoM8a3v28qt7mLxU80=;
        b=1zqryQbU/GdhwsrVn0J3MgpmmCmk80Zl5k3KFD0S7cRycEyWm4WArUwRQf4lKnU6ss1VHHR0YfiN1hRrSxRYyoDU36Yl+J3YElXpyr/5l9gXnxN5rQvimrsjgTECr6ylllFZ7hAWLYVhoLxv5YL8cLgCD108kjQdR+f5OTvR9L8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gOQUX-0001gP-UQ; Sun, 18 Nov 2018 18:04:13 +0100
Date:   Sun, 18 Nov 2018 18:04:13 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] net: phy: icplus: keep all ip101a_g functions
 together
Message-ID: <20181118170413.GC5591@lunn.ch>
References: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
 <20181117182007.14791-4-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117182007.14791-4-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 07:20:03PM +0100, Martin Blumenstingl wrote:
> This simply moves ip101a_g_config_init right above
> ip101a_g_config_intr so all functions for the ICPlus IP101A/G PHYs are
> grouped together.
> No functional changes.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
