Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754624AbeCGR0E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:26:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754469AbeCGR0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:26:01 -0500
Date: Wed, 7 Mar 2018 09:26:27 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: [PATCH tools/memory-model 0/4] Documentation updates and fixes
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030717-0048-0000-0000-00000246308B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008629; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00999660; UDB=6.00508496; IPR=6.00779066;
 MB=3.00019896; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-07 17:25:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030717-0049-0000-0000-0000445D270A
Message-Id: <20180307172627.GA15805@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=2
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070200
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch series adds some documentation and fixes to the Linux-kernel
memory model (LKMM):

1.	Add more text to meomry-barrier.txt to de-emphasize
	smp_read_barrier_depends().

2.	Remove mention of the now-obsolete docker and gentoo images
	from README.

3.	Add documentation for the new ISA2+pooncelock+pooncelock+pombonce
	litmus test.

4.	Update the removal of rb-dep, smp_read_barrier_depends(), and
	lockless_dereference() to reflect feedback.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/memory-barriers.txt                |   26 +++++++++++++++--------
 tools/memory-model/Documentation/cheatsheet.txt  |    6 ++---
 tools/memory-model/Documentation/explanation.txt |    4 +--
 tools/memory-model/README                        |   15 -------------
 tools/memory-model/linux-kernel.def              |    2 -
 tools/memory-model/litmus-tests/README           |    6 +++++
 6 files changed, 30 insertions(+), 29 deletions(-)
