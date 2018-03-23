Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeCWOQ1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:16:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:5734 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751699AbeCWOQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:16:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,350,1517904000";
   d="scan'208";a="210742046"
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: DRI <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@linux.ie>,
        Stephen Rothwell <sfr@canb.auug.org.au>
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <20180323115018.1ae3ca1d@canb.auug.org.au>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
References: <20180322132129.6b953166@canb.auug.org.au>
 <20180323115018.1ae3ca1d@canb.auug.org.au>
Message-ID: <152181458133.5713.10693056590259814245@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: [Intel-gfx] linux-next: manual merge of the drm-intel tree with Linus'
 tree
Date: Fri, 23 Mar 2018 16:16:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Rothwell (2018-03-23 02:50:18)
> Hi all,
> 
> On Thu, 22 Mar 2018 13:21:29 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the drm-intel tree got a conflict in:
> > 
> >   drivers/gpu/drm/i915/gvt/scheduler.c
> > 
> > between commit:
> > 
> >   fa3dd623e559 ("drm/i915/gvt: keep oa config in shadow ctx")
> > 
> > from Linus' tree and commit:
> > 
> >   b20c0d5ce104 ("drm/i915/gvt: Update PDPs after a vGPU mm object is pinned.")
> > 
> > from the drm-intel tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.

Hi Stephen,

Thanks for solving this, the resolution is correct.

You may want to replace Daniel, as the recipient here, with the current
i915 maintainers to get a faster feedback next time :)

<SNIP>

> This is now a conflict between the drm tree and Linus' tree.
> 

My bad for not highlighting the merge conflict in my PR to Dave. He
probably did not notice, getting the resolution automatically from
drm-rerere, I'd guess. I've noted it in the ever improving draft of
things to remember with the PRs.

I'm very much currently flying based on what the previous PR authors
have remembered to tell me. But after 4.17, the cycle is complete and we
all "have been there, done that", and you can expect less of a turbulence.

(We'll probably have more magnificent documentation, too.)

Regards, Joonas

> -- 
> Cheers,
> Stephen Rothwell
> 
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
