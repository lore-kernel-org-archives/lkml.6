Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934337AbeCGQyT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:54:19 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:52901 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934135AbeCGQyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:54:09 -0500
X-Google-Smtp-Source: AG47ELs5XxQBkMvRjVyRZFI0fb887s+nqfLHZDWNuapn8ZmERBQ/W5kLCCqcPycGvt40m1QpQ7yx5A==
Date: Wed, 7 Mar 2018 16:54:05 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: JeffyChen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/3] mfd: syscon: Set name of regmap_config
Message-ID: <20180307165405.ltuobrr53vko4do7@dell>
References: <20180306110403.14438-1-jeffy.chen@rock-chips.com>
 <5A9EAC92.4050702@rock-chips.com>
 <20180307102006.GA7290@sirena.org.uk>
 <5A9FC3E0.5020600@rock-chips.com>
 <20180307105731.GB7290@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180307105731.GB7290@sirena.org.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Mar 2018, Mark Brown wrote:

> On Wed, Mar 07, 2018 at 06:50:08PM +0800, JeffyChen wrote:
> 
> > so i sent this patch to fix that by using the of_node name to create
> > debugfs.
> 
> > but later i found we have:
> > commit a430ab205d29e7d1537b220fcf989b8080d8267f
> > Author: Fabio Estevam <fabio.estevam@nxp.com>
> > Date:   Mon Mar 5 15:52:09 2018 -0300
> 
> >     regmap: debugfs: Disambiguate dummy debugfs file name
> 
> > which would fix that in another way by naming dummy0, dummy1, dummy2.
> 
> > even if the issue is fixed, i wonder could we still have this patch to make
> > it more readable:
> 
> Yes, like I say I think that's a good idea anyway - that sort of usage
> is the reason we've got the facility to set an explicit name.

Is that an Ack?

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
