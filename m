Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06F0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C48D20879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 03:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547350508;
	bh=u2vMSmIuHlfqXLVniFjN6O/rjGNGMR1DQYLP94HDR7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WRQbHbQUVWuMPmkHnAiV5mW4imgTbo/4cUbzcF2fuLLtpMMcgQsA1QFzPTDkf+BUm
	 2K24igMF7XJ45A7Xath6Dg/VCrs729oorSNDuUE0wEA3bvVFSdlTY7NvAZwghnfNsn
	 JogRHl3O4PO/+VJh1KovmQDjcUe9LaVV32a6A9qI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfAMDfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 22:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbfAMDfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 22:35:07 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76BB720842;
        Sun, 13 Jan 2019 03:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547350506;
        bh=u2vMSmIuHlfqXLVniFjN6O/rjGNGMR1DQYLP94HDR7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uBgxqFtARHwLBPCtpLCIUetEV0mdwg+ENhaTHCpFPMQOXBccFOSRnIrP/HRk35rh7
         /yby5655BFeCB2tThHp20GNdEmX5WD41AwTS9+XqrsmZkeg1lK44paH2XClU1AID1f
         6H3qsd+2DZJUAaZmL/As2JW6jWBp+vZL/Ln8C+CE=
Date:   Sun, 13 Jan 2019 11:34:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: imx6ul: add DMA properties for ECSPI
Message-ID: <20190113033449.GI11426@dragon>
References: <20190107132226.16216-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107132226.16216-1-stefan@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 02:22:25PM +0100, Stefan Agner wrote:
> Allow to use DMA for SPI by adding the appropriate DMA properites
> to the ecspi nodes.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied both, thanks.
