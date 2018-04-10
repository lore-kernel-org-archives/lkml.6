Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754086AbeDJObI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:31:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:56118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753047AbeDJObH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:31:07 -0400
Date: Tue, 10 Apr 2018 16:31:05 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, lpechacek@suse.com, nstange@suse.de
Subject: Re: [PATCH] selftests/livepatch: introduce tests
In-Reply-To: <20180409140549.q6jybx3zirnsl2pp@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.1804101625090.8026@pobox.suse.cz>
References: <1522266588-11806-1-git-send-email-joe.lawrence@redhat.com> <1522266588-11806-2-git-send-email-joe.lawrence@redhat.com> <20180407023646.k3gjrgjwzhwgu6fq@treble> <20180408154231.ihnglqyya5nric4q@redhat.com>
 <20180409140549.q6jybx3zirnsl2pp@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > > I love this.  Nice work!

Yes, it looks really good.

> > > As you and Petr discussed, it would be nice to get rid of some of the
> > > delays, and also the callback tests will be very important.
> > 
> > I've got v2 WIP that minimizes the delays, cleans up build flags, and
> > adds a basic shadow variable test.
> 
> Sounds great.
> 
> > Since these tests are based on top of Petr's current patchsets for
> > atomic replace and shadow variables, it probably makes sense for those
> > to merge first.  I can post test results to his patchsets if that helps.
> 
> Sounds good to me. We could synchronize the merge. But I think that it
> will not be a big deal if we would merge the atomic replace slightly
> earlier if the tests needed some more love.

Well, it depends. Josh wants the patch first and then atomic replace. So 
we can merge selftests for all features we currently have and tests for 
atomic replace could go with it.

> > These tests are basically a mash up of some of the tedious callback
> > Documentation and shadow variable sample livepatches.  Since there will
> > be a lot of duplication, should we just remove redundant doc/samples in
> > favor of these tests?
> 
> Yup, it does not make sense to maintain two copies of basically
> the same modules.

Yes, but I'd leave a basic sample module there (that is, the first sample 
we had should stay).

Libor and Nicolai from SUSE CCed. We have some internal tests as well and 
it would be great to join forces.

Regards,
Miroslav
