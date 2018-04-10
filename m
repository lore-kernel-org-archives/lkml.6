Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeDJRvL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:51:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752434AbeDJRvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:51:08 -0400
Date: Tue, 10 Apr 2018 12:51:05 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        lpechacek@suse.com, nstange@suse.de
Subject: Re: [PATCH] selftests/livepatch: introduce tests
Message-ID: <20180410175105.eghfnktjq55vaxto@treble>
References: <1522266588-11806-1-git-send-email-joe.lawrence@redhat.com>
 <1522266588-11806-2-git-send-email-joe.lawrence@redhat.com>
 <20180407023646.k3gjrgjwzhwgu6fq@treble>
 <20180408154231.ihnglqyya5nric4q@redhat.com>
 <20180409140549.q6jybx3zirnsl2pp@pathway.suse.cz>
 <alpine.LSU.2.21.1804101625090.8026@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1804101625090.8026@pobox.suse.cz>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 04:31:05PM +0200, Miroslav Benes wrote:
> 
> > > > I love this.  Nice work!
> 
> Yes, it looks really good.
> 
> > > > As you and Petr discussed, it would be nice to get rid of some of the
> > > > delays, and also the callback tests will be very important.
> > > 
> > > I've got v2 WIP that minimizes the delays, cleans up build flags, and
> > > adds a basic shadow variable test.
> > 
> > Sounds great.
> > 
> > > Since these tests are based on top of Petr's current patchsets for
> > > atomic replace and shadow variables, it probably makes sense for those
> > > to merge first.  I can post test results to his patchsets if that helps.
> > 
> > Sounds good to me. We could synchronize the merge. But I think that it
> > will not be a big deal if we would merge the atomic replace slightly
> > earlier if the tests needed some more love.
> 
> Well, it depends. Josh wants the patch first and then atomic replace. So 
> we can merge selftests for all features we currently have and tests for 
> atomic replace could go with it.

Well, I don't want to add additional work, if it's not needed.  Joe's
selftests are coming along nicely.  If the selftest patch is merged
shortly after Petr's set, that's fine with me.  Or maybe Petr can just
add Joe's patch to the end of his set.

-- 
Josh
