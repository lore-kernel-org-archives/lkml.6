Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbeBGEaL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 23:30:11 -0500
Received: from ozlabs.org ([103.22.144.67]:34943 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752970AbeBGEaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 23:30:09 -0500
Date: Wed, 7 Feb 2018 15:30:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Wang <wei.w.wang@intel.com>, Liang Li <liang.z.li@intel.com>
Subject: Re: linux-next: build failure after merge of the vhost tree
Message-ID: <20180207153007.4364d607@canb.auug.org.au>
In-Reply-To: <20180207045702-mutt-send-email-mst@kernel.org>
References: <20180207130423.4f9c1ad0@canb.auug.org.au>
        <20180207135441.0d99ebdb@canb.auug.org.au>
        <20180207045702-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Wed, 7 Feb 2018 04:57:42 +0200 "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
> On Wed, Feb 07, 2018 at 01:54:41PM +1100, Stephen Rothwell wrote:
> > 
> > On Wed, 7 Feb 2018 13:04:23 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:  
> > >
> > > I have used the vhost tree from next-20180206 for today.  
> 
> That's
> commit d25cc43c6775bff6b8e3dad97c747954b805e421
>     vhost: don't hold onto file pointer for VHOST_SET_LOG_FD
> 
> Right?

Correct.

-- 
Cheers,
Stephen Rothwell
