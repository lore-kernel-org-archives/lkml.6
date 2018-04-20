Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeDTVw5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 17:52:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeDTVwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 17:52:55 -0400
Date: Fri, 20 Apr 2018 14:52:51 -0700
From: Darren Hart <dvhart@infradead.org>
To: Mario.Limonciello@dell.com
Cc: rdunlap@infradead.org, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: Kconfig: Fix dell-laptop dependency chain.
Message-ID: <20180420215251.GF11546@fury>
References: <1524246131-17621-1-git-send-email-mario.limonciello@dell.com>
 <858fbd0a-a387-e9f8-5017-1fff9638dd4d@infradead.org>
 <d7ec4d23554a4d92a2ed59354483900a@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7ec4d23554a4d92a2ed59354483900a@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 05:55:28PM +0000, Mario.Limonciello@dell.com wrote:
> 
> > -----Original Message-----
> > From: platform-driver-x86-owner@vger.kernel.org [mailto:platform-driver-x86-
> > owner@vger.kernel.org] On Behalf Of Randy Dunlap
> > Sent: Friday, April 20, 2018 12:53 PM
> > To: Limonciello, Mario; dvhart@infradead.org; Andy Shevchenko
> > Cc: LKML; platform-driver-x86@vger.kernel.org
> > Subject: Re: [PATCH] platform/x86: Kconfig: Fix dell-laptop dependency chain.
> > 
> > On 04/20/18 10:42, Mario Limonciello wrote:
> > > As reported by Randy Dunlap:
> > >>> WARNING: unmet direct dependencies detected for DELL_SMBIOS
> > >>>   Depends on [m]: X86 [=y] && X86_PLATFORM_DEVICES [=y]
> > >>> 	&& (DCDBAS [=m] ||
> > >>> DCDBAS [=m]=n) && (ACPI_WMI [=n] || ACPI_WMI [=n]=n)
> > >>>   Selected by [y]:
> > >>>   - DELL_LAPTOP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]
> > >>> && DMI [=y]
> > >>> && BACKLIGHT_CLASS_DEVICE [=y] && (ACPI_VIDEO [=n] ||
> > >>> 	ACPI_VIDEO [=n]=n)
> > >>> && (RFKILL [=n] || RFKILL [=n]=n) && SERIO_I8042 [=y]
> > >>>
> > >
> > > Right now it's possible to set dell laptop to compile in but this
> > > causes dell-smbios to compile in which breaks if dcdbas is a module.
> > >
> > > Dell laptop shouldn't select dell-smbios anymore, but depend on it.
> > >
> > > Fixes: 32d7b19 (platform/x86: dell-smbios: Resolve dependency error on
> > DCDBAS)
> > 
> > meta-comment: the SHA-1 ID should be the first 12 characters of the commit ID
> > according to Documentation/process/submitting-patches.rst.
> 
> Thanks for letting me, I didn't realize that.
> 
> Darren, let me know if you want me to resubmit with this adjustment or if you
> can adjust when you queue for testing.


Will fix locally.

-- 
Darren Hart
VMware Open Source Technology Center
