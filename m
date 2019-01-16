Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A567C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A68D205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Nj2Diw13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393849AbfAPPCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:02:55 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45328 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391141AbfAPPCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=YoNXQZ70cH5Q/KQ8lqbctbeMw5iLvTckBIXyFd5oMLU=;
        b=Nj2Diw13uU5vBuvKQ8FbeoZiXQhWW/FrfY5UBqP7aCfZhmbFJmmsl5VS+AvNhC5+gok5QheImmGTX5hUvRpRmgCA/ccKnvRobav4DFMez6VQ73Pbb1pr09LmLM2UJuuUR0zP4kNxNGwrDmoib5JZr1rGX3CijRlrB+pw9/AlPWw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gjmiS-0007T5-62; Wed, 16 Jan 2019 16:02:52 +0100
Date:   Wed, 16 Jan 2019 16:02:52 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Johan Hovold <johan@kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: dsa: lantiq_gswip: drop bogus drvdata check
Message-ID: <20190116150252.GG25731@lunn.ch>
References: <20190116102335.30433-1-johan@kernel.org>
 <20190116102335.30433-4-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116102335.30433-4-johan@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 11:23:35AM +0100, Johan Hovold wrote:
> The platform-device driver data is set on successful probe and will
> never be NULL on remove (or we have much bigger problems).
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
