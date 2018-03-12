Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932315AbeCLOHt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:07:49 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:40582 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbeCLOHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:07:46 -0400
X-Google-Smtp-Source: AG47ELuWjN4xkk1UWDZ8XQjK8FAar8lJkPFoxNMU4rP+IS7B9/r+/0Y6K3NSPRlU5gS/+Jm2dFGB1w==
Date: Mon, 12 Mar 2018 14:07:42 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: JeffyChen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/3] mfd: syscon: Set name of regmap_config
Message-ID: <20180312140742.vazjujloyn5l72nu@dell>
References: <20180306110403.14438-1-jeffy.chen@rock-chips.com>
 <5A9EAC92.4050702@rock-chips.com>
 <20180307102006.GA7290@sirena.org.uk>
 <5A9FC3E0.5020600@rock-chips.com>
 <20180307105731.GB7290@sirena.org.uk>
 <20180307165405.ltuobrr53vko4do7@dell>
 <20180307165738.GK7290@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180307165738.GK7290@sirena.org.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Mar 2018, Mark Brown wrote:

> On Wed, Mar 07, 2018 at 04:54:05PM +0000, Lee Jones wrote:
> > On Wed, 07 Mar 2018, Mark Brown wrote:
> > > On Wed, Mar 07, 2018 at 06:50:08PM +0800, JeffyChen wrote:
> 
> > > Yes, like I say I think that's a good idea anyway - that sort of usage
> > > is the reason we've got the facility to set an explicit name.
> 
> > Is that an Ack?
> 
> No, it looked like the change was only for MFD?

Right, but you can still Review/Ack patches from other subsystems.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
