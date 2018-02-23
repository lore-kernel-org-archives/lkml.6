Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeBWOwC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:52:02 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:52603 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbeBWOwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:52:00 -0500
Date: Fri, 23 Feb 2018 15:51:56 +0100
From: Simon Horman <horms@verge.net.au>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: arnd@arndb.de, geert@linux-m68k.org, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] R-Car M3-N DTS fixes
Message-ID: <20180223145155.skbg6g3c5ic6yfg6@verge.net.au>
References: <1519393259-26108-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519393259-26108-1-git-send-email-jacopo+renesas@jmondi.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 02:40:52PM +0100, Jacopo Mondi wrote:
> Hello,
>    in this second iteration I have fixed two remarks from Geert received on
> v1:
> - Extend "du" address length to include third channel
> - Move usb2_phy1 device node next to usb2_phy0
> 
> Two minor nits were not addressed:
> - "placeholder" comment position not changed to maintain consistency with
>   placeholders in M3-W. When they'll get changed, let's change all of them at
>   the same time.
> - The addresses block sizes (and multiple address range blocks) are still there
>   (next time we can consider dropping the unit address from place-holder nodes
>   and do not add any "reg" property at all, until DTC won't start complaining
>   about this as well)
> 
> All patches but the newly introduced 7/7 now have Geert's Reviewed-by tag.
> 
> Simon: as per v1, this series is based on my M3-N enablement series, last
> patch on Ether-AVB excluded.
> 
> Thanks
>    j
> 
> v1 -> v2:
> - Extend "du" address length to include third channel
> - Move usb2_phy1 node next to usb2_phy0
> 
> Jacopo Mondi (7):
>   arm64: dts: renesas: r8a77965: Add "reg" properties
>   arm64: dts: renesas: r8a77965: Add #address-cells and #size-cells
>   arm64: dts: renesas: r8a77965: Remove stale reg property
>   arm64: dts: renesas: r8a77965: Add #phy-cells property
>   arm64: dts: renesas: r8a77965: Add #pwm-cells property
>   arm64: dts: renesas: r8a77965: Add #interrupt-cells property
>   arm64: dts: renesas: r8a77965: Move usb2_phy1 up
> 
>  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 89 +++++++++++++++++++++++++++++--

Thanks, applied.
