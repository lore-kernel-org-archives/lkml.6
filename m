Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeEQO1k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:27:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59520 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeEQO1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:27:39 -0400
Date: Thu, 17 May 2018 16:27:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] kernel: event: core: Change return type to vm_fault_t
Message-ID: <20180517142731.GV12217@hirez.programming.kicks-ass.net>
References: <20180414202831.GA20373@jordon-HP-15-Notebook-PC>
 <20180420082829.GE4064@hirez.programming.kicks-ass.net>
 <CAFqt6zb3N3qVVcUOvd2F4q2P3PYrOoU8M3c=qSZDEpHokHHBaQ@mail.gmail.com>
 <CAFqt6zaQKhijpVX6GrfwSx=_z7FOp_NoF9TTf2Gjgv+mg0TMSg@mail.gmail.com>
 <CAFqt6zaT=c87sSEU5dNs3AyWHthoe5c5iwkFGN1O1HrMsG=5_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zaT=c87sSEU5dNs3AyWHthoe5c5iwkFGN1O1HrMsG=5_A@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 07:55:13PM +0530, Souptick Joarder wrote:
> On Thu, May 10, 2018 at 7:54 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > On Fri, Apr 20, 2018 at 5:18 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >>> I'm fine with the patch, but shouldn't this be part of a larger series /
> >>> cocinelle script?
> >>>
> >>
> >> This one is trivial but many others are not.
> >> As part of this clean up we have fixed many
> >> existing bugs in fault handlers of drivers/
> >> file systems. Also we are replacing existing
> >> vm_insert_foo() with new vmf_insert_foo()
> >> in fault handlers (wherever applicable).
> >> Refer - 1c8f422059ae5da07db7406ab916203f9417e396
> >> in 4.17-rc1
> >
> > Any further comment on this patch ?
> 
> Peter, if no further comment, we would like to get this patch
> in queue for 4.18.

Nah, I still think you're doing this wrong by trickling single patches,
but have at.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
