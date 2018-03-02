Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946746AbeCBRhr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:37:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1946676AbeCBRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:37:44 -0500
Date: Fri, 2 Mar 2018 09:38:08 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Boqun Feng <boqun.feng@gmail.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2 v2 RFC] tools/memory-model: redefine rb in terms of
 rcu-fence
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180302045015.GO3777@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1803021017150.1408-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1803021017150.1408-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030217-2213-0000-0000-0000027948E1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008610; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00997363; UDB=6.00507127; IPR=6.00776681;
 MB=3.00019822; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-02 17:37:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030217-2214-0000-0000-0000594A1C35
Message-Id: <20180302173808.GR3777@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803020208
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 10:17:55AM -0500, Alan Stern wrote:
> On Thu, 1 Mar 2018, Paul E. McKenney wrote:
> 
> > On Fri, Mar 02, 2018 at 12:31:41PM +0800, Boqun Feng wrote:
> > > On Thu, Mar 01, 2018 at 10:37:58AM -0800, Paul E. McKenney wrote:
> > > > On Thu, Mar 01, 2018 at 09:49:06AM -0800, Paul E. McKenney wrote:
> > 
> > [ . . . ]
> > 
> > > > And as Andrea pointed out off-list, I did indeed mess up Boqun's change.
> > > > I forgot to change the "irreflexive" into "acyclic".  Applying that change
> > > > makes everything work.
> > > > 
> > > > Please accept my apologies for my confusion!
> > > > 
> > > 
> > > np, also I should have provided a proper patch for your testing.
> > > 
> > > For this Alan's patch, feel free to add:
> > > 
> > > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > 
> > Alan's last submission was still RFC, so I have not yet queued it.
> > So this ball is still in Alan's court.
> 
> I'll wait a few more days to see if there are any other comments and 
> then submit it officially.

Will do!

							Thanx, Paul
