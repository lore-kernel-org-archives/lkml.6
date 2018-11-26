Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97176C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFB120855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbwL21Ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFB120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeK0A4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:56:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbeK0A4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:56:43 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3602220817;
        Mon, 26 Nov 2018 14:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543240950;
        bh=8Ey0U/5KVSUePFPZiKBDZGwL+wcwm7wK/UkAzktdXXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EbwL21AhJ56CN9RCBqA4H2rz1SPM5sZbzuOcmHipnbjOU4o/xkDtGRWuISI5vo3VP
         fqNPECABzAJwftqJE/NzpbRzqqGJBSx7W51/TGcM9KrJJQVbuS3q00IvglaIPbjZNA
         tpqniteD7dA9kxmmI0SS4FBO65KEDoGvHtEYnJ0c=
Date:   Mon, 26 Nov 2018 22:02:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     devicetree@vger.kernel.org, peter.chen@nxp.com,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx: Add dummy PHYs for HSIC-only USB
 controllers
Message-ID: <20181126140208.GA31334@dragon>
References: <1539848729-27646-1-git-send-email-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539848729-27646-1-git-send-email-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 09:45:04AM +0200, Frieder Schrempf wrote:
> Some SOCs in the i.MX6 family have a USB host controller that is
> only capable of the HSIC interface and has no on-board PHY.
> 
> To be able to use these controllers, we need to add "usb-nop-xceiv"
> dummy PHYs.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied, thanks.
