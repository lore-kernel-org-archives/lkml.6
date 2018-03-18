Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754637AbeCRMzY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:55:24 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39155 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754315AbeCRMwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:52:40 -0400
X-Google-Smtp-Source: AG47ELuxH6N5ZSBWv4CTNpfYnd0RTTDJrXPMgrdmLv4dPrGAHrdcCxfLamQUQZ/xA6Zl6+cgqWQhBQ==
Date: Sun, 18 Mar 2018 07:52:37 -0500
From: Rob Herring <robh@kernel.org>
To: Harald Geyer <harald@ccbib.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>, info@olimex.com
Subject: Re: [PATCHv2 2/5] arm64: dts: allwinner: a64: Add watchdog
Message-ID: <20180318031909.u5s4ttzxmta7e4sa@rob-hp-laptop>
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-3-harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315162510.11669-3-harald@ccbib.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 04:25:07PM +0000, Harald Geyer wrote:
> Add a watchdog node for the A64, automatically enabled on all boards.
> Since the device is compatible with an existing driver, we only reserve
> a new compatible string to be used together with the fall back.
> Tested on Olimex Teres-I.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
> changes since v1:
>  * add and use a specific compatible string
> 
>  Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 6 ++++--
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi            | 7 +++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
