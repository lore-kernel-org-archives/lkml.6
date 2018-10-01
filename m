Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B259C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21800206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21800206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeJBAXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:23:34 -0400
Received: from foss.arm.com ([217.140.101.70]:53288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeJBAXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:23:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8FAE7A9;
        Mon,  1 Oct 2018 10:44:40 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B89333F5B7;
        Mon,  1 Oct 2018 10:44:40 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 71F711AE3E30; Mon,  1 Oct 2018 18:45:04 +0100 (BST)
Date:   Mon, 1 Oct 2018 18:45:04 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Clark <robdclark@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sricharan <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v16 4/5] dt-bindings: arm-smmu: Add bindings for
 qcom,smmu-v2
Message-ID: <20181001174503.GA14755@arm.com>
References: <20180830144541.17740-1-vivek.gautam@codeaurora.org>
 <20180830144541.17740-5-vivek.gautam@codeaurora.org>
 <20181001121857.GA31488@arm.com>
 <CAL_Jsq+dSGXCiWsjLt00wu=s-ZW8M1pkQqKFWboc54M8gHFTYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+dSGXCiWsjLt00wu=s-ZW8M1pkQqKFWboc54M8gHFTYg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 12:36:09PM -0500, Rob Herring wrote:
> On Mon, Oct 1, 2018 at 7:18 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > On Thu, Aug 30, 2018 at 08:15:40PM +0530, Vivek Gautam wrote:
> > > Add bindings doc for Qcom's smmu-v2 implementation.
> > >
> > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > >  .../devicetree/bindings/iommu/arm,smmu.txt         | 39 ++++++++++++++++++++++
> > >  1 file changed, 39 insertions(+)
> >
> > It would be nice to have an Ack from a DT maintainer on this, since it's
> > adding new compatible strings...
> 
> I did...

Oops, sorry, missed that.

Will
