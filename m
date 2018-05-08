Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932660AbeEHPtc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:49:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57158 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932127AbeEHPtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:49:31 -0400
Date: Tue, 8 May 2018 17:49:25 +0200 (CEST)
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/signal: Remove no longer required
 irqsave/restore
In-Reply-To: <20180508145351.GC26088@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1805081744090.2262@hypnos.tec.linutronix.de>
References: <876043e3xb.fsf@xmission.com> <20180504175241.GT26088@linux.vnet.ibm.com> <87sh77b5w7.fsf@xmission.com> <20180504194510.GW26088@linux.vnet.ibm.com> <87vac39oaf.fsf@xmission.com> <20180504203713.GY26088@linux.vnet.ibm.com> <87k1siaf8y.fsf@xmission.com>
 <20180505052500.GN26088@linux.vnet.ibm.com> <alpine.DEB.2.21.1805050755240.1685@nanos.tec.linutronix.de> <alpine.DEB.2.20.1805081539060.2262@hypnos.tec.linutronix.de> <20180508145351.GC26088@linux.vnet.ibm.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2018, Paul E. McKenney wrote:

> On Tue, May 08, 2018 at 03:42:25PM +0200, Anna-Maria Gleixner wrote:
> > On Sat, 5 May 2018, Thomas Gleixner wrote:
> > 
> > > On Fri, 4 May 2018, Paul E. McKenney wrote:
> > > > On Fri, May 04, 2018 at 11:38:37PM -0500, Eric W. Biederman wrote:
> > > > > > (Me, I would run rcutorture scenario TREE03 for an extended time period
> > > > > > on b4abf91047cf with your patch applied.
> > > > 
> > > > And with lockdep enabled, which TREE03 does not do by default.
> > > 
> > > Will run that again to make sure.
> > 
> > I ran the rcutorture scenario TREE03 for 4 hours with the above
> > described setup. It was successful and without any lockdep splats.
> 
> Thank you for the testing, Anna-Maria!  If you give them a Tested-by,
> I will give them an ack.  ;-)
> 

If it is ok to give a Tested-by to the patch I wrote, I will do this
to get your ack :)

Tested-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
