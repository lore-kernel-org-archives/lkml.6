Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5933C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD462087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6Ngf8RVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbfBDO7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:59:00 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:38050 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbfBDO7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7RupaaMd7C/iXTOR3P7hMqHOy0ybn3Wjzqz3cVqU8Wc=; b=6Ngf8RVeH4y/dkmmUZvQKtsMjv
        azRshNNi/OlYLn+/hCfb8HHzW7jsbxUbi+KANnAcCHOeX9rsLGKj59eOa0PVeJLHyQdHagOjeHC8f
        UnJ3iUnyzVRHXj3UbYGnES7KmZlCek+0XsCOfVQGmhKOJnv83Do+dhNnev3Ys896Uxgw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gqfi3-0006CR-0F; Mon, 04 Feb 2019 15:58:55 +0100
Date:   Mon, 4 Feb 2019 15:58:54 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, davem@davemloft.net,
        alex.williams@ni.com, Rob Herring <robh+dt@kernel.org>
Subject: Re: [net-next RFC/PATCH] net: nixge: Make mdio child node optional
Message-ID: <20190204145854.GD22111@lunn.ch>
References: <20190202025048.14772-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190202025048.14772-1-mdf@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 06:50:48PM -0800, Moritz Fischer wrote:
> Make MDIO child optional and only instantiate the
> MDIO bus if the child is actually present.
> 
> There are currently no (in-tree) users of this
> binding; all (out-of-tree) users use overlays that
> get shipped together with the FPGA images that contain
> the IP.
> 
> This will significantly increase maintainabilty
> of future revisions of this IP.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Rob Herring <robh+dt@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
