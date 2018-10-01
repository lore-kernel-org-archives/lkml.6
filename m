Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE5DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8049E2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="AUW1Yv4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8049E2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbeJATRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:17:31 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:45818 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbeJATRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:17:31 -0400
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id E052125AD76;
        Mon,  1 Oct 2018 22:39:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1538397592; bh=Mhw2u6AeOWkJblqe2I7N7PKnm7+rd0jleJqf02OcMIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUW1Yv4jvC2DohhM3/G9XAc8YYxAjhwnzUf4eUVPu9q1CNxaBfbWytlgSvYeuRUPz
         cefLzFeZFDJWOM5qMsCB1ZndCvD5TSrjWzgH5O+Br4K9dykfpkbDYVpdlsFUZzilzb
         p9g+FJ0TAcGMPAD3XirqbLzJyPKOhqFRvVb1JtVI=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id DB0C9E21E33; Mon,  1 Oct 2018 14:39:49 +0200 (CEST)
Date:   Mon, 1 Oct 2018 14:39:49 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] ARM: dts: r9a06g032: Add pinctrl node
Message-ID: <20181001123949.4l47km37qqqclcq4@verge.net.au>
References: <20180926091053.21255-1-phil.edworthy@renesas.com>
 <20180926091053.21255-4-phil.edworthy@renesas.com>
 <CAMuHMdVg8XZQxpGM5ZB5P03SNbsr3y=kBg-pftNrRLt6xE-34w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVg8XZQxpGM5ZB5P03SNbsr3y=kBg-pftNrRLt6xE-34w@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 01:41:39PM +0200, Geert Uytterhoeven wrote:
> On Wed, Sep 26, 2018 at 11:11 AM Phil Edworthy
> <phil.edworthy@renesas.com> wrote:
> > This provides a pinctrl driver for the Renesas R9A06G032 SoC
> >
> > Based on a patch originally written by Michel Pollet at Renesas.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied for v4.21.
