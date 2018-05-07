Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeEGHjc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:39:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49817 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbeEGHja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:39:30 -0400
Date: Mon, 7 May 2018 09:39:28 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mike Galbraith <gleep@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86: UV: raw_spinlock conversion
Message-ID: <20180507073928.shmtfpqyhgxya53b@linutronix.de>
References: <20180504111459.24825-1-bigeasy@linutronix.de>
 <20180504111459.24825-2-bigeasy@linutronix.de>
 <alpine.DEB.2.21.1805061225550.1685@nanos.tec.linutronix.de>
 <1525604359.28142.3.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1525604359.28142.3.camel@gmx.de>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-06 12:59:19 [+0200], Mike Galbraith wrote:
> On Sun, 2018-05-06 at 12:26 +0200, Thomas Gleixner wrote:
> > On Fri, 4 May 2018, Sebastian Andrzej Siewior wrote:
> > 
> > > From: Mike Galbraith <umgwanakikbuti@gmail.com>
> > > 
> > > Shrug.  Lots of hobbyists have a beast in their basement, right?
> > 
> > This hardly qualifies as a proper changelog ...
> 
> Hm, that wasn't intended to be a changelog.
> 
> This patch may not be current either, I haven't tested RT on a UV box
> in quite some time.

That last hunk looks like something that would be required even for !RT. 
Would you mind to check that patch and write a changelog? If it doesn't
work for RT there is no need to carry this in -RT.

> 	-Mike

Sebastian
