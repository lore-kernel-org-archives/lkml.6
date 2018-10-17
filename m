Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F4CECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F4D21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F4D21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeJQPOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:14:40 -0400
Received: from verein.lst.de ([213.95.11.211]:56886 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727292AbeJQPOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:14:40 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6FB3A68C95; Wed, 17 Oct 2018 09:20:20 +0200 (CEST)
Date:   Wed, 17 Oct 2018 09:20:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-media@vger.kernel.org, linux-spi@vger.kernel.org,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] media: sti/bdisp: don't pass GFP_DMA32 to
 dma_alloc_attrs
Message-ID: <20181017072020.GD23407@lst.de>
References: <20181013151707.32210-1-hch@lst.de> <20181013151707.32210-8-hch@lst.de> <CA+M3ks5KO-Yr_PEczaENhTfirthFz2gW1uv4bwZe5mjy3-jZyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks5KO-Yr_PEczaENhTfirthFz2gW1uv4bwZe5mjy3-jZyg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 11:12:55AM +0200, Benjamin Gaignard wrote:
> Le sam. 13 oct. 2018 à 17:18, Christoph Hellwig <hch@lst.de> a écrit :
> >
> > The DMA API does its own zone decisions based on the coherent_dma_mask.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Can you pick it up through the media tree?
