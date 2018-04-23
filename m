Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932334AbeDWTJG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 15:09:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932175AbeDWTJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 15:09:04 -0400
Date: Mon, 23 Apr 2018 12:10:10 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>, oleg@redhat.com,
        joel.opensrc@gmail.com, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 07/22] softirq: Eliminate unused
 cond_resched_softirq() macro
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180423023150.GA21533@linux.vnet.ibm.com>
 <1524450747-22778-7-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180423085430.GT4064@hirez.programming.kicks-ass.net>
 <CANn89iJShqinnNkBqw2CoqDJRLerAg=U_JV2-Uxb4LRU6sL5yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJShqinnNkBqw2CoqDJRLerAg=U_JV2-Uxb4LRU6sL5yQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042319-0036-0000-0000-000002E8F9B3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008907; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01022219; UDB=6.00521732; IPR=6.00801454;
 MB=3.00020731; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 19:09:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042319-0037-0000-0000-00004416F89F
Message-Id: <20180423191010.GQ26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230191
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 01:25:06PM +0000, Eric Dumazet wrote:
> On Mon, Apr 23, 2018 at 1:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Sun, Apr 22, 2018 at 07:32:12PM -0700, Paul E. McKenney wrote:
> > > The cond_resched_softirq() macro is not used anywhere in mainline, so
> > > this commit simplifies the kernel by eliminating it.
> > >
> > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> 
> > Fair enough,
> 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Yes, I suggested this removal in
> https://www.spinics.net/lists/netdev/msg375161.html
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> Thanks Paul.

I added Peter's Acked-by, Eric's Reviewed-by, and on the strength of
the above URL, a Suggested-by from Eric.  Thank you both!

							Thanx, Paul
