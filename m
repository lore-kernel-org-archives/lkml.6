Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935287AbeEIO7Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:59:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:42106 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934331AbeEIO7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:59:24 -0400
Date: Wed, 9 May 2018 08:59:20 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 jc_docs tree
Message-ID: <20180509085920.5fbb32f5@lwn.net>
In-Reply-To: <20180509132824.GA14503@andrea>
References: <20180509202508.15c3435a@canb.auug.org.au>
        <20180509132824.GA14503@andrea>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 May 2018 15:28:24 +0200
Andrea Parri <andrea.parri@amarulasolutions.com> wrote:

> > BTW, it would be nice if the the question "Why was this file removed?" was
> > answered by that jc_docs commit message ...  I actually wonder if this
> > file needs to return (I have no way of knowing).  
> 
> My bad; thanks for pointing this out.
> 
> Mmh... "why" would have been something like "the feature has no Kconfig". ;-)
> 
> I defer to your (community) decision regarding "if this file needs to return"
> (Cc-ing Ingo, who created the file and also suggested its removal); I remain
> available for preparing the patch to restore (and refresh) this file, should
> you agree with this approach.

So I'll confess that I balked on the lack of a changelog, but then decided
to proceed with the patch (and the other removal as well) due to the lack
of the Kconfig option.

Now that I look a little closer, I think the real issue is that the
"features" documentation assumes that there's a Kconfig option for each,
but there isn't in this case.  The lack of a Kconfig option does not,
this time around, imply that the feature has gone away.

I think that I should probably revert this patch in the short term.
Longer-term, it would be good to have an alternative syntax for "variable
set in the arch headers" to describe situations like this.

Make sense?

Thanks,

jon
