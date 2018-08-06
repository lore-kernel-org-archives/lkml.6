Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2817C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E34821A33
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dAUmPYu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E34821A33
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbeHFWRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:17:24 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56673 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbeHFWRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=CjpZT+IJQnTqk+G3rS2iGV2IrPnzRdCqAkqE7H0U4SI=;
        b=dAUmPYu15gg/WVODbWrp8gXYWw53ey8yT2aFO0pXI/H5EGsIc9lyb4klFoUtpGHJnwceFO7lHlU1Ug4hAzheP+/XGT3v/Y9g1s5oOl1sICurlWBCBUVsGXC7TgrcoYtnyhyrdo48/5oY+JpWqk9TDVU918R8OAxGPfg08mQ2az8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fmlm4-0004Df-1r; Mon, 06 Aug 2018 22:06:40 +0200
Date:   Mon, 6 Aug 2018 22:06:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Kosta Zertsekel <zertsekel@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
Subject: Re: [PATCH v2] spi: orion: cosmetics - alias long direct_access
 variables
Message-ID: <20180806200640.GL9372@lunn.ch>
References: <20180806195002.15156-1-zertsekel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806195002.15156-1-zertsekel@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 10:50:02PM +0300, Kosta Zertsekel wrote:
> This change increases the source code readability.
> Instead of using `spi->child[cs].direct_access.XXX` use `dacc->XXX`.

Hi Kosta

You forgot to update this line.

Please wait a week to allow others to comment, then submit a v3, and
include:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
