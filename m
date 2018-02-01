Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754434AbeBAAK1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 19:10:27 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42515 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752209AbeBAAK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 19:10:26 -0500
X-ME-Sender: <xms:8VpyWgJJeRUL0H5ndRWd_h5pcVrjFVMxO3cwNaQ6ywIG7SEnRpRFZQ>
Date: Thu, 1 Feb 2018 11:10:21 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: checkpatch changes for 4.16
Message-ID: <20180201001021.GB29988@eros>
References: <20180131214630.GF11433@eros>
 <1517438936.7489.8.camel@perches.com>
 <20180131232358.GA29988@eros>
 <1517442979.7489.14.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517442979.7489.14.camel@perches.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 03:56:19PM -0800, Joe Perches wrote:
> On Thu, 2018-02-01 at 10:23 +1100, Tobin C. Harding wrote:
> > On Wed, Jan 31, 2018 at 02:48:56PM -0800, Joe Perches wrote:
> > > On Thu, 2018-02-01 at 08:46 +1100, Tobin C. Harding wrote:
> > > > Hi Joe,
> > > > 
> > > > Can I please bother you with a maintainer question.  I know everyone is
> > > > super busy right now, I'm asking for a smidgen of your time instead of
> > > > doing it wrong and taking up some of Linus' time since it's merge window
> > > > and all that.
> > > > 
> > > > I have the checkpatch set queued ready to do a GIT PULL to Linus.  My
> > > > concern is that the subject line may not be unique if checkpatch changes
> > > > are coming in from various trees this merge window. I have tagged the
> > > > pull request with
> > > 
> > > Personally, I think you could let Andrew Morton pick them
> > > up as very few patches for checkpatch go in any other way.
> > 
> > ok no worries.  I'll leave it until a few rc's are out then send to Andrew.
> > 
> > > What patches are you submitting again?
> > > 
> > > Is it just
> > > 
> > > commit 7b1924a1d930 ("vsprintf: add printk specifier %px")
> > > 
> > > or is there something else?
> > 
> > d94e97bc9ede checkpatch: add sub routine get_stat_real()
> > d0e27c47f5b9 checkpatch: add sub routine get_stat_here()
> > 986b3b5b7d7a checkpatch: warn for use of %px
> > 26c1cf882d79 checkpatch: add check for tag Co-Developed-by
> > 
> > I thought it was odd when you said they could go in through _any_
> > tree. Not to worry, it's not urgent. 
> 
> Stuff that is going to be pulled should at least
> marinate in -next for awhile first and not first
> be presented as a pull request.

Oh cheers, I forgot about that for leaking_addresses patches too :(

thanks,
Tobin.
