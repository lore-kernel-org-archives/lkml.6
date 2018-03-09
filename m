Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751082AbeCIMQx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:16:53 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38824 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeCIMQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:16:51 -0500
X-Google-Smtp-Source: AG47ELukrFrCcsR5nHQ/d6eX3KIitBl0DO/nD/piLmyT6X1yPuckihtTuUuhCcR3Hxr4yOBEkUdT+w==
Date: Fri, 9 Mar 2018 13:16:43 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: albert@sifive.com, Daniel Lustig <dlustig@nvidia.com>,
        stern@rowland.harvard.edu, Will Deacon <will.deacon@arm.com>,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@linux.vnet.ibm.com, akiyks@gmail.com, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] riscv/spinlock: Strengthen implementations with
 fences
Message-ID: <20180309121643.GA16716@andrea>
References: <20180308210303.GA2897@andrea>
 <mhng-994ef724-c752-4667-a119-8db6407464df@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-994ef724-c752-4667-a119-8db6407464df@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 02:11:12PM -0800, Palmer Dabbelt wrote:
> On Thu, 08 Mar 2018 13:03:03 PST (-0800), parri.andrea@gmail.com wrote:
> >On Wed, Mar 07, 2018 at 10:33:49AM -0800, Palmer Dabbelt wrote:
> >
> >[...]
> >
> >>I'm going to go produce a new set of spinlocks, I think it'll be a bit more
> >>coherent then.
> >>
> >>I'm keeping your other patch in my queue for now, it generally looks good
> >>but I haven't looked closely yet.
> >
> >Patches 1 and 2 address a same issue ("release-to-acquire"); this is also
> >expressed, more or less explicitly, in the corresponding commit messages:
> >it might make sense to "queue" them together, and to build the new locks
> >on top of these (even if this meant "rewrite all of/a large portion of
> >spinlock.h"...).
> 
> I agree.  IIRC you had a fixup to the first pair of patches, can you submit
> a v2?

I've just sent it (with updated changelog).

  Andrea
