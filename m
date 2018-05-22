Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeEVR1G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751279AbeEVR1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:27:03 -0400
Date: Tue, 22 May 2018 13:27:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, byungchul.park@lge.com,
        mathieu.desnoyers@efficios.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: Tasks RCU vs Preempt RCU
Message-ID: <20180522132700.68b6660d@gandalf.local.home>
In-Reply-To: <20180522160949.GU3803@linux.vnet.ibm.com>
References: <20180518183623.GA163151@joelaf.mtv.corp.google.com>
        <20180519022918.GV3803@linux.vnet.ibm.com>
        <20180519225905.GB134184@joelaf.mtv.corp.google.com>
        <20180520004938.GZ3803@linux.vnet.ibm.com>
        <20180520112843.57079857@grimm.local.home>
        <20180520191846.GA248075@joelaf.mtv.corp.google.com>
        <20180521215951.2d6abfcb@gandalf.local.home>
        <20180522045414.GG40541@joelaf.mtv.corp.google.com>
        <20180522083832.45353d5f@gandalf.local.home>
        <20180522160949.GU3803@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 09:09:49 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> Just for the record, if you guys realy want to take over Tasks RCU,
> I have no objections.  For one thing, I don't anticipate any other use
> cases for it (famous last words!).  But you break it, you buy it!  ;-)

It really matters how much of a burden is RCU_tasks to RCU itself? If
it causes a lot of headache for you, and it prevents you from cleaning
up RCU or making it better, then I would be happy to take it out of RCU
and maintain it separately myself. But if that's not the case, I'm happy
with keeping it within the RCU umbrella. Which brings me to the
question of what motivation does Joel have to remove it?

-- Steve
