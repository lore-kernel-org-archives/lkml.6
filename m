Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeEQHR0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:17:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:43993 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbeEQHRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:17:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,409,1520924400";
   d="scan'208";a="42511863"
Date: Thu, 17 May 2018 10:17:20 +0300
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Chen <jasonx.z.chen@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Alan Chiang <alanx.chiang@intel.com>, Tomasz Figa <tfiga@chromium.org>,
        Jacopo Mondi <jacopo@jmondi.org>, Rob Herring <robh@kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the v4l-dvb tree
Message-ID: <20180517071720.rb6sdozr5bwy543e@paasikivi.fi.intel.com>
References: <20180517073702.5497e72e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517073702.5497e72e@canb.auug.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 07:37:02AM +1000, Stephen Rothwell wrote:
> Hi Mauro,
> 
> Commit
> 
>   af76c93aa36d ("media: cadence: csi2rx: Fix csi2rx_start error handling")
> 
> is missing a Signed-off-by from its committer.

Mauro's SoB line is indeed missing. I wonder what happened.

> 
> Commits
> 
>   c578c7710712 ("media: imx258: Add imx258 camera sensor driver")
>   3a8fdc1426c3 ("media: dw9807: Add dw9807 vcm driver")
>   2f9c1c88369f ("media: dt-bindings: Add bindings for Dongwoon DW9807 voice coil")
> 
> are missing a Signed-off-by from their author.

Thanks for pointing this out. We'll be more careful going forward.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
