Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeBGC5r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 21:57:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752439AbeBGC5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 21:57:43 -0500
Date: Wed, 7 Feb 2018 04:57:42 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Wang <wei.w.wang@intel.com>, Liang Li <liang.z.li@intel.com>
Subject: Re: linux-next: build failure after merge of the vhost tree
Message-ID: <20180207045702-mutt-send-email-mst@kernel.org>
References: <20180207130423.4f9c1ad0@canb.auug.org.au>
 <20180207135441.0d99ebdb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207135441.0d99ebdb@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 01:54:41PM +1100, Stephen Rothwell wrote:
> Hi Michael,
> 
> On Wed, 7 Feb 2018 13:04:23 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the vhost tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> 
> ERROR: "page_poisoning_enabled" [drivers/virtio/virtio_balloon.ko] undefined!
> 
> > Caused by commit
> > 
> >   96bcd04462b9 ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> > 
> > I have used the vhost tree from next-20180206 for today.

That's
commit d25cc43c6775bff6b8e3dad97c747954b805e421
    vhost: don't hold onto file pointer for VHOST_SET_LOG_FD

Right?
Sounds good, and I reverted by tree to the same hash.

> -- 
> Cheers,
> Stephen Rothwell
