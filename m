Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFB8C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57F120882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l0dvPPYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57F120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeINAYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:24:46 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33893 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbeINAYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=n5Fuf6oMJBjkO1oWw4krKy7s0Nre7Ly2qIdH2N8wOHw=;
        b=l0dvPPYHUCdWff8thYZU2UoUgZE9DhIDmxPK4xeepq5YLUw3NUGRICynwlg7AkndcAe3e5dhmRlHPlVUidbvBG4RST1pNLT6bmULUq+8t41Z45LNyzE24RFSO3VV9B0xr+d1waDJgGiKUFvoo8RG/8ZOb1YeiJD7iYJ5HMxcJPk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g0X3o-0008SQ-9d; Thu, 13 Sep 2018 21:13:52 +0200
Date:   Thu, 13 Sep 2018 21:13:52 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: et011c: Remove incorrect PHY_POLL
 flags
Message-ID: <20180913191352.GD23892@lunn.ch>
References: <20180913183630.32584-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913183630.32584-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 11:36:30AM -0700, Florian Fainelli wrote:
> PHY_POLL is defined as -1 which means that we would be setting all flags of the
> PHY driver, this is also not a valid flag to tell PHYLIB about, just remove it.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
