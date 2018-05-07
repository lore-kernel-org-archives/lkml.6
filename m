Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeEGIAL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:00:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:43729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbeEGIAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:00:10 -0400
Message-ID: <1525679999.17605.1.camel@gmx.de>
Subject: Re: [PATCH] x86: UV: raw_spinlock conversion
From: Mike Galbraith <gleep@gmx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Date: Mon, 07 May 2018 09:59:59 +0200
In-Reply-To: <20180507073928.shmtfpqyhgxya53b@linutronix.de>
References: <20180504111459.24825-1-bigeasy@linutronix.de>
         <20180504111459.24825-2-bigeasy@linutronix.de>
         <alpine.DEB.2.21.1805061225550.1685@nanos.tec.linutronix.de>
         <1525604359.28142.3.camel@gmx.de>
         <20180507073928.shmtfpqyhgxya53b@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:u2K8dY83ELqOmJo2qgNpxV4lKwhDu5hSIDU61AsHXX3eOMb1H9N
 YHAoZSkxFvduqXKkEHrwWhNB4CeYhrimin/M6AfXsq1B4GBVglFonqtTeUCZ6i9NuxE987b
 DYEshrhNgalTTHnKvxhrIajFNgC/+UGzRkEQBfc6qqx8HiCE6Dcx2uw4D+AGq0SqbaGfEzl
 ChUGc8ueB3Qb8ssecSt+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GcEsXh/Fag0=:b/s/7flibqIHuRhNiWZgUM
 sSCAySL83oO2wcm5hTUP52Z4FyIsCkmbqm+R4dBKx7dKGiBdAYmUredWf6lYI2Q2I/7bGxFzG
 iJifmogrAQgCY/Miu1BN9mQQ1Hn3DzMtouQt8AC/rMN9Eu3m1WWUPeXPYeZ+Ym1HyLFekxq5E
 MK9R41KSS6SSFoekQKTNVYJq/X4jwSgKRYk7joo1iY1sF7JdeNoeO9+0hvVtO38dxPxFu+IQ6
 5I92OyyIxyeSaxSFuYJJ465afuu1DHn7YZdEyEAtYCi/G5P5LGSTQcTffnZgGbKbk/Am7eGuV
 5TnSyM/0Mo3wm7mpA7l77m3Ju8qRsN5kLRuurNpg5LKkOC7x7weBKA6RVOoAuxu1i5jj9f4FB
 Ae3+rAxzkeRI6x6bPFkRB7XyqrH7DZJHogqQCG++rPC9AQhBC/h38yVwm+Xhkt8cQohpY2WEA
 67y8u4T3tiqIguLXqRTfH5l5R4WGvtq+1O6UtQlIA3V5WdThYGE/EVAcbKWunKv4sGq0mv8Om
 fhnO4+flPCLS2xCGnBxJBYOvtBMJwQvFdxfw2CfjoYyFnqSVPYAfKwgntm9mI3sEi6M4YXC4D
 xxercAyzKm83VR76eMfd9chqDTm2ZVXoIiOODn69bDag9ME35UAIYKjrCd1bdG2v043O1harA
 s0qmgzSwRUbJP9KWmPF5bMa26IS6u6CxaylhNpTCK53tWRyegESwvJTeewH6+Zvc2pVgijt2m
 jkO9wy7e50CbBgp7agKJMXWdintzBWqr9iokWZ9ckbqSdZoDoBdFgnRwO16NLwy45sOdHpm+i
 T4gOBZP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-07 at 09:39 +0200, Sebastian Andrzej Siewior wrote:
> On 2018-05-06 12:59:19 [+0200], Mike Galbraith wrote:
> > On Sun, 2018-05-06 at 12:26 +0200, Thomas Gleixner wrote:
> > > On Fri, 4 May 2018, Sebastian Andrzej Siewior wrote:
> > > 
> > > > From: Mike Galbraith <umgwanakikbuti@gmail.com>
> > > > 
> > > > Shrug.  Lots of hobbyists have a beast in their basement, right?
> > > 
> > > This hardly qualifies as a proper changelog ...
> > 
> > Hm, that wasn't intended to be a changelog.
> > 
> > This patch may not be current either, I haven't tested RT on a UV box
> > in quite some time.
> 
> That last hunk looks like something that would be required even for !RT. 
> Would you mind to check that patch and write a changelog? If it doesn't
> work for RT there is no need to carry this in -RT.

Yeah, I'll try to reserve a box.

	-Mike
