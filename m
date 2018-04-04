Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeDDJmX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:42:23 -0400
Received: from osg.samsung.com ([64.30.133.232]:45807 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeDDJmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:42:22 -0400
Date: Wed, 4 Apr 2018 06:41:20 -0300
From: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: Re: linux-next: manual merge of the v4l-dvb tree with the
 asm-generic tree
Message-ID: <20180404064112.747dbe14@vento.lan>
In-Reply-To: <20180404090900.2cc0645e@canb.auug.org.au>
References: <20180315122921.24520368@canb.auug.org.au>
        <20180404090900.2cc0645e@canb.auug.org.au>
Organization: Samsung
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 4 Apr 2018 09:09:00 +1000
Stephen Rothwell <sfr@canb.auug.org.au> escreveu:

> Hi all,
> 
> On Thu, 15 Mar 2018 12:29:21 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the v4l-dvb tree got a conflict in:
> > 
> >   drivers/media/platform/blackfin/bfin_capture.c
> > 
> > between commit:
> > 
> >   b9ec40bf7d29 ("media: platform: remove blackfin capture driver")
> > 
> > from the asm-generic tree and commit:
> > 
> >   4471109e3894 ("media: convert g/s_parm to g/s_frame_interval in subdevs")
> > 
> > from the v4l-dvb tree.
> > 
> > I fixed it up (I just removed the file) and can carry the fix as
> > necessary. This is now fixed as far as linux-next is concerned, but any
> > non trivial conflicts should be mentioned to your upstream maintainer
> > when your tree is submitted for merging.  You may also want to consider
> > cooperating with the maintainer of the conflicting tree to minimise any
> > particularly complex conflicts.  
> 
> This conflict now exists between the v4l-dvb tree and Linus' tree.

Thanks for warning me. Merged from Linus on all media trees/branches.

-- 
Thanks,
Mauro
