Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbeD1SBa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 14:01:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:44436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750775AbeD1SB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 14:01:29 -0400
Date: Sat, 28 Apr 2018 19:58:53 +0200
From: David Sterba <dsterba@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Steigerwald <martin@lichtvoll.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH] MAINTAINERS: add myself as maintainer of AFFS
Message-ID: <20180428175853.GM21272@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Steigerwald <martin@lichtvoll.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20180428170504.16031-1-dsterba@suse.com>
 <CA+55aFzH=CjVD4kUXfPBjimsKhfphjOceDtcskWtj5Vk3ByB4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzH=CjVD4kUXfPBjimsKhfphjOceDtcskWtj5Vk3ByB4Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 05:33:57PM +0000, Linus Torvalds wrote:
> On Sat, Apr 28, 2018 at 10:07 AM David Sterba <dsterba@suse.com> wrote:
> 
> > I volunteer to act as a maintainer of AFFS to collect any fixes that
> > might show up and to guard fs/affs/ against another spring cleaning.
> 
> Hmm. Please be more careful.
> 
> > @@ -564,8 +564,10 @@ S: Maintained
> 
> The above says it adds two lines (8 -> 10), but the actual patch itself
> only adds one, and modifies another:
> 
> > +M:     David Sterba <dsterba@suse.com>
> > -S:     Orphan
> > +S:     Odd Fixes
> 
> I'm used to editing patches for things like this, because I have years and
> years of just hand-editing patches I didn't like for some reason, but it
> looks like you tried to edit a patch without knowing all the rules for how
> unified patches work.
> 
> So please don't edit patches by hand.  It's a skill nobody should have.
> 
> Anyway, I fixed the patch and applied it, but let's not make a habit of it.

Sorry, it was a last minute change. There was a T: line with a git tree
reference, but this looked odd and I deleted it, but did not realize the
patch would not apply. Too excited to send it.
