Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5728C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49FE206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeLRDgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:36:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:19254 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbeLRDgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:36:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 19:35:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,367,1539673200"; 
   d="scan'208";a="260312905"
Received: from wmiao1-mobl1.ccr.corp.intel.com ([10.255.29.79])
  by orsmga004.jf.intel.com with ESMTP; 17 Dec 2018 19:35:57 -0800
Message-ID: <1545104154.2052.2.camel@intel.com>
Subject: Re: [PATCH v6 0/4] Fixes for Tegra soctherm
From:   Zhang Rui <rui.zhang@intel.com>
To:     Wei Ni <wni@nvidia.com>, edubezval@gmail.com
Cc:     thierry.reding@gmail.com, daniel.lezcano@linaro.org,
        linux-tegra@vger.kernel.org, srikars@nvidia.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 18 Dec 2018 11:35:54 +0800
In-Reply-To: <74e77548-d10c-fd00-48c5-2b611529eaf5@nvidia.com>
References: <1544780993-20744-1-git-send-email-wni@nvidia.com>
         <74e77548-d10c-fd00-48c5-2b611529eaf5@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 五, 2018-12-14 at 17:54 +0800, Wei Ni wrote:
> Hi Rui,
> I moved get_trend() patch https://lkml.org/lkml/2018/11/20/643 in
> this
> serial.
> Since no more comments on these patches, will you take them?
> 
I think Eduardo will take care of this patch series.

thanks,
rui
> Thanks.
> Wei.
> 
> On 14/12/2018 5:49 PM, Wei Ni wrote:
> > 
> > This series fixed some issues for Tegra soctherm,
> > and add get_trend().
> > 
> > Main changes from v5:
> > 1. Move the get_trend() patch https://lkml.org/lkml/2018/11/20/643
> > into this serial.
> > 
> > Main changes from v4:
> > 1. fixed for the parsing sensor id.
> > 2. keep warning for missing critical trips.
> > 
> > Main changes from v3:
> > 1. updated codes for parsing sensor id, per Thierry's comments
> > 
> > Main changes from v2:
> > 1. add codes to parse sensor id to avoid registration
> > failure.
> > 
> > Main changes from v1:
> > 1. Acked by Thierry Reding <treding@nvidia.com> for the patch
> > "thermal: tegra: fix memory allocation".
> > 2. Print out the sensor name when register failed.
> > 2. Remove patch "thermal: tegra: fix coverity defect"
> > 
> > Wei Ni (4):
> >   thermal: tegra: remove unnecessary warnings
> >   thermal: tegra: fix memory allocation
> >   thermal: tegra: parse sensor id before sensor register
> >   thermal: tegra: add get_trend ops
> > 
> >  drivers/thermal/tegra/soctherm.c | 85
> > +++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 80 insertions(+), 5 deletions(-)
> > 
