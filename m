Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161471AbeBPQw4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:52:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161415AbeBPQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:52:52 -0500
Date: Fri, 16 Feb 2018 08:53:01 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: Trial of conflict resolution of Alan's patch
Reply-To: paulmck@linux.vnet.ibm.com
References: <fe361fba-d6ec-3a70-6ab9-e148bccb5833@gmail.com>
 <Pine.LNX.4.44L0.1802161015010.1402-100000@iolanthe.rowland.org>
 <20180216154704.GA29493@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216154704.GA29493@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18021616-2213-0000-0000-000002712E53
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008543; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00990636; UDB=6.00503116; IPR=6.00769982;
 MB=3.00019590; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-16 16:52:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021616-2214-0000-0000-000059241CDA
Message-Id: <20180216165301.GF3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802160201
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 04:47:04PM +0100, Andrea Parri wrote:
> On Fri, Feb 16, 2018 at 10:18:34AM -0500, Alan Stern wrote:
> > On Fri, 16 Feb 2018, Akira Yokosawa wrote:
> > 
> > > Hi,
> > > 
> > > My forward-port patch doesn't apply to the "lkmm" branch.
> > > It looks like "linux-kernel-hardware.cat" is intentionally omitted there.
> > > Am I guessing right?
> > > 
> > > If this is the case, I can prepare a patch to be applied to "lkmm".
> > > But I can't compose a proper change log. So I'd like Alan to post
> > > a patch with my SOB appended. Does this approach sound reasonable?
> > 
> > The patch is not yet ready to be merged.  At the very least, I need to
> > include an update to explanation.txt along with it.  When it is all 
> > ready, I will rebase it on Paul's repository and post it.
> > 
> > Which reminds me: Now that the material has been accepted into the 
> > kernel, do we need to keep the github repository?  It has the 
> > linux-kernel-hardware.cat file, but otherwise it seems to be redundant.
> 
> If you mean "to keep up-to-date", I'd say "No, we don't..."  ;-)
> 
> My plan/hope is to add such a disclaimer together with a pointer
> to Linus's tree ASAP...

I agree that the github repository is useful as a historical reference
but that we should not try to keep it up to date.  The -rc1 release
came out last Sunday, so in 7-8 weeks we will hopefully have this in
the Linux kernel.  Fingers firmly crossed and all that...

							Thanx, Paul
