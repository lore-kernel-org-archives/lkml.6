Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeBSJgz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:36:55 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52293 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752372AbeBSJgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:36:54 -0500
X-Google-Smtp-Source: AH8x227N7Vd9tabot9vl3Jgc7sMvVE7634JxB3x8J/z1lEhlP5VB2r2Lm4D36Lv9nzXbuTaY9EJESg==
Date: Mon, 19 Feb 2018 10:36:50 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: Thinkpad X1 Carbon 3rd - Reducing the compressed framebuffer size
Message-ID: <20180219093650.avb4xipvflfd2kel@pali>
References: <20180206152143.vea6si7ncjj7sxyq@pali>
 <20180213085030.kiksdi2a7ksae5wz@pali>
 <20180213132726.GD5453@intel.com>
 <20180213133842.i5z5jj3sllorsy2w@pali>
 <20180213153654.GG5453@intel.com>
 <20180213160437.gy5luyygjvuktuqx@pali>
 <20180213161221.GK5453@intel.com>
 <20180213174341.abcjlfjymxbcz25t@pali>
 <20180213174556.GM5453@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180213174556.GM5453@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 February 2018 19:45:56 Ville Syrjälä wrote:
> On Tue, Feb 13, 2018 at 06:43:41PM +0100, Pali Rohár wrote:
> > On Tuesday 13 February 2018 18:12:21 Ville Syrjälä wrote:
> > > On Tue, Feb 13, 2018 at 05:04:37PM +0100, Pali Rohár wrote:
> > > > So it can be done only once after reboot? Or only prior to booting kernel?
> > > 
> > > Never.
> > 
> > Never? Now I'm lost. Why then dmesg message instruct user to try set up
> > it in BIOS if you say it is never possible?
> 
> You can change it in the BIOS. No way to change it from the operating system.

Hi! Can you explain it a bit more?

What does it mean "in BIOS"? Prior switching from 16bit real mode to
protected or long? Or before exiting EFI boot services? Or before
booting kernel (when initialize memory mapping)?

I still do not see reason nor understand why this cannot be possible
either in bootloader (e.g. grub2) or prior to loading bootloader which
runs in protected or long mode.

It is because BIOS uses some undocumented call/procedure which sets that
amount of memory and it is unknown how to do it?

-- 
Pali Rohár
pali.rohar@gmail.com
