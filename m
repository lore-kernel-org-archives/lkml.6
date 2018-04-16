Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753065AbeDPP2t (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:28:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:61174 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752273AbeDPP2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:28:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,459,1517904000";
   d="scan'208";a="34660076"
Date: Mon, 16 Apr 2018 21:03:17 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Frank Mori Hess <fmh6jj@gmail.com>
Cc: dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dmaengine: pl330: flush before wait, and add dev
 burst support.
Message-ID: <20180416153315.GP6014@localhost>
References: <20180311150151.GB15443@localhost>
 <2863317.1ZoR41yQkl@bear>
 <CAJz5OpdV1=L3fsQESZusAp8Cir9wE-VqPXqBa=zOGjBcPE78DA@mail.gmail.com>
 <20180410153718.GS6014@localhost>
 <CAJz5Opdx26WZ-M8q2UayWz3o6SmR6VJMqUetQsX8k7YotK5XGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJz5Opdx26WZ-M8q2UayWz3o6SmR6VJMqUetQsX8k7YotK5XGg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 15, 2018 at 02:12:30PM -0400, Frank Mori Hess wrote:
> On Tue, Apr 10, 2018 at 11:37 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> >>
> >> Hi, what is the state of this patch?  I just noticed in patchwork it
> >> is now listed as "Not applicable"?  The original broken-by-wordwrap
> >> patch is listed as "Accepted"?
> >>
> >> https://patchwork.kernel.org/project/linux-dmaengine/list/?submitter=178687&state=*
> >
> > That is not correct state, my script would update as not applicable when it
> > doesn't find patch in my queue..
> >
> >> I found it has a bug handling dregs btw, I'll include a fix for that
> >> in the next version or as a follow-on patch as appropriate.
> >
> > Looks like I have missed this one somehow, so please update the patch with
> > fix and I shall look into it.
> >
> 
> Ok, I tested the v4 patch and it turns out it was a false alarm about
> the bug in handling dregs.  It works fine.  I've registered in the
> dmaengine patchwork, and changed the state of the v4 patch back to
> "new".

Can you please repost this one after rebasing to dmaengine -next

-- 
~Vinod
