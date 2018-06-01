Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeFAI3D (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750869AbeFAI26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:28:58 -0400
Date: Fri, 1 Jun 2018 10:28:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: James Simmons <jsimmons@infradead.org>
Cc: devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>,
        James Simmons <uja.ornl@yahoo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH v2 00/25] staging: lustre: libcfs: SMP rework
Message-ID: <20180601082836.GA19242@kroah.com>
References: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:21:40AM -0400, James Simmons wrote:
> From: James Simmons <uja.ornl@yahoo.com>
> 
> Recently lustre support has been expanded to extreme machines with as
> many as a 1000+ cores. On the other end lustre also has been ported
> to platforms like ARM and KNL which have uniquie NUMA and core setup.
> For example some devices exist that have NUMA nodes with no cores.
> With these new platforms the limitations of the Lustre's SMP code
> came to light so a lot of work was needed. This resulted in this
> patch set which has been tested on these platforms.

That's great work, but why is this happening instead of effort to get
this out of the staging tree?  I see a mix of "clean this up" combined
with "add this new feature" happening here, and I am getting tired of
it.

I keep saying, "no new features until this gets out of staging", so why
isn't anyone working directly on getting this out of staging?  I can
only assume the reason why is because I keep being "nice" and accepting
random new feature additions :(

So, no more, I'm really really really tired of dealing with this
filesystem for all of these years.  There is still loads to do to get
this cleaned up and moved out (as my simple debugfs cleanup patch series
showed).  So please do it.

Again, I am not going to take any more new feature additions or anything
that does not obviously look like an attempt to get this code cleaned up
into mergable shape.  Adding things like "now works on systems with
thousands of CPUs as well as an RPi" is not such work, unless you can
directly show me an end result of cleaner, smaller, and more easily
reviewable code.

This patch series is now dropped, if you think it meets the above
criteria, please feel free to resend it to be judged in this manner.

thanks,

greg k-h
