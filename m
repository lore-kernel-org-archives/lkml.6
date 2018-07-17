Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE67ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C8B208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLJq3UYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C8B208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeGQGa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727293AbeGQGaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:30:55 -0400
Received: from dragon (unknown [104.237.91.210])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2524720864;
        Tue, 17 Jul 2018 05:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531807202;
        bh=tNFMDOoQ6tluY62vi5h/vhFHz35RRHlgOdUnwjUezF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JLJq3UYmBnEb0f7BGeJQngCpFt5APh62Xl9IeSVsbNvuoJShvBB9BSm3PqUlFyip7
         s8PvKNceWYZRLe80ESFvTkMZDVpE3X7Jhhn3ul2JTZ5wT20ABHpPivDo7JtQ/TT/mY
         gm8ubVCj1mO8LOqTGDl8ETvw4ubmGpZbivFreHkM=
Date:   Tue, 17 Jul 2018 13:59:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Marius Vlad <marius-cristian.vlad@nxp.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: imx6sl: Add vivante gpu nodes
Message-ID: <20180717055949.GG4576@dragon>
References: <51acc44e6fd0458e63635b92428fe7743e18a3c7.1531474202.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51acc44e6fd0458e63635b92428fe7743e18a3c7.1531474202.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 12:39:35PM +0300, Leonard Crestez wrote:
> The imx6sl soc has gpu_2d and gpu_vg, no 3d support:
> 
> etnaviv-gpu 2200000.gpu: model: GC320, revision: 5007
> etnaviv-gpu 2204000.gpu: model: GC355, revision: 1215
> 
> The IP blocks seem to be already supported.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
