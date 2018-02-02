Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeBBXvM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 18:51:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751699AbeBBXvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 18:51:05 -0500
Date: Fri, 2 Feb 2018 15:51:02 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: corbet@lwn.net, stern@rowland.harvard.edu, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: list file memory-barriers.txt within
 the LKMM entry
Reply-To: paulmck@linux.vnet.ibm.com
References: <1517562822-6293-1-git-send-email-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517562822-6293-1-git-send-email-parri.andrea@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020223-0048-0000-0000-000002319C51
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008463; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00984178; UDB=6.00499204; IPR=6.00763456;
 BA=6.00005809; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019342; XFM=3.00000015;
 UTC=2018-02-02 23:51:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020223-0049-0000-0000-000043FFE14C
Message-Id: <20180202235102.GC3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802020285
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 10:13:42AM +0100, Andrea Parri wrote:
> Now that a formal specification of the LKMM has become available to
> the developer, some concern about how to track changes to the model
> on the level of the "high-level documentation" was raised.
> 
> A first "mitigation" to this issue, suggested by Will, is to assign
> maintainership (and responsibility!!)  of such documentation (here,
> memory-barriers.txt) to the maintainers of the LKMM themselves.
> 
> Suggested-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>

Very good, thank you, queued!  Please see below for the usual commit-log
rework.  BTW, in future submissions, could you please capitalize the
first word after the colon (":") in the subject line?  It is all too
easy for me to forget to change this, as Ingo can attest.  ;-)

If we are going to continue to use the LKMM acronym, should we make the
first line of the MAINTAINERS block look something like this?

	LINUX KERNEL MEMORY CONSISTENCY MODEL (LKMM)

One alternative would be to start calling it LKMCM, though that does
look a bit like a Roman numeral.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit 2f80571625dc2d1977acdef79267ba1645b07c53
Author: Andrea Parri <parri.andrea@gmail.com>
Date:   Fri Feb 2 10:13:42 2018 +0100

    MAINTAINERS: List file memory-barriers.txt within the LKMM entry
    
    We now have a shiny new Linux-kernel memory model (LKMM) and the old
    tried-and-true Documentation/memory-barrier.txt.  It would be good to
    keep these automatically synchronized, but in the meantime we need at
    least let people know that they are related.  Will suggested adding the
    Documentation/memory-barrier.txt file to the LKMM maintainership list,
    thus making the LKMM maintainers responsible for both the old and the new.
    This commit follows Will's excellent suggestion.
    
    Suggested-by: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index ba4dc08fbe95..e6ad9b44e8fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8101,6 +8101,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
 F:	tools/memory-model/
+F:	Documentation/memory-barriers.txt
 
 LINUX SECURITY MODULE (LSM) FRAMEWORK
 M:	Chris Wright <chrisw@sous-sol.org>
