Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932298AbeE2HJY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932114AbeE2HJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:09:19 -0400
Date: Tue, 29 May 2018 12:39:15 +0530
From: Vinod <vkoul@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Frank Mori Hess <fmh6jj@gmail.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Subject: Re: Revert "dmaengine: pl330: add DMA_PAUSE feature"
Message-ID: <20180529070915.GF5666@vkoul-mobl>
References: <06f54061-c537-b399-e493-ec2cdf4def5d@samsung.com>
 <20180515062144.GC13271@vkoul-mobl>
 <CAJz5Open++Dj=a4ty-JbnZBFoqbMQKU6qYumJKSRMRLp_3erSw@mail.gmail.com>
 <20180517041946.GQ13271@vkoul-mobl>
 <CAJz5Opfep+TL0k_3kG7uQc_nU-BdFy1wsD1jo1agwtSvw0JibQ@mail.gmail.com>
 <CGME20180518040358epcas2p353b0096d33116ca78a03b16d24569813@epcas2p3.samsung.com>
 <20180518040349.GB2932@vkoul-mobl>
 <7f0b7404-ee12-977f-02a4-a463d1873aee@samsung.com>
 <20180518072112.GG2932@vkoul-mobl>
 <20180529051745eucas1p2ee6ec3e34f075d255c87f8f54a626784~zBcpaqmAb1928519285eucas1p2H@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529051745eucas1p2ee6ec3e34f075d255c87f8f54a626784~zBcpaqmAb1928519285eucas1p2H@eucas1p2.samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-05-18, 07:17, Marek Szyprowski wrote:
> Hi Vinod,
> 
> On 2018-05-18 09:21, Vinod wrote:
> > On 18-05-18, 08:28, Marek Szyprowski wrote:
> >> Hi Vinod,
> >>
> >> Okay, I see that in theory, there are some tricky bits in implementing DMA
> >> support in UART drivers. On the other hand there are already drivers
> >> with seems
> >> to be working fine. This discussion is about revert of the feature
> >> present in
> >> pl330 driver, which is required by other in-kernel driver without proper
> >> fix to
> >> them.
> >>
> >> Can we drop it for now and discuss what and how should be implemented to
> >> make
> >> everyone happy, without any regressions?
> > Sure am dropping the revert, we can always bring it back if it is required
> 
> This revert is still in your -next branch. Do you plan to update it as well?

I dont send it to linus and merge topic/* into for-linus and send. It gets
updated on rebase on -rc1.

-- 
~Vinod
