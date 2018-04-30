Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbeD3H3B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:29:01 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:42106 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbeD3H27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:28:59 -0400
Date: Mon, 30 Apr 2018 09:28:55 +0200
From: Simon Horman <horms@verge.net.au>
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/11] arm64: dts: r8a77965: Add VSP instances
Message-ID: <20180430072855.s2acmtnwji6czjc5@verge.net.au>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
 <20180427165722.19445-8-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427165722.19445-8-kieran.bingham+renesas@ideasonboard.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 05:57:18PM +0100, Kieran Bingham wrote:
> The r8a77965 has 4 VSP instances.
> 
> Based on a similar patch of the R8A7796 device tree
> by Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [Kieran: Rebased to top of tree, fixed sort orders]
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, applied.
