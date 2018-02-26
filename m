Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeBZWNP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:13:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751745AbeBZWNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:13:11 -0500
Date: Mon, 26 Feb 2018 14:13:34 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Next batch of LKMM patches
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022622-0052-0000-0000-000002BEB030
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995536; UDB=6.00506037; IPR=6.00774865;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 22:13:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022622-0053-0000-0000-00005BD26960
Message-Id: <20180226221334.GA1849@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260278
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The following set of LKMM patches in -rcu look to me to be ready to
send off.  If you disagree, please do let me know so that we can fix
whatever problems that there might be.  If I do not hear otherwise,
I will send them off this coming Friday.

							Thanx, Paul

------------------------------------------------------------------------

5bb25a486ccb "memory-barriers: More text to de-emphasize smp_read_barrier_depends()"
b59fd89b465f "tools/memory-model: Remove mention of docker/gentoo image"
d5e6bc0a0ed4 "tools/memory-order: Add documentation of new litmus test
3eab67f3c41b "tools/memory-model: Update: Remove rb-dep, smp_read_barrier_depends, and lockless_dereference"
