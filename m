Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA17C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6942F208E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jXf8dAZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6942F208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390070AbeHGUYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:24:10 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57591 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389017AbeHGUYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=nA8wbbXWx4twA5+oEbCTyE5j2/L6mNEXmlfXA0GAKIU=;
        b=jXf8dAZw9nvxrzprRrF2304wjynUBYl+hZXjgEE9aFN0F1uPsud/XS9pcegW0sIXjLw3pG88JOXztAEoscH+aTCzIaJb8/Uf/EaLA2LNPoaRq7hHfdsIn7fs+CYutQXSY8jr9BBMyaEzB2Rzm0AMG4H5b7YUwLqVVywgxPNR9bM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fn6PD-0001BW-Ov; Tue, 07 Aug 2018 20:08:27 +0200
Date:   Tue, 7 Aug 2018 20:08:27 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Arun Parameswaran <arun.parameswaran@broadcom.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 0/3] Add Broadcom Omega SoC internal switch and phy
Message-ID: <20180807180827.GH18350@lunn.ch>
References: <1533661364-15381-1-git-send-email-arun.parameswaran@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533661364-15381-1-git-send-email-arun.parameswaran@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 10:02:41AM -0700, Arun Parameswaran wrote:
> Hi,
> 
> The patchset is based on David Miller's "net-next" repo.
> 
> The patches add support for the Broadcom Omega SoC's internal ethernet
> switch and the internal gphy.
> 
> The internal ethernet switch in the Omega is a b53 srab based switch.
> The support for the switch is added to the b53 driver in the dsa
> framework.
> 
> The gphy support is added to the bcm7xxx driver.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
