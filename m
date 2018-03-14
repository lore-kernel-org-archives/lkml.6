Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeCNS1s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:27:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752587AbeCNS1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:27:45 -0400
Date: Wed, 14 Mar 2018 11:27:42 -0700
From: Darren Hart <dvhart@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Mario Limonciello <mario.limonciello@dell.com>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: Dell Inc. XPS 13 9343/0TM99H fails to boot v4.16-rc5
Message-ID: <20180314182742.GA5367@localhost.localdomain>
References: <4716007c23abeb0e42015786794539454aff487b.1520886814.git.dvhart@infradead.org>
 <20180312202319.GA88572@localhost.localdomain>
 <20180312220751.GA1757@light.dominikbrodowski.net>
 <CA+55aFzUgk8c2n7GQfcCdYU-Jo86-W_b51gZCLyJahv_ZWMVsQ@mail.gmail.com>
 <20180312233311.GA3848@localhost.localdomain>
 <20180314033445.GA10337@localhost.localdomain>
 <CA+55aFz0xFbJCL9E9LAw6uEFfZSbCZt+ESEdRG+oe5d3hpoYmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFz0xFbJCL9E9LAw6uEFfZSbCZt+ESEdRG+oe5d3hpoYmw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 10:23:16AM -0700, Linus Torvalds wrote:
> On Tue, Mar 13, 2018 at 8:34 PM, Darren Hart <dvhart@infradead.org> wrote:
> >
> > At RC5, we're certainly further into the RC cycle than I want to see
> > these changes. So if you just want to call it now, I understand and I'll
> > send you the revert pull request. If you can give me another day, I
> > think we may finally have found the end of this loose string.
> 
> Since it works for Dominik, and we understand what went wrong, I'm ok
> with the fix rather than the revert.
> 
> But if somebody else ends up finding another problem later, we really
> need to revert it all basically immediately. No more time for games.

On it. Branches are pushed and tagged, PR is written. Waiting for a
couple final validation builds and will send the PR.

Thanks,

-- 
Darren Hart
VMware Open Source Technology Center
