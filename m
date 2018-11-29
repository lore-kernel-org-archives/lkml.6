Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C8EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A6B20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A6B20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbeK3C7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:59:01 -0500
Received: from verein.lst.de ([213.95.11.211]:44303 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbeK3C7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:59:01 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1EDD568B02; Thu, 29 Nov 2018 16:53:11 +0100 (CET)
Date:   Thu, 29 Nov 2018 16:53:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Clark <robdclark@gmail.com>
Cc:     hch@lst.de, Vivek Gautam <vivek.gautam@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH v3 1/1] drm: msm: Replace dma_map_sg with dma_sync_sg*
Message-ID: <20181129155310.GA26537@lst.de>
References: <20181129140315.28476-1-vivek.gautam@codeaurora.org> <20181129141429.GA22638@lst.de> <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGvsFbXGkC+=4oq1xXnoC2EVX2J0k-GqShefcek1=uw4Lw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 09:25:43AM -0500, Rob Clark wrote:
> > As I told you before:  hell no.  If you spent the slightest amount of
> > actually trying to understand what you are doing here you'd know this
> > can't work.  Just turn on dma debugging and this will blow up in your
> > face.
> 
> you can tone it down..  we weren't the ones who created the dma/iommu
> mess, we are just trying to find a way to work around it

But you don't listen and take someone busy for a day as approval,
which is absolutely not the case.  Please wait for a day or two for
people to respond instead of forcing already NACKed patches again in
an act of passive agression.
