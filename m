Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeECPls (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:41:48 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:53670 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbeECPlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:41:46 -0400
Date: Thu, 3 May 2018 11:41:34 -0400
From: Rich Felker <dalias@libc.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Rob Landley <rob@landley.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to
 device tree
Message-ID: <20180503154134.GE1392@brightrain.aerifal.cx>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
 <c1ec211d-cbe2-1139-edb0-8baa0e7364e8@physik.fu-berlin.de>
 <8c75b447-fc14-871e-1a04-733132527b65@landley.net>
 <E7B2D113-C30D-4A32-AFB6-DC91DDADE0E8@physik.fu-berlin.de>
 <20171117191706.GF1627@brightrain.aerifal.cx>
 <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
 <20180105212857.GR1627@brightrain.aerifal.cx>
 <20180503013708.GC1392@brightrain.aerifal.cx>
 <20180503023320.GD1392@brightrain.aerifal.cx>
 <048ab147-21b8-045d-d21c-e1be2dd0e954@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <048ab147-21b8-045d-d21c-e1be2dd0e954@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 12:07:38PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Rich!
> 
> On 05/03/2018 04:33 AM, Rich Felker wrote:
> >I found the U-Boot stuff here:
> >
> >https://ja.osdn.net/users/ysato/pf/uboot/wiki/FrontPage
> >
> >but I'm not sure how to install it yet. Will try to figure it out.
> 
> Interesting. It seems the HDL-160U uses u-boot instead of lilo which
> is used on my USL-5P. Both are based on the LANDISK platform though.
> I wonder whether it is possible to convert the USL-5P to use u-boot
> instead of the very limited lilo.
> 
> As for the kernel configuration, for USL-5P, I had to use the kernel
> configuration attached to this mail. One important configuration setting
> is CONFIG_SH_PCLK_FREQ which has to be set to "33250000" otherwise
> the kernel won't boot properly.
> 
> I still have my USL-5P ready to be set up for testing a new kernel
> image with the device tree patches merged. Although I still don't
> know how to enable the internal (pseudo) IDE controller.
> 
> @Yoshinori:
> 
> Did the HDL-160U LANDISK device you have use u-boot by default or
> did you convert it from lilo?

The above U-Boot seems to be a version that's installed in the MBR and
then loads a second-stage program (from where, though?). It's not a
flash rom replacement as far as I can tell -- at least I never did
anything with the flash, and I think before I loaded this disk image,
it was using lilo. I probably still have the original drive that was
in it, with whatever that was booting from.

Rich
