Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753736AbeCPLQx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:16:53 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:34213 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753424AbeCPLQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:16:51 -0400
Date: Fri, 16 Mar 2018 12:16:45 +0100
From: Simon Horman <horms@verge.net.au>
To: jacopo mondi <jacopo@jmondi.org>
Cc: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, magnus.damm@gmail.com, geert@linux-m68k.org,
        sergei.shtylyov@cogentembedded.com, robh+dt@kernel.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] arm64: dts: renesas: Add LVDS decoder to R-Car
 V3M Eagle
Message-ID: <20180316111644.k5ofsl5o5ethbnie@verge.net.au>
References: <1521130316-1221-1-git-send-email-jacopo+renesas@jmondi.org>
 <1521130316-1221-4-git-send-email-jacopo+renesas@jmondi.org>
 <20180316000004.GC3432@bigcity.dyn.berto.se>
 <20180316093953.GC31710@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180316093953.GC31710@w540>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 10:39:53AM +0100, jacopo mondi wrote:
> Hi Niklas,
>    thanks for review,
> 
> On Fri, Mar 16, 2018 at 01:00:04AM +0100, Niklas Söderlund wrote:
> > Hi Jacopo,
> >
> > Thanks for your patch.
> >
> > This one must depend on '[PATCH v2 0/5] arm64: dts: renesas: r8a77970:
> > enable HDMI output' or something similar not yet in renesas-drivers
> > repository correct?
> 
> Yes, I have listed dependencies of this series in my v1 cover letter:
> 
> ---------------------------------------------------------------------------
> The series is based on Laurent's drm/next/du branch with patches on top for:
> - Sergei: Enable PFC, I2c, GPIOs for r8a77970
> - Sergei: Add support for r8a77970 in DU and add display device nodes in
>   r8a77970 DTSI
> - Niklas: Connect DU LVDS output to HDMI bridge adv7511w in Eagle DTS
> - Sergei: fix video output on R8A77970
> 
> A base branch with these patches applied is available at
> git://jmondi.org/linux v3m/v4.16-rc3/base
> ---------------------------------------------------------------------------
> 
> My bad I have not reported this in all cover letters (and I have not
> reported the full name of the series)
> 
> PFC, GPIO and I2c support I have listed as dependencies seems to have
> landed in renesas-drivers, while I don't see yet:
> 
> Sergei:
> [PATCH v2 0/5] Add R8A77970/V3MSK LVDS/HDMI support
> 
> whose patches for r8a77970 dtsi are included in yours:
> [PATCH v2 0/5] arm64: dts: renesas: r8a77970: enable HDMI output
> 
> On top I also have Sergei's/Laurent's:
> [PATCH v4] v4l: vsp1: Fix video output on R8A77970

I have marked this patch as Deferred pending acceptance of the
dependencies. Please repost or otherwise ping me once the
dependencies are in place.
