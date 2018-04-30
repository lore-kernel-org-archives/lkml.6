Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbeD3HeH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:34:07 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:42214 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeD3HeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:34:04 -0400
Date: Mon, 30 Apr 2018 09:34:00 +0200
From: Simon Horman <horms@verge.net.au>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/11] arm64: dts: r8a77965-salvator-x: Enable DU
 external clocks and HDMI
Message-ID: <20180430073400.6prb2uvb6esslzqb@verge.net.au>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
 <20180427165722.19445-11-kieran.bingham+renesas@ideasonboard.com>
 <3691864.jEUybrQDu7@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3691864.jEUybrQDu7@avalon>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 12:34:26AM +0300, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Friday, 27 April 2018 19:57:21 EEST Kieran Bingham wrote:
> > The DU1 external dot clock is provided by the fixed frequency clock
> > generator X21, while the DU0 and DU3 clocks are provided by the
> > programmable Versaclock5 clock generator.
> > 
> > Enable the clocks, and the HDMI encoder for the M3-N Salvator-X board
> > and hook it up to the HDMI connector.
> > 
> > Based on patches from Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > 
> > Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, applied.
