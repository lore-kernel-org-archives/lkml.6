Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbeECT2o (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 15:28:44 -0400
Received: from muru.com ([72.249.23.125]:40166 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbeECT2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 15:28:42 -0400
Date: Thu, 3 May 2018 12:28:38 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Droid 4: very confusing config around OHCI_OMAP3_HCD
Message-ID: <20180503192838.GY98604@atomide.com>
References: <20180503192510.GB32572@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503192510.GB32572@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180503 19:27]:
> Hi!
> 
> For power management experiments, I tried
> 
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_HCD_OMAP3=m
> CONFIG_USB_OHCI_HCD_PLATFORM=y
> 
> and could not find resulting .ko.
> 
> Help text says:
> 
> CONFIG_USB_OHCI_HCD_OMAP3:
> 
> This option is deprecated now and the driver was removed, use
> USB_OHCI_HCD_PLATFORM instead.
> 
> Enables support for the on-chip OHCI controller on
> OMAP3 and later chips.
> 
> Which may partly explain it. But if the option no longer does
> anything, why keep it? Certainly second part is confusing if option is
> NOP...

Yeah it's ohci-platform now, I think we decided to keep the old one
around to avoid breaking people's .config files for booting rather
than silently fail.

Regards,

Tony
