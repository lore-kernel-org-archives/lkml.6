Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbeBBIlO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 03:41:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751801AbeBBIky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 03:40:54 -0500
Date: Thu, 1 Feb 2018 15:14:09 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, boqun.feng@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
        elena.reshetova@intel.com, mhocko@suse.com, akiyks@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL tools] Linux kernel memory model
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180125093440.GA875@linux.vnet.ibm.com>
 <20180129065724.ybrdsabvktq7fbqg@gmail.com>
 <20180129095449.GT3741@linux.vnet.ibm.com>
 <20180131090006.onaopgyqthppoysi@gmail.com>
 <20180201011728.GL3741@linux.vnet.ibm.com>
 <20180201065742.efww6os2qiwi2vjj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201065742.efww6os2qiwi2vjj@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020208-0036-0000-0000-000002B81A44
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008461; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00983875; UDB=6.00499022; IPR=6.00763153;
 BA=6.00005808; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019331; XFM=3.00000015;
 UTC=2018-02-02 08:40:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020208-0037-0000-0000-00004333BE26
Message-Id: <20180201231409.GU3741@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802020103
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 07:57:42AM +0100, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > > I believe these additional improvements (to the extent you agree with doing them!) 
> > > could/should be done as add-on commits on top of this existing commit.
> > 
> > Sounds good!
> > 
> > Would you prefer a pull request or a patch series for these?
> 
> Patch series would be nice, for review and later application to the locking tree.

Works for me!

I will curate the series on branch lkmm in my -rcu tree, and send the
series out non-RFC when I believe that it is ready for you.

							Thanx, Paul
