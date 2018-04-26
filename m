Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755728AbeDZLCU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:02:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:50160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755703AbeDZLCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:02:16 -0400
Date: Thu, 26 Apr 2018 12:59:40 +0200
From: David Sterba <dsterba@suse.cz>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Martin Steigerwald <martin@lichtvoll.de>,
        Matthew Wilcox <willy@infradead.org>, dsterba@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-m68k@vger.kernel.org,
        Debian m68k <debian-68k@lists.debian.org>
Subject: Re: moving affs + RDB partition support to staging?
Message-ID: <20180426105940.smn3447igebe5r34@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-m68k@vger.kernel.org,
        Debian m68k <debian-68k@lists.debian.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180425203029.GQ21272@twin.jikos.cz>
 <20180426025717.GA32430@bombadil.infradead.org>
 <1613268.lKBQxPXt8J@merkaba>
 <76ca15e2-7b43-8b02-43e1-9ee65ab85356@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76ca15e2-7b43-8b02-43e1-9ee65ab85356@physik.fu-berlin.de>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 12:45:41PM +0200, John Paul Adrian Glaubitz wrote:
> (adding debian-68k)
> 
> Hi Matthew!
> 
> On 04/26/2018 12:28 PM, Martin Steigerwald wrote:
> > You probably put your stick into a cave with ancient sleeping dragons :)
> 
> Indeed.
> 
> > Added in linux-m68k mailing list, as they likely have an opinion on how
> > to treat affs + RDB partition support. Also added in Jens Axboe about
> > patching that RDB support broken with 2 TB or larger harddisks issue
> > which had been in Linux kernel for 6 years while a patch exists that to
> > my testing back then solves the issue.
> 
> The answer is that we are still very much actively using RDB and AFFS
> supoort in the Linux kernel and if you were to remove it, you would
> directly hit users.

Based on that I think removing affs will not happen, but the upstream
maintenance status should be updated accordingly.

> I know it may sound crazy, but the Linux/m68k port (Atari, Mac, Amiga etc)
> is a very actively used and maintained port which just recently received
> three new drivers:
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?h=4.18/scsi-queue&id=3109e5ae0311e937d49a5325134e50b742ac5f4a
> > https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=861928f4e60e826cd8871c0c37f4b3d825b8d81d
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/ata/pata_gayle.c?id=9ab27d1d35fda0c5fce624083e92546a8545e7e5
> 
> The community around the m68k CPU is constantly developing new hardware
> (new accelerator boards, networking cards, IDE controllers etc for the
> Amiga and so on). So, the community and the port are anything but dead.
> 
> > > Yeah, it's pretty sad how few commits some of these filesystems have
> > > had in recent years.  One can argue that they're stable and don't need
> > > to be fixed because they aren't broken, but I find it hard to believe
> > > that any of them were better-implemented than ext2 which still sees
> > > regular bugfixes.
> 
> Exactly. It works fine as is:
...
> There is nothing at the moment that needs fixing.

So, I'm willing to act as upstream maintainer for affs, send pull
requests with fixes if you ever need that (unless you find someone
else).
