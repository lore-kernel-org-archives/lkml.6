Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030859AbeBPNZ1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:25:27 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:42018 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030766AbeBPNZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:25:26 -0500
Message-ID: <1518787521.2464.20.camel@gentoo.org>
Subject: Re: [PATCH-next] sched/headers: Clean up <linux/sched.h>
From: Christopher =?ISO-8859-1?Q?D=EDaz?= Riveros <chrisadr@gentoo.org>
To: Juri Lelli <juri.lelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date: Fri, 16 Feb 2018 08:25:21 -0500
In-Reply-To: <20180216094432.GG8032@localhost.localdomain>
References: <20180215154318.15894-1-chrisadr@gentoo.org>
         <20180215165212.GB25181@hirez.programming.kicks-ass.net>
         <20180216094432.GG8032@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El vie, 16-02-2018 a las 10:44 +0100, Juri Lelli escribió:
> On 15/02/18 17:52, Peter Zijlstra wrote:
> > On Thu, Feb 15, 2018 at 10:43:18AM -0500, Christopher Diaz Riveros
> > wrote:
> 
> [...]
> 
> > > @@ -437,20 +437,28 @@ struct sched_dl_entity {
> > >  	 * during sched_setattr(), they will remain the same
> > > until
> > >  	 * the next sched_setattr().
> > >  	 */
> > > -	u64				dl_runtime;	/*
> > > Maximum runtime for each instance	*/
> > > -	u64				dl_deadline;	/
> > > * Relative deadline of each instance	*/
> > > -	u64				dl_period;	/*
> > > Separation of two instances (period) */
> > > -	u64				dl_bw;		
> > > /* dl_runtime / dl_period		*/
> > > -	u64				dl_density;	/*
> > > dl_runtime / dl_deadline		*/
> > > +	/* Maximum runtime for each instance	*/
> > > +	u64				dl_runtime;
> > > +	/* Relative deadline of each instance	*/
> > > +	u64				dl_deadline;
> > > +	/* Separation of two instances (period) */
> > > +	u64				dl_period;
> > > +	/* dl_runtime / dl_period		*/
> > > +	u64				dl_bw;
> > > +	/* dl_runtime / dl_deadline		*/
> > > +	u64				dl_density;
> > 
> > That's a whole lot less readable :/
> 
> Yep. :(

Thank you all for the feedback, I'll consider this patch as NACK. Sorry
 for wasting time in a low quality patch. I'll prepare a better one
next time :)

Regards,
-- 
Christopher Díaz Riveros
Gentoo Linux Developer
GPG Fingerprint: E517 5ECB 8152 98E4 FEBC  2BAA 4DBB D10F 0FDD 2547
