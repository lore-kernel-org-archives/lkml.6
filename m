Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756558AbeDFNxu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:53:50 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:35104 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752846AbeDFNxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:53:45 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2]  drm: Add Thine THC63LVD1024 LVDS decoder bridge
Date: Fri, 06 Apr 2018 16:53:43 +0300
Message-ID: <6903975.GkMFuzh9fq@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1523020092-25540-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1523020092-25540-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w36Drtfv016733

Hi Jacopo,

On Friday, 6 April 2018 16:08:05 EEST Jacopo Mondi wrote:
> Hello,
>    this series enables HDMI display on V3M Eagle board.
> 
> The series is based on Geert's "renesas-drivers-2018-04-03-v4.16" with
> THC63LVD1024 driver on top (cfr. my in review series:
> "[PATCH v7 0/2]  drm: Add Thine THC63LVD1024 LVDS decoder bridge")

This isn't a good base for development, as you would pull way too many 
dependencies in. Could you please base v8 on top of v4.17-rc1 (or if you get 
to post it before v4.17-rc1 gets merged, you can use Linus' master, as the 
ARM64 DT pull requests for v4.17-rc1 have been merged) ? It will then be ready 
for Simon to pull in his v4.18 branch.

> This series includes some preliminary work from Sergei and Niklas. I have
> reworked the two final patches from Niklas to enable DU first, add the LVDS
> decoder node, and finally add the ADV7511W chip and enable HDMI output.
> 
> A branch for testing is available at:
> git://jmondi.org/linux v3m/renesas-drivers-2018-04-03-v4.16/v7-eagle-dts
> 
> Thanks
>    j
> 
> Jacopo Mondi (2):
>   arm64: dts: renesas: eagle: Enable DU
>   arm64: dts: renesas: eagle: Add LVDS decoder
> 
> Niklas Söderlund (2):
>   arm64: dts: renesas: r8a77970: add the LVDS instance
>   arm64: dts: renesas: eagle: Add ADV7511W and HDMI output
> 
> Sergei Shtylyov (3):
>   arm64: dts: renesas: r8a77970: add FCPVD support
>   arm64: dts: renesas: r8a77970: add VSPD support
>   arm64: dts: renesas: r8a77970: add DU support
> 
>  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts | 89 +++++++++++++++++++++++
>  arch/arm64/boot/dts/renesas/r8a77970.dtsi      | 73 +++++++++++++++++++++
>  2 files changed, 162 insertions(+)
> 

-- 
Regards,

Laurent Pinchart
