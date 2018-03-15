Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeCORGW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:06:22 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:40921 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752006AbeCORGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:06:13 -0400
X-Google-Smtp-Source: AG47ELtjEklbRPeywV8qeqh9JXXEL/TOecuSlALovmuSo7JeKI8eFNWOIqAh4hYLsD+EVV9Up1CnKQ==
Date: Thu, 15 Mar 2018 22:36:06 +0530
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
Subject: Re: arm64: allwinner: Add support for TERES I laptop
Message-ID: <20180315170606.GA3635@afzalpc>
References: <20180312161050.7647-1-harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312161050.7647-1-harald@ccbib.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 12, 2018 at 04:10:45PM +0000, Harald Geyer wrote:
> This series adds support for the TERES I open hardware laptop produced
> by olimex. With these patches and a bootloader capable of setting up
> simple framebuffer the laptop is quite useable.

Thanks for the patches

w/ defconfig could reach to prompt via serial console using audio
jack.

And just by enabling PWM_SUN4I & FB_SIMPLE, laptop could function
standalone as well.

Suggestions (feel free to ignore):

1. seems currently only review comment pending is on simple
framebuffer, perhaps you can proceed removing just that so that a
basic bootable system can be achieved at the earliest (iiuc, anyway
drm would be the final solution for display)

2. in next revision (if), may be you can put keywords DIY and/or Open
Hardware (irrespective of whatever exactly that means) Laptop in the
subject itself, that might bring more interest/eyeballs, especially at
this time of ME & so on.

Regards
afzal
