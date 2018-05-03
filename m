Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeECI42 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:56:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:62072 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751111AbeECI40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:56:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,357,1520924400";
   d="scan'208";a="221290080"
Date: Thu, 3 May 2018 14:31:13 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Frank Mori Hess <fmh6jj@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com
Subject: Re: [PATCH] Revert "dmaengine: pl330: add DMA_PAUSE feature"
Message-ID: <20180503090112.GS6014@localhost>
References: <2484918.HKVQc3yJkt@bear>
 <20180502043230.GQ6014@localhost>
 <CAJz5OpfTVD7aEH8DK-nSdSrbaS-1DcSK+44FKHkej59KDUX=dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJz5OpfTVD7aEH8DK-nSdSrbaS-1DcSK+44FKHkej59KDUX=dw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 10:37:09AM -0400, Frank Mori Hess wrote:
> On Wed, May 2, 2018 at 12:32 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Sat, Apr 28, 2018 at 05:50:58PM -0400, Frank Mori Hess wrote:
> >> This reverts commit 88987d2c7534a0269f567fb101e6d71a08f0f01d.
> >>
> >
> > I am dropping the orignal patch for queue, so no need for revert patch.
> >
> 
> I don't understand, 88987d2c7534a0269f567fb101e6d71a08f0f01d made it
> into the mainline kernel in 2015?

Ah looks like i misunderstood the revert, will fix this up

-- 
~Vinod
