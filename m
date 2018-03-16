Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeCPG20 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 02:28:26 -0400
Received: from mail-pl0-f50.google.com ([209.85.160.50]:38467 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeCPG2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 02:28:24 -0400
X-Google-Smtp-Source: AG47ELtgccQ8zL2y2T0hOf0RWEEGXB6DkBMIM4oGnXs9DgcZ1yjUMbjVAOYQ3UXf9Momx5Fvlv09Vg==
Date: Fri, 16 Mar 2018 11:58:16 +0530
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
Message-ID: <20180316062816.GA3415@afzalpc>
References: <20180312161050.7647-1-harald@ccbib.org>
 <20180315170606.GA3635@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315170606.GA3635@afzalpc>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 15, 2018 at 10:36:06PM +0530, afzal mohammed wrote:
> Thanks for the patches
> 
> w/ defconfig could reach to prompt via serial console using audio
> jack.
> 
> And just by enabling PWM_SUN4I & FB_SIMPLE, laptop could function
> standalone as well.
> 
> Suggestions (feel free to ignore):
> 
> 1. seems currently only review comment pending is on simple
> framebuffer, perhaps you can proceed removing just that so that a
> basic bootable system can be achieved at the earliest (iiuc, anyway
> drm would be the final solution for display)
> 
> 2. in next revision (if), may be you can put keywords DIY and/or Open
> Hardware (irrespective of whatever exactly that means) Laptop in the
> subject itself, that might bring more interest/eyeballs, especially at
> this time of ME & so on.

Realizing now that your v2 patches & above mail crossed.

afzal
