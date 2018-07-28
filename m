Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AC7C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0410620862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Vcr6uEiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0410620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbeG1WnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 18:43:24 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49360 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730950AbeG1WnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 18:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Zm/YNlAPCB9TkTLtLWeGktoDh/LbH6bwA+xl0+xVt50=;
        b=Vcr6uEiEkjJcc+Gee9cvcuugSmUqQsjQf/9wLOgjjnOccCMlcc/8p8JKYx1b4vzFmBAULNzaG48FH5Atpizj2tOst1jMqUq8lkXfkxmrDLozdgISadKE+4eGOkWM4Ob7sXDcLTjLmJzPnF6xqRf0Hj4amBpeMMjIeUX6aW22QrI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fjWYg-0001Nh-AN; Sat, 28 Jul 2018 23:15:26 +0200
Date:   Sat, 28 Jul 2018 23:15:26 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Arun Parameswaran <arun.parameswaran@broadcom.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 5/7] dt-bindings: net: Add clock handle to Broadcom
 iProc mdio mux
Message-ID: <20180728211526.GE4792@lunn.ch>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-6-git-send-email-arun.parameswaran@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532726613-6483-6-git-send-email-arun.parameswaran@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 02:23:31PM -0700, Arun Parameswaran wrote:
> Add clock phandle, of the core clock driving the mdio block, as an
> optional property to the Broadcom iProc mdio mux.
> 
> The clock, when specified, will be used to setup the rate adjust registers
> in the mdio to derrive the mdio's operating frequency.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
