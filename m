Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C0F7CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774272086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j7TEKFVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774272086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934826AbeFMHX2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:23:28 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60325 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754467AbeFMHX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=HcNaCL+qHtuaEyGu/cbVR4n4e/zaybAQVxjtAEZvc00=;
        b=j7TEKFVAHQrzru7Qbz5ycrZSDYQPWoNnY38QVABKMT7E00so0JkmIzDu2Ok6nWlNrZe7SkU1f2rbhe4j0K6fdblIsoFxIK7eqMnJqEOtc+zle/OsgrJeriLH6DJD0QHXmtfvDs/HZWSHAvSmYez2Ws4MLCPgudhSuItzRTHOR1I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fT07m-0006hG-Ek; Wed, 13 Jun 2018 09:23:22 +0200
Date:   Wed, 13 Jun 2018 09:23:22 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     davem@davemloft.net, michal.simek@xilinx.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] net: emaclite: Remove unused 'has_mdio' flag.
Message-ID: <20180613072322.GD24314@lunn.ch>
References: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1528871719-1681-4-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528871719-1681-4-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 12:05:18PM +0530, Radhey Shyam Pandey wrote:
> Remove unused 'has_mdio' flag.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
