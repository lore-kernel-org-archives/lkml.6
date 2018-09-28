Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A27ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2582A20676
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2582A20676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbeI1XvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:51:19 -0400
Received: from muru.com ([72.249.23.125]:57640 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeI1XvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:51:19 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4483780C0;
        Fri, 28 Sep 2018 17:30:56 +0000 (UTC)
Date:   Fri, 28 Sep 2018 10:26:30 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] ARM: dts: dra7: Fix up unaligned access setting for
 PCIe EP
Message-ID: <20180928172630.GI5662@atomide.com>
References: <20180925052151.9537-1-vigneshr@ti.com>
 <20180926172711.GW5662@atomide.com>
 <eb3bb7ba-e32d-aa0f-1877-985ab3d6fe4c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb3bb7ba-e32d-aa0f-1877-985ab3d6fe4c@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vignesh R <vigneshr@ti.com> [180928 05:31]:
> 
> 
> On Wednesday 26 September 2018 10:57 PM, Tony Lindgren wrote:
> > * Vignesh R <vigneshr@ti.com> [180924 22:25]:
> >> Bit positions of PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE and
> >> PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE in CTRL_CORE_SMA_SW_7 are
> >> incorrectly documented in the TRM. In fact, the bit positions are
> >> swapped. Update the DT bindings for PCIe EP to reflect the same.
> >>
> >> Fixes: d23f3839fe97 ("ARM: dts: DRA7: Add pcie1 dt node for EP mode")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Vignesh R <vigneshr@ti.com>
> >> ---
> >>
> >> This patch is split from v3 here:
> >> https://lore.kernel.org/patchwork/cover/967020/
> >> Patch can be applied standalone and has no dependencies on other patches
> >> in v3.
> > 
> > Hmm is this needed for v4.19-rc cycle or can this wait for
> > v4.20 merge window?
> > 
> 
> v4.20 should be fine.

OK thanks applying into omap-for-v4.20/dt then.

Tony
