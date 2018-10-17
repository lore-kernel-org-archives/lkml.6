Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19773ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD9B21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD9B21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJQPOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:14:18 -0400
Received: from verein.lst.de ([213.95.11.211]:56863 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbeJQPOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:14:18 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 335C268C88; Wed, 17 Oct 2018 09:19:58 +0200 (CEST)
Date:   Wed, 17 Oct 2018 09:19:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-media@vger.kernel.org, linux-spi@vger.kernel.org,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] drm: sti: don't pass GFP_DMA32 to dma_alloc_wc
Message-ID: <20181017071958.GC23407@lst.de>
References: <20181013151707.32210-1-hch@lst.de> <20181013151707.32210-7-hch@lst.de> <CA+M3ks66FL-F8dk+UcG-gR8Gz4N6gz7eYuT_Ht_scw7foPaP0A@mail.gmail.com> <CA+M3ks6a-D4j425JGBof+ma3NX5Fo52k5fadRNRauexOBXuaaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks6a-D4j425JGBof+ma3NX5Fo52k5fadRNRauexOBXuaaw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 02:41:23PM +0200, Benjamin Gaignard wrote:
> Le lun. 15 oct. 2018 à 11:12, Benjamin Gaignard
> <benjamin.gaignard@linaro.org> a écrit :
> >
> > Le sam. 13 oct. 2018 à 17:17, Christoph Hellwig <hch@lst.de> a écrit :
> > >
> > > The DMA API does its own zone decisions based on the coherent_dma_mask.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> 
> Christoph do you plan to merge this patch on your own tree ? or would
> like I put it directly in drm-misc-next branch ?

Please pull it in through drm-misc-next, thanks!
