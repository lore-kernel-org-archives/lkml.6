Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeEEUp4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 16:45:56 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:53742 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeEEUpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 16:45:54 -0400
Date: Sat, 5 May 2018 16:45:13 -0400
From: Rich Felker <dalias@libc.org>
To: jacopo mondi <jacopo@jmondi.org>
Cc: Christoph Hellwig <hch@infradead.org>, ysato@users.sourceforge.jp,
        thomas.petazzoni@free-electrons.com, robin.murphy@arm.com,
        geert@linux-m68k.org, sergei.shtylyov@cogentembedded.com,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sh: mm: Fix unprotected access to struct device
Message-ID: <20180505204513.GF1392@brightrain.aerifal.cx>
References: <1524044555-20610-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180502074600.GC27261@w540>
 <20180502123909.GA9546@infradead.org>
 <20180503071539.GA19612@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503071539.GA19612@w540>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 09:15:39AM +0200, jacopo mondi wrote:
> Hi Christoph,
> 
> On Wed, May 02, 2018 at 05:39:09AM -0700, Christoph Hellwig wrote:
> > On Wed, May 02, 2018 at 09:46:31AM +0200, jacopo mondi wrote:
> > > Hi again Christoph,
> > >
> > >     The gentle ping actually applies to this version of the patch.
> > >
> > > Sorry for the confusion.
> >
> > I'd expect this to go in through the sh tree, but if the sh maintainers
> > are fine with it I can take it through the dma-mapping tree.
> 
> Oh, that's fine then. I'll let Rich comment if he plans to send a pull
> requets for v4.17 fixes or not.

OK, I'll prepare a pull request with this and another fix I just made.

Rich
