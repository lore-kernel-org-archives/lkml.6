Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757128AbeDZX45 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 19:56:57 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59418 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755737AbeDZX4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 19:56:54 -0400
Date: Fri, 27 Apr 2018 09:56:54 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Martin Steigerwald <martin@lichtvoll.de>,
        Matthew Wilcox <willy@infradead.org>, David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-m68k <linux-m68k@vger.kernel.org>,
        Joanne Dow <jdow@earthlink.net>
Subject: Re: moving affs + RDB partition support to staging? (was: Re: Moving
 unmaintained filesystems to staging)
In-Reply-To: <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1804270939470.8@nippy.intranet>
References: <20180425154602.GA8546@bombadil.infradead.org> <20180425203029.GQ21272@twin.jikos.cz> <20180426025717.GA32430@bombadil.infradead.org> <1613268.lKBQxPXt8J@merkaba> <CAMuHMdXt11A-3wZ2uhxF9WE-3+=VV-AbQhpXrkxnV_nwa+E4tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2018, Geert Uytterhoeven wrote:

> 
> While non-native Linux filesystem support (e.g. affs/isofs/...) could be 
> handled by FUSE

Moving to FUSE is a great divide-and-conquer strategy for those who just 
want the code to die and don't care about any of the data in that format.

If there is a maintainence burden that can be shared then it should be 
shared -- until it can be established that there is no data of value in 
that format.

> moving RDB partition support to staging is not an option, as it is the 
> only partitioning scheme that Amigas can boot from.
> 

Whether or not the original hardware is in use is mostly irrelevant.

As long as the old format is accessible using current hardware, the data 
in that format remains accessible (to archivists, to curators, to your 
decendents, etc).

> If there are bugs in the RDB parser that people run into, they should be 
> fixed. If there are limitations in the RDB format on large disks, that's 
> still not a reason to move it to staging (hi msdos partitioning!).
> 

-- 
