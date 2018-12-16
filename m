Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B749C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 07:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA147217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 07:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544946753;
	bh=E7ebVP08aEtPd/p/ROKK8M8tvFKVzgvj2GUP/c8sgQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DY9UNXrDtaMZ2PhLIUlpz6YVo5woJ4saiiiBXMM6rTfNqGui8uaHRITluJE8Ja+Qb
	 3CbKiLhKT5vDJ4TCzhBaOFejfFpuJ1TTenNKqvStpMGHBC3uwnJA/ejF363A9rbaPA
	 eBkor9WlRogl68eVfx9q9XJxSkopTBeWsQyH16Ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbeLPHwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 02:52:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729709AbeLPHwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 02:52:32 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A28020672;
        Sun, 16 Dec 2018 07:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544946751;
        bh=E7ebVP08aEtPd/p/ROKK8M8tvFKVzgvj2GUP/c8sgQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7sh6Y0ZvqYbFYTThLCB0QSKXkM8iAox+2IzNoP5ZguNBSuzR9iZaDz8uk1xRp175
         jWDm29Nt+lcanyCxQA5jxTSaYGGzzUQD2Cc5NJum9cQnWiTCjcSXZLrYI8EnPX7DXf
         sZ3Qo9h5VHeWzjzh7QbEAMuMljORyeHGHrrn1e4g=
Date:   Sun, 16 Dec 2018 15:51:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH 0/5] Prepare devicetrees for the new FSL QSPI driver
Message-ID: <20181216075121.GH13243@dragon>
References: <1544459182-23655-1-git-send-email-frieder.schrempf@kontron.de>
 <ce1442f3-357b-d647-958e-cc4a89282b79@kontron.de>
 <1ad93cdf-7ba1-ff49-f330-6bbd0f6c6972@kontron.de>
 <20181214004251.GA15775@dragon>
 <937b0f34e3eb485aaae45cd649cdeb4f@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <937b0f34e3eb485aaae45cd649cdeb4f@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 10:04:55AM +0000, Schrempf Frieder wrote:
> I can confirm, that the series does only remove or add properties to the
> devicetree, that are currently not used by the driver. Therefore it won't break
> anything.

Okay, applied the series.

Shawn
