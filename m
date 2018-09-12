Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5686CC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E691320882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGu6hSUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E691320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeILGRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 02:17:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbeILGRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 02:17:09 -0400
Received: from dragon (unknown [104.237.86.3])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4637120880;
        Wed, 12 Sep 2018 01:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536714911;
        bh=sNX63Hm7N7slD4vdcJt/EiMOE/kmkzoSdl1Jfk/rAH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AGu6hSUqnAps+1nGq/kTltc9L3ZQ37RkNGzPInzVwl/7rbdxc7UfrZ1ONQRUzMgyn
         mNMsHtZHOunsm/GlxKrjFOj3JocgjOSUbWauhs5Z6qGx57E2nW2wKMZp9zlH8/8zYR
         1KnEJ4+Xkh2APNnKOLd0C2zj6DIcxdQQH4XncuGw=
Date:   Wed, 12 Sep 2018 09:13:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alex Gonzalez <alex.gonzalez@digi.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro
Message-ID: <20180912011336.GD28469@dragon>
References: <1536572272-18590-1-git-send-email-alex.gonzalez@digi.com>
 <1536572272-18590-2-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536572272-18590-2-git-send-email-alex.gonzalez@digi.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 11:37:52AM +0200, Alex Gonzalez wrote:
> The ConnectCore 6UL Single Board Computer (SBC) Pro contains the
> ConnectCore 6UL System-On-Module.
> 
> Its hardware specifications are:
> 
> * 256MB DDR3 memory
> * On module 256MB NAND flash
> * Dual 10/100 Ethernet
> * USB Host and USB OTG
> * Parallel RGB display header
> * LVDS display header
> * CSI camera
> * GPIO header
> * I2C, SPI, CAN headers
> * PCIe mini card and micro SIM slot
> * MicroSD external storage
> * On board 4GB eMMC flash
> * Audio headphone, line in/out, microphone lines
> 
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>

Applied, thanks.
