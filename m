Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeEEF4O (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 01:56:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44597 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeEEF4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 01:56:13 -0400
Date: Sat, 5 May 2018 07:56:03 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [PATCH] kernel/signal: Remove no longer required
 irqsave/restore
In-Reply-To: <20180505052500.GN26088@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.21.1805050755240.1685@nanos.tec.linutronix.de>
References: <20180504144014.5378-1-bigeasy@linutronix.de> <87fu37e4rn.fsf@xmission.com> <20180504170459.624e7vkro5fn2bgw@linutronix.de> <876043e3xb.fsf@xmission.com> <20180504175241.GT26088@linux.vnet.ibm.com> <87sh77b5w7.fsf@xmission.com>
 <20180504194510.GW26088@linux.vnet.ibm.com> <87vac39oaf.fsf@xmission.com> <20180504203713.GY26088@linux.vnet.ibm.com> <87k1siaf8y.fsf@xmission.com> <20180505052500.GN26088@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 May 2018, Paul E. McKenney wrote:
> On Fri, May 04, 2018 at 11:38:37PM -0500, Eric W. Biederman wrote:
> > > (Me, I would run rcutorture scenario TREE03 for an extended time period
> > > on b4abf91047cf with your patch applied.
> 
> And with lockdep enabled, which TREE03 does not do by default.

Will run that again to make sure.

Thanks,

	tglx
