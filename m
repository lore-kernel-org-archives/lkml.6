Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965383AbeE2RYi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:24:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965278AbeE2RYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:24:35 -0400
Date: Tue, 29 May 2018 10:26:11 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] kernel/SRCU: provide a static initializer
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180525101958.13277-1-bigeasy@linutronix.de>
 <20180525101958.13277-2-bigeasy@linutronix.de>
 <CAJZ5v0jEUR7YxzujvZn8WVK+dMxmOxoHNiLKcmgCq9awHR=vYg@mail.gmail.com>
 <20180529120443.GE3803@linux.vnet.ibm.com>
 <CAJZ5v0j_O=nL6Eym5GqGGDC8LPB5vu-YAp9DFfZSJsHd-TMEmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j_O=nL6Eym5GqGGDC8LPB5vu-YAp9DFfZSJsHd-TMEmg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052917-2213-0000-0000-000002AF1BF5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009097; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039457; UDB=6.00530826; IPR=6.00818584;
 MB=3.00021361; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-29 17:24:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052917-2214-0000-0000-00005A48E43E
Message-Id: <20180529172611.GL3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 07:14:49PM +0200, Rafael J. Wysocki wrote:
> On Tue, May 29, 2018 at 2:04 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Tue, May 29, 2018 at 10:09:51AM +0200, Rafael J. Wysocki wrote:
> >> On Fri, May 25, 2018 at 12:19 PM, Sebastian Andrzej Siewior
> >> <bigeasy@linutronix.de> wrote:
> >> > There are macros for static initializer for the three out of four
> >> > possible notifier types, that are:
> >> >         ATOMIC_NOTIFIER_HEAD()
> >> >         BLOCKING_NOTIFIER_HEAD()
> >> >         RAW_NOTIFIER_HEAD()
> >> >
> >> > This patch provides a static initilizer for the forth type to make it
> >> > complete.
> >> >
> >> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> >> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >>
> >> I cannot apply this without an ACK from Paul.
> >
> > I have both queued, but if you would prefer to take them, then for the
> > SRCU piece:
> >
> > Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> Thanks!
> 
> I'll route them along with the other cpufreq material then.

Please let me know when you have them queued so that I can remove
them from -rcu.

							Thanx, Paul
