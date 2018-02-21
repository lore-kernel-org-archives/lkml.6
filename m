Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754086AbeBURGv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:06:51 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:55750 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752269AbeBURGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:06:49 -0500
Date: Wed, 21 Feb 2018 18:06:44 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/19] ARM64: dts: Add Renesas R8A77965 SoC support
Message-ID: <20180221170643.qmwztqrqafj2pcyn@verge.net.au>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-9-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdVR6qCkBMYvnN5eqjiCgvtD1zW2gW0N=ZpAosYpp+Tj_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVR6qCkBMYvnN5eqjiCgvtD1zW2gW0N=ZpAosYpp+Tj_g@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 04:45:48PM +0100, Geert Uytterhoeven wrote:
> On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > Basic support for the Gen 3 R-Car M3-N SoC.
> >
> > Based on original work from:
> > Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Magnus Damm <damm+renesas@opensource.se>
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied with the patch subject updated to

arm64: dts: renesas: initial R8A77965 SoC device tree

Please use "arm64: dts: renesas:" as the prefix for Gen-3 DTS/DTSI patches.
