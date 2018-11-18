Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08414C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51DC2080F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VkQwWAuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51DC2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeKSD1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:27:25 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:39536 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbeKSD1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=WxDlyMAZiOsvbTdDp5+1v4IGZG0CWWh9rt8c3lxyEyU=;
        b=VkQwWAuViKMnX6nckQlrGE9qoUQHJsI2PidZkNOaLF0n+RmZlnOS9/+Dyh0ppTXDQido/F2WB0o4VG3U+oYkZf37aAB7/lJC85CQMHXUKoZkefd6QdNK17xx97QULH/7osdEymC9wquqD2NpIr52DPcfl1a47KhqWkNuFHIJtQU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gOQWk-0001jc-UJ; Sun, 18 Nov 2018 18:06:30 +0100
Date:   Sun, 18 Nov 2018 18:06:30 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] net: phy: icplus: rename IP101A_G_NO_IRQ to
 IP101A_G_IRQ_ALL_MASK
Message-ID: <20181118170630.GE5591@lunn.ch>
References: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
 <20181117182007.14791-6-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117182007.14791-6-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 07:20:05PM +0100, Martin Blumenstingl wrote:
> The datasheet uses the name "All Mask" for this bit. Change the name of
> our #define to be consistent with the datasheet. While here also replace
> the tab between the #define and IP101A_G_IRQ_ALL_MASK with a space.
> No functional changes.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I think this is the bit which confused Florian. Nice change, it makes
it a lot clearer what is going on.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
