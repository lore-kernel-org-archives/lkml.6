Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbeCQAcU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 20:32:20 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:41299 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeCQAcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 20:32:18 -0400
Date: Sat, 17 Mar 2018 01:32:16 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache: remove trailing whitespace
Message-ID: <20180317003216.GA22414@axis.com>
References: <20180316143400.8698-1-niklas.cassel@axis.com>
 <20180316155538.GD30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316155538.GD30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1+16 (8a41d1c2f267) (2017-09-22)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 03:55:38PM +0000, Al Viro wrote:
> On Fri, Mar 16, 2018 at 03:34:00PM +0100, Niklas Cassel wrote:
> > Remove trailing whitespace.
> > Remove empty line and trailing whitespace after function comments.
> > Remove an extra space in one of the comments.
> > Fix a typo in of the comments.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> > I know that these type of patches are not really appreciated,
> > however, there is enough trailing whitespace in this file to
> > distract me from reading the real code.
> 
> No, they are not, and here's why:
> 
> Applying: dcache: remove trailing whitespace
> error: patch failed: fs/dcache.c:254
> error: fs/dcache.c: patch does not apply
> Patch failed at 0001 dcache: remove trailing whitespace
> 
> ... which, BTW, happens in *all* branches.  If you do that kind
> of stuff, at least do it against something in the public trees
> and _tell_ _what_ _it_ _is_ _against_.

Hello Al,

I always base my patches on linux-next, which is usually correct,
and if it isn't, the maintainer usually says something :)

The patch in question is based on the latest linux-next tag:
next-20180316

It appears that the following three commits are in linux-next,
but not on your for-next branch @ your vfs git tree:
61fc3c8ce7f1 dcache: remove trailing whitespace
929387149a47 dcache: fix indirectly reclaimable memory accounting
ff335768ddd0 dcache: fix indirectly reclaimable memory accounting for CONFIG_SLOB

They appear to come from Andrew Morton's tree.

Would you prefer me to rebase my patch against your
for-next branch instead?

> Not applied.  Please, do it sanely.  BTW, which editor is _that_
> annoying?  Anything that shoves trailing whitespace in my face
> would've been either configured (with considerable cursing at
> the people who'd set such defaults) or, should that prove
> impossible, given a boot...

I'm using emacs, but having added show-trailing-whitespace
is my personal preference, however, I quite sure that I'm
not the only one who has an editor configured like this.


Kind regards,
Niklas
