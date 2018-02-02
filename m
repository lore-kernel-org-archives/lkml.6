Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeBBVbW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 16:31:22 -0500
Received: from namei.org ([65.99.196.166]:47758 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751655AbeBBVbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 16:31:13 -0500
Date: Sat, 3 Feb 2018 08:31:06 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [GIT PULL] IMA bug fixes for 4.16
In-Reply-To: <1517582979.3171.46.camel@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.21.1802030831010.10919@namei.org>
References: <1517510282.6675.13.camel@linux.vnet.ibm.com>         <alpine.LRH.2.21.1802022106130.2739@namei.org> <1517582979.3171.46.camel@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2018, Mimi Zohar wrote:

> On Fri, 2018-02-02 at 21:07 +1100, James Morris wrote:
> > On Thu, 1 Feb 2018, Mimi Zohar wrote:
> > 
> > > Hi James,
> > > 
> > > Included in this pull request are three bug fixes, assuming the 2 FUSE
> > > patches are considered bugs and not new features, and a maintainer update.
> > > I'd appreciate your sending them to Linus for 4.16.
> > 
> > I'd like to see an acked-by or reviewed-by from the FUSE maintainer 
> > (cc'd), on the FUSE patches.
> 
> Ok.  For now, can you take the first two patches?

Sure.


-- 
James Morris
<jmorris@namei.org>
