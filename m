Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE908C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D37D2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kRSFtxiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfA1UVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:21:37 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:58329 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfA1UVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dTwi/trjnEqoD15lnK4zVR01WHPHZ76gAiAnWhjM/0E=; b=kRSFtxiSI2dD7m6j/Uw9jFAXDr
        EMVfeo/wjC1roKlWTZtmIFTs4j4rfsrSHRFmtJvPOdiGMmmajuz7ULRqtosyLsoRxaG3PhUk/vBWa
        q3xn4E3h/ReZxzZhmI3KDKJYY29OwO+N+gqTNK0ic3B8Iy9UswAGOpyj5ZsFSnpGZI4A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1goDPN-00038E-E2; Mon, 28 Jan 2019 21:21:29 +0100
Date:   Mon, 28 Jan 2019 21:21:29 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: armada-3720-espressobin: Set mv88e6341
 cpu port as RGMII-ID
Message-ID: <20190128202129.GA11826@lunn.ch>
References: <20190128200728.17747-1-repk@triplefau.lt>
 <20190128200728.17747-3-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128200728.17747-3-repk@triplefau.lt>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 09:07:28PM +0100, Remi Pommarel wrote:
> The mv88e6341 ethernet switch needs the cpu port control register to be
> set with TX and RX internal delay in order to work.
> 
> This fixes ethernet support on system booted via a bootloader that
> has not already configured this register (e.g. mainline u-boot, or
> vendor u-boot compiled without ethernet support).
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Looks sensible

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
