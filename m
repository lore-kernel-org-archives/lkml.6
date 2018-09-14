Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1514FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EAD21476
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oXOnKnL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EAD21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeINSTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:19:13 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34563 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeINSTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=XVGOVHY433Rh7k1N4h/bDLMihAjW826aTgE4f0VCQnY=;
        b=oXOnKnL+wNA2l6GBoo6WaDK28otEJq/82Q1UX7GLYCTT7fBmAnSrlbHfk7gV75jS0bajunQFvif3nIeGLbTrGg/ykLUcB3mJEjoc6aiMfWhDvYxkc06oEZsFjFQA4vs/mHHDz+MdYICS7DhD7HOs2gAXFcG2zU6rv7Q1pHrycfs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g0nm9-0004Cp-7U; Fri, 14 Sep 2018 15:04:45 +0200
Date:   Fri, 14 Sep 2018 15:04:45 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next 3/5] net: phy: mscc: remove unneeded parenthesis
Message-ID: <20180914130445.GC14865@lunn.ch>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
 <e3a1a9940e18c69ecf9aaecc3e2d9bf2a180a939.1536913944.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3a1a9940e18c69ecf9aaecc3e2d9bf2a180a939.1536913944.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 10:33:45AM +0200, Quentin Schulz wrote:
> The == operator precedes the || operator, so we can remove the
> parenthesis around (a == b) || (c == d).
> 
> The condition is rather explicit and short so removing the parenthesis
> definitely does not make it harder to read.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
