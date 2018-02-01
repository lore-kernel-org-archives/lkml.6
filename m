Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754733AbeBATjt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 14:39:49 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44230 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754593AbeBATjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 14:39:42 -0500
X-Google-Smtp-Source: AH8x2259n9f6x1Qrjsyo3jMsyr4N2uXAznWLjrzCXHZ49HfDJ/EQERV0lZ4Re8n1lQMOrSbpQLXzMQ==
Date: Thu, 1 Feb 2018 20:39:31 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Cc: stern@rowland.harvard.edu, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, corbet@lwn.net
Subject: Re: [PATCH 2/2] MAINTAINERS: add the Memory Consistency Model
 subsystem
Message-ID: <20180201193931.GA4537@andrea>
References: <1517486666-11011-1-git-send-email-parri.andrea@gmail.com>
 <20180201134401.GE9182@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201134401.GE9182@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 01:44:01PM +0000, Will Deacon wrote:
> On Thu, Feb 01, 2018 at 01:04:26PM +0100, Andrea Parri wrote:
> > Integrate (and then remove) tools/memory-model/MAINTAINERS into the
> > main MAINTAINERS file. This way get_maintainer.pl can give a "right
> > answer" for tools/memory-model/.
> > 
> > Suggested-by: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> > ---
> >  MAINTAINERS                    | 16 ++++++++++++++++
> >  tools/memory-model/MAINTAINERS | 15 ---------------
> >  2 files changed, 16 insertions(+), 15 deletions(-)
> >  delete mode 100644 tools/memory-model/MAINTAINERS
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Makes a lot more sense having this in the top-level MAINTAINERS file.
> It might also make sense to add:
> 
>   F:	Documentation/memory-barriers.txt
> 
> as a separate patch now that we have a hit-list of memory model people
> who can help poor old Jon (who currently gets blamed by get_maintainer.pl).

This does make sense to me: I'll prepare/send such a patch tomorrow.

  Andrea


> 
> Will
