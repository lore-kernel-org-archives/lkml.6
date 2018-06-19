Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD50AC5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968B620850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="obrUv4HO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968B620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937175AbeFSCu2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934644AbeFSCu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:50:27 -0400
Received: from dragon (unknown [45.56.152.47])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC9232075E;
        Tue, 19 Jun 2018 02:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529376626;
        bh=bQ8fXUCFtdiKAvgV5elVgaAJzsuEeRigrzkhiYxKmXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=obrUv4HOJMOr+KUJXa85l2aNB2PyLFzxRa69GUfjx98TsZw8m+Qd1ahW10JIUwhuB
         2+O3X+YdYeF1iOuneqrkz8dya+obpDYrYCtT3zwZFDj+7pfF24qkzua2oY61TQbPsV
         XfvhjF3AhI5AM5J4BRYrirrU93diplUDbOcxuNS4=
Date:   Tue, 19 Jun 2018 10:49:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx6dl: Add Engicam i.CoreM6 1.5 Quad/Dual
 MIPI starter kit support
Message-ID: <20180619024930.GA16091@dragon>
References: <20180607135133.3104-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607135133.3104-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 07:21:31PM +0530, Jagan Teki wrote:
> i.CoreM6 1.5 is an another i.CoreM6 QDL cpu modules which can be connected
> to EDIMM starter kit design with eMMC and MIPI-CSI interfaces suitable for
> Android and video capture application.
> 
> notable features:
> CPU                 NXP i.MX6 S/DL/D/Q, Up to 4 x Cortex-A9@800MHz
> Memory              Up to 2 GB DDR3-1066
> Video Interfaces    Up to 1 Parallel Up to 2 LVDS HDMI 1.4
>                     port 8 bit CSI INPUT MIPI-CSI INPUT
> 1 x 10/100 Ethernet interface, 2 x USB, 1 x PCIe, 1 x I2S etc
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied all, thanks.
