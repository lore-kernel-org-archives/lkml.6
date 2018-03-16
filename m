Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeCPGiF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 02:38:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43312 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeCPGiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 02:38:03 -0400
X-Google-Smtp-Source: AG47ELvMKzc5P9TQAzyevukGiUstTD96kEruOzr4FHEOqyqVw+RSUOiC1/W+SglGE+AAn0E0v98N0Q==
Date: Fri, 16 Mar 2018 12:07:53 +0530
From: afzal mohammed <afzal.mohd.ma@gmail.com>
To: Harald Geyer <harald@ccbib.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>, info@olimex.com
Subject: Re: [PATCHv2 5/5] arm64: allwinner: a64: Add support for TERES-I
 laptop
Message-ID: <20180316063753.GB3415@afzalpc>
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-6-harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315162510.11669-6-harald@ccbib.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 15, 2018 at 04:25:10PM +0000, Harald Geyer wrote:
> The TERES-I is an open hardware laptop built by Olimex using the
> Allwinner A64 SoC.
> 
> Add the board specific .dts file, which includes the A64 .dtsi and
> enables the peripherals that we support so far.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>

Received only patch 4 & 5 in my inbox, receive path was via
linux-kernel rather than linux-arm-kernel, but in both archives all
patches are seen (though threading seems not right), probably missing
patches are due to issue gmail have with LKML,

so had to pull the series from patchwork, for the series,

Tested-by: afzal mohammed <afzal.mohd.ma@gmail.com>

afzal
