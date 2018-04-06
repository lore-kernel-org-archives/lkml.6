Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeDFTVz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 15:21:55 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:43386 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751298AbeDFTVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 15:21:54 -0400
Date: Fri, 6 Apr 2018 21:21:46 +0200
From: Willy Tarreau <w@1wt.eu>
To: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Cc: linux-kernel@vger.kernel.org, vadim.lomovtsev@cavium.com
Subject: Re: [Question] patch posting process
Message-ID: <20180406192146.GA384@1wt.eu>
Reply-To: linux-kernel@vger.kernel.org
References: <20180406182916.GA15772@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406182916.GA15772@localhost.localdomain>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vadim,

On Fri, Apr 06, 2018 at 11:29:16AM -0700, Vadim Lomovtsev wrote:
> Hi all,
> 
> I bring my Apologise for wasting your time, but ..

Questions about doing things right rarely are a waste of time if they save
others from having to do useless work!

> May I ask for some clarification.. When we're speaking of 'posting patches shortly'
> does it mean to send them in next few hours ?
> Or would it be more acceptable to post one version per day
> even for very small changes in between ?
> 
> Kernel posting guides says that one should wait for about a week for respond,
> but in my case I've got feedback rather quickly (thanks a lot for that!)
> and I'd assume that I can proceed with posting next version.
> 
> So, what is the proper approach here - should one wait day or two
> before posting next version even if changes are very simple ?

Generally speaking, it's better to proceed ASAP. Reviewing patches requires
some concentration and often some time to get into the context. Speaking for
myself only, when I'm reviewing patches (I reserve time to do it), I prefer
to get 3 round trips the same day than one per week and each time having to
try to recall what it was about and what I proposed.

Also some people may only do that on spare time, week-ends or dedicated day
in the week. If you sit on their e-mail for no reason, you expose yourself
to the risk of having to wait for the next feedback. This is where the week
comes from. Another nice side effect of the week delay is that some people
send a first version for reviewing and figure by themselves that this
version is bogus, then send a fixed version. That reduces the number of
required work for reviewers.

On the other hand, it's not nice to rush quick updates without verifying
that you properly addressed all reported points (addressed either in code
or discussion). Thus my recommendation would be that if you can iterate
one or two extra rounds the same day, that's generally much better. And
in any case if the reviewer doesn't have more time to assign to you, he
will switch to something else and you'll have to wait. Thus the good rule
could be that ideally reviewers should not needlessly be waiting for you.

One important point however is *not* to send multiple versions of the
same series without waiting for a review. Someone might already be reading
your patchset and be pissed off by discovering he's reading outdated
code. Reserve this for the cases where you've let a huge bug slip
through.

Just my two cents, others will very likely have other advices.

Willy
