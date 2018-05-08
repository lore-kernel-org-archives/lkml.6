Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755302AbeEHNme (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:42:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56144 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752511AbeEHNmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:42:32 -0400
Date: Tue, 8 May 2018 15:42:25 +0200 (CEST)
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/signal: Remove no longer required
 irqsave/restore
In-Reply-To: <alpine.DEB.2.21.1805050755240.1685@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.20.1805081539060.2262@hypnos.tec.linutronix.de>
References: <20180504144014.5378-1-bigeasy@linutronix.de> <87fu37e4rn.fsf@xmission.com> <20180504170459.624e7vkro5fn2bgw@linutronix.de> <876043e3xb.fsf@xmission.com> <20180504175241.GT26088@linux.vnet.ibm.com> <87sh77b5w7.fsf@xmission.com>
 <20180504194510.GW26088@linux.vnet.ibm.com> <87vac39oaf.fsf@xmission.com> <20180504203713.GY26088@linux.vnet.ibm.com> <87k1siaf8y.fsf@xmission.com> <20180505052500.GN26088@linux.vnet.ibm.com> <alpine.DEB.2.21.1805050755240.1685@nanos.tec.linutronix.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 May 2018, Thomas Gleixner wrote:

> On Fri, 4 May 2018, Paul E. McKenney wrote:
> > On Fri, May 04, 2018 at 11:38:37PM -0500, Eric W. Biederman wrote:
> > > > (Me, I would run rcutorture scenario TREE03 for an extended time period
> > > > on b4abf91047cf with your patch applied.
> > 
> > And with lockdep enabled, which TREE03 does not do by default.
> 
> Will run that again to make sure.
> 

I ran the rcutorture scenario TREE03 for 4 hours with the above
described setup. It was successful and without any lockdep splats.

Anna-Maria
