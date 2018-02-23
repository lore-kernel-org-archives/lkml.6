Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeBWBFq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 20:05:46 -0500
Received: from fieldses.org ([173.255.197.46]:44250 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751158AbeBWBFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 20:05:45 -0500
Date: Thu, 22 Feb 2018 20:05:45 -0500
From: "J. Bruce Fields" <bfields@fieldses.org>
To: James Ettle <james@ettle.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the nfsd tree
Message-ID: <20180223010545.GC15876@fieldses.org>
References: <20180222151723.7d381e77@canb.auug.org.au>
 <12138EE4-77CA-480F-B2F9-B4C7E4E20891@ettle.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12138EE4-77CA-480F-B2F9-B4C7E4E20891@ettle.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 06:39:43AM +0000, James Ettle wrote:
> I only really posted this as a demo of a fix. I was hoping someone who actually knows what they're doing in the kernel would pick it up and make it proper.

Whoops, sorry, I didn't realize that.

But I don't see a problem with the patch as it is.  Are you OK with me
adding your signed-off-by?

--b.

> 
> Thanks,
> James.
> 
> 
> On 22 February 2018 04:17:23 GMT+00:00, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >Hi,
> >
> >Commit
> >
> >  35da1ba8af70 ("sunrpc: Fix unaligned access on sparc64")
> >
> >is missing a Signed-off-by from its author.
> >
> >-- 
> >Cheers,
> >Stephen Rothwell
