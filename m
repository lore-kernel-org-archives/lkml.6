Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935305AbeEXAyx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 20:54:53 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45157 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935109AbeEXAyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 20:54:52 -0400
X-Google-Smtp-Source: AB8JxZoFajONx86B80go5zDy7KsWMCc7XQ3nR8FaAjnYpoqouI3yzTUKhpUZwikLcWiVyZK4DTe1xA==
Date: Wed, 23 May 2018 17:54:50 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        Ingo Molnar <mingo@redhat.com>, Josh Triplett <josh@joshtriplett.org>,
        kernel-team@android.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zilstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/4] rcu: Use better variable names in funnel locking loop
Message-ID: <20180524005450.GA171060@joelaf.mtv.corp.google.com>
References: <20180523063815.198302-1-joel@joelfernandes.org>
 <20180523063815.198302-4-joel@joelfernandes.org>
 <20180523160617.GM3803@linux.vnet.ibm.com>
 <20180523192349.GA5845@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523192349.GA5845@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 12:23:49PM -0700, Paul E. McKenney wrote:
> On Wed, May 23, 2018 at 09:06:17AM -0700, Paul E. McKenney wrote:
> > On Tue, May 22, 2018 at 11:38:14PM -0700, Joel Fernandes wrote:
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > 
> > > The funnel locking loop in rcu_start_this_gp uses rcu_root as a
> > > temporary variable while walking the combining tree. This causes a
> > > tiresome exercise of a code reader reminding themselves that rcu_root
> > > may not be root. Lets just call it rnp, and rename other variables as
> > > well to be more appropriate.
> > > 
> > > Original patch: https://patchwork.kernel.org/patch/10396577/
> > > 
> > > Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > I used to have double Signed-off-by back when I was seconded to Linaro.
> > But I am guessing that you want the second and don't need the first
> > one.  Unless you tell me otherwise, I will remove the first one on
> > my next rebase.
> > 
> > Anyway, the new variable names are much more clear, good stuff,
> > queued for further review and testing, thank you!
> 
> And it looks to me like I should fold in the patchlet below to change to
> rnp_start in a comment.  Please let me know if this would mess things up.

Yes, missed that. Sorry. It looks great, thanks!
