Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754007AbeEWFjt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 01:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753647AbeEWFjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 01:39:46 -0400
Date: Wed, 23 May 2018 11:09:43 +0530
From: Vinod <vkoul@kernel.org>
To: Frank Mori Hess <fmh6jj@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Subject: Re: Revert "dmaengine: pl330: add DMA_PAUSE feature"
Message-ID: <20180523053943.GB20991@vkoul-mobl>
References: <20180515062144.GC13271@vkoul-mobl>
 <CAJz5Open++Dj=a4ty-JbnZBFoqbMQKU6qYumJKSRMRLp_3erSw@mail.gmail.com>
 <20180517041946.GQ13271@vkoul-mobl>
 <CAJz5Opfep+TL0k_3kG7uQc_nU-BdFy1wsD1jo1agwtSvw0JibQ@mail.gmail.com>
 <20180518040349.GB2932@vkoul-mobl>
 <CAJz5OpfSanwNS7Z=3FapR97XZzjWF_J23HqVouxVnPn2HwkKLw@mail.gmail.com>
 <20180521091626.GB14654@vkoul-mobl>
 <CAJz5OpdW7ZgX_K-+6H_mkHhzRf1_km8Usf306_HrnD7qCztdpw@mail.gmail.com>
 <20180522033751.GB18351@vkoul-mobl>
 <CAJz5OpckWsRwBK5ZtrF11QG_C-W+qBJDroEWXN0de5Cc0XA=1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJz5OpckWsRwBK5ZtrF11QG_C-W+qBJDroEWXN0de5Cc0XA=1Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-18, 10:27, Frank Mori Hess wrote:
> On Mon, May 21, 2018 at 11:37 PM, Vinod Koul <vinod.koul@linaro.org> wrote:
> >
> > Well looks like even adding support for sync_pause doesn't solve your issue on
> > pl330. Do you want to move this to PIO mode then..?

The issue for which you requested the revert of pl330 pause

> I'm not sure what you think my issue is with the pl330, are you
> confusing me with Marek?  My position is that pause is unsupported by
> the pl330 at the hardware level.  Nothing the pl330.c driver or
> dmaengine api or 8250 serial driver does will change that.  That is
> why I sent a patch to remove pause support from pl330.c.  The rest is
> just trying to fix some bugs in mainline Linux I hit when I was a
> naive youngster who thought Linux support for the computer world's
> canonical serial uart could be counted on to move data from point A to
> point B.  In truth though, I've already concluded it's not worth it to
> slog though the linux kernel development process just to clean up
> other people's messes.  I've already fixed my issues out-of-tree.  I
> don't mind answering questions if anyone else cares about the issue
> though.  Other than that, I think I'll just be ghosting out now.

~Vinod
