Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755023AbeAaXx4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 18:53:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752775AbeAaXxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 18:53:55 -0500
Date: Wed, 31 Jan 2018 15:53:50 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        boqun.feng@gmail.com, will.deacon@arm.com, npiggin@gmail.com,
        dhowells@redhat.com, elena.reshetova@intel.com, mhocko@suse.com,
        akiyks@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180129065724.ybrdsabvktq7fbqg@gmail.com>
 <20180129095449.GT3741@linux.vnet.ibm.com>
 <20180131090006.onaopgyqthppoysi@gmail.com>
 <20180131100822.GL2269@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131100822.GL2269@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18013123-0040-0000-0000-000003EC082E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008457; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00983219; UDB=6.00498630; IPR=6.00762502;
 BA=6.00005806; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019309; XFM=3.00000015;
 UTC=2018-01-31 23:53:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18013123-0041-0000-0000-000007E175B3
Message-Id: <20180131235350.GH3741@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-31_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1801310293
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 11:08:22AM +0100, Peter Zijlstra wrote:
> On Wed, Jan 31, 2018 at 10:00:06AM +0100, Ingo Molnar wrote:
> > - Similary, some of the high level descriptions in tools/memory-model/README
> >   should probably propagated into the source code files as well: for example
> >   both tools/memory-model/lock.cat and linux-kernel.cat could be improved that
> >   way.
> 
> This is something both Will and me have on our todo list, sadly we've
> not had any time to work on this due to this pesky spectre crap.

Spectre permitting, this would be very cool!

							Thanx, Paul
