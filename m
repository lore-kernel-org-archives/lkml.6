Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbeECSWb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 14:22:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751075AbeECSWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 14:22:30 -0400
Date: Thu, 3 May 2018 11:23:44 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com
Subject: Re: [PATCH tip/core/rcu 16/22] EXP: rcu: Add debugging info to
 assertion
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180423023150.GA21533@linux.vnet.ibm.com>
 <1524450747-22778-16-git-send-email-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524450747-22778-16-git-send-email-paulmck@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050318-0040-0000-0000-0000042610A5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008963; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01027002; UDB=6.00524569; IPR=6.00806135;
 MB=3.00020910; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-03 18:22:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050318-0041-0000-0000-0000082C1947
Message-Id: <20180503182344.GB1981@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030157
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 07:32:21PM -0700, Paul E. McKenney wrote:
> The WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp()) in
> rcu_gp_cleanup() triggers (inexplicably, of course) every so often.
> This commit therefore extracts more information.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

This commit and the remaining ones in this series are deferred from
the next merge window to the one following, where modified versions
are actually able to find a problem.

							Thanx, Paul
