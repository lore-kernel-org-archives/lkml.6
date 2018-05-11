Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeEKBxl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 21:53:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:56260 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbeEKBxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 21:53:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,387,1520924400";
   d="scan'208";a="198432196"
Message-ID: <1526003610.19343.1.camel@intel.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the thermal
 tree
From: Zhang Rui <rui.zhang@intel.com>
To: Eduardo Valentin <edubezval@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 11 May 2018 09:53:30 +0800
In-Reply-To: <20180510021011.GA3765@localhost.localdomain>
References: <20180509214341.1d490677@canb.auug.org.au>
         <20180510021011.GA3765@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 三, 2018-05-09 at 19:10 -0700, Eduardo Valentin wrote:
> Hey Rui,
> 
> On Wed, May 09, 2018 at 09:43:41PM +1000, Stephen Rothwell wrote:
> > 
> > Hi Zhang,
> > 
> > Commits
> > 
> >   a2ace598c00a ("thermal: exynos: Reading temperature makes sense
> > only when TMU is turned on")
> >   f9cd6a904e6e ("thermal: exynos: Propagate error value from
> > tmu_read()")
> > 
> > are missing a Signed-off-by from their committer.
> Did you cherry-pick them instead of merging? If cherry-picking you
> have
> to add your Signed-off-by..
> 
I merged them, and then did a rebase to drop some of the patch, hmmm,
could that be the problem?
Anyway, I will re-merge your tree and push them out sometime tomorrow.

thanks,
rui
