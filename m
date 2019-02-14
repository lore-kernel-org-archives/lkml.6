Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26C3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E67120818
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dfVhiG3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393702AbfBNDHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:07:42 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:51079 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388285AbfBNDHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zOUKEyltExsjxF4ZbPNg+DUw0mbiw9l7x8DDJkpI9qE=; b=dfVhiG3UIWzRGzzAQ8Fl94+R0V
        Ju/cDsFia9vyhyaVH3Kij98+aXegzQkkVmLCRAZX7nAGifn4jw60RzP5w0HTHppqc2JBsRYGmHI+Q
        2X/vbc/UADPqy2hjLxEShmlEZAgD/BrN/9Wfs59atnqkXVNx7C3Uxo64EEIq6zX3nwmI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gu7N7-00055E-MN; Thu, 14 Feb 2019 04:07:33 +0100
Date:   Thu, 14 Feb 2019 04:07:33 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Peter Korsgaard <peter@korsgaard.com>,
        Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] i2c: ocores: improvements
Message-ID: <20190214030733.GG24589@lunn.ch>
References: <20190211164913.5988-1-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211164913.5988-1-federico.vaga@cern.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 05:49:08PM +0100, Federico Vaga wrote:
> This patch set provides improvements to the i2c-ocore driver.
> 
> [V5 -> V6]
> - remove redundant code introduced in V5 (double read control register)
> 
> [V4 -> V5]
> - deterministic status of IEN bit in register "CONTROL" at the end of
>   ocores_init()
> - more style fixes
> 
> [V3 -> V4]
> - add reviews-by/tested-by
> - add comment to justify the formula in
>     udelay((8 * 1000) / i2c->bus_clock_khz);

Hi Federico

It looks like all the reviewed-by: tags disappeared from v5.

Can you add them back again, and then we can probably merge this
patchset.

	Thanks
		Andrew
