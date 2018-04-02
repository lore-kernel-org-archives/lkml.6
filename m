Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756931AbeDBTmn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 15:42:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753108AbeDBTmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 15:42:42 -0400
Date: Mon, 2 Apr 2018 13:42:38 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alvise Rigo <a.rigo@virtualopensystems.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: vfio/platform: Update sub-maintainer
Message-ID: <20180402134238.5e3b706d@w520.home>
In-Reply-To: <CAH47eN05NqdkZ8nM5=hC2YZm1ZXjUVmXzThtjOurtTQDjSdFFQ@mail.gmail.com>
References: <20180326194121.10256.27009.stgit@gimli.home>
        <20180402091920.2d923720@w520.home>
        <CAH47eN05NqdkZ8nM5=hC2YZm1ZXjUVmXzThtjOurtTQDjSdFFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Apr 2018 20:36:17 +0200
Alvise Rigo <a.rigo@virtualopensystems.com> wrote:

> Hello Alex,
> 
> As I wrote in the other thread, it was OK by me to be reviewer. I
> though only Eric needed to ACK this patch as new sub-maintainer.
> 
> Is it too late for ACK-ing it now?
> 
> Acked-by: Alvise Rigo <a.rigo@virtualopensystems.com>

Hi Alvise,

Sorry, I consider that each person can really only ack for themselves
for MAINTAINERS entries, I'm not going to sign-up anyone without their
explicit approval, nor am I going to invent an Acked-by for a commit
log based on an informal comment.  This was also a little bit of a
test, given that we have no history, I was hoping for a proactive
review.  It's too late for this patch, but you're welcome to submit a
new patch adding yourself, preferably after some participation in this
area.  I'm not interested in adding entries only as tokens of company
lineage, we have attributes in source files and commit logs for that.
I do appreciate you making us aware of Baptiste's departure though so
that we can keep these entries current.  Thanks,

Alex

> On Mon, Apr 2, 2018 at 5:19 PM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> > On Mon, 26 Mar 2018 13:42:02 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >  
> >> Baptiste has changed positions and has not been active with
> >> vfio-platform, replace with the current, de-facto sub-maintainer
> >> Eric Auger.  Also add Alvise Rigo as a designated reviewer.
> >>
> >> Cc: Eric Auger <eric.auger@redhat.com>
> >> Cc: Alvise Rigo <a.rigo@virtualopensystems.com>
> >> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> >> ---
> >>  MAINTAINERS |    3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 205c8fc12a9c..c6680c189f2b 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -14687,7 +14687,8 @@ F:    include/linux/mdev.h
> >>  F:   samples/vfio-mdev/
> >>
> >>  VFIO PLATFORM DRIVER
> >> -M:   Baptiste Reynal <b.reynal@virtualopensystems.com>
> >> +M:   Eric Auger <eric.auger@redhat.com>
> >> +R:   Alvise Rigo <a.rigo@virtualopensystems.com>
> >>  L:   kvm@vger.kernel.org
> >>  S:   Maintained
> >>  F:   drivers/vfio/platform/
> >>  
> >
> > Receiving only Eric's review, I've committed this with only Eric's
> > entry and an updated commit log to reflect that.  Thanks,
> >
> > Alex  
