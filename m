Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbeDDMGP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:06:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751277AbeDDMGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:06:13 -0400
Date: Wed, 4 Apr 2018 08:06:11 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the overlayfs
 tree
Message-ID: <20180404120611.GA10495@redhat.com>
References: <20180330120411.035c9242@canb.auug.org.au>
 <CAJfpegtd6V2KrdVjrubs8dPnsUkdE7A=ftajOr6d3DzkfNTqVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtd6V2KrdVjrubs8dPnsUkdE7A=ftajOr6d3DzkfNTqVA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 10:23:25AM +0200, Miklos Szeredi wrote:
> On Fri, Mar 30, 2018 at 3:08 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi Miklos,
> >
> > Commit
> >
> >   cbf293becfa4 ("ovl: cleanup setting OVL_INDEX")
> >
> > is missing a Signed-off-by from its author.
> 
> Hi Steven,
> 
> AFAIK for trivial work we are not required to get a signoff from the author.

I am fine with putting my Signed-off-by, if it is required.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

BTW, I also posted same patch in next series with Signed-off-by:

https://www.spinics.net/lists/linux-unionfs/msg04510.html

Thanks
Vivek
