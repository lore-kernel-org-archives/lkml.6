Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968141AbeEYTnM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:43:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967784AbeEYTnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:43:09 -0400
Date: Fri, 25 May 2018 12:44:41 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, peterz@infradead.org, bigeasy@linutronix.de,
        qianyue.zj@alibaba-inc.com, efault@gmx.de
Subject: Re: [PATCH RFC rcu/x86] Provide early rcu_cpu_starting() callback
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180525191802.GA7141@linux.vnet.ibm.com>
 <20180525151933.7fac5e81@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525151933.7fac5e81@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052519-0056-0000-0000-00000455CD06
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009083; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000262; SDB=6.01037582; UDB=6.00530875; IPR=6.00816711;
 MB=3.00021296; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-25 19:43:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052519-0057-0000-0000-00000899EBCB
Message-Id: <20180525194441.GE3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805250204
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 03:19:33PM -0400, Steven Rostedt wrote:
> On Fri, 25 May 2018 12:18:02 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > [ paulmck: Add !SMP support, per 0day Test Robot report. ]
> 
> Somehow I read this as:
> 
>   [ paulmck: Add NR_CPUS=0 support ]
> 
> no idea why.

;-) ;-) ;-)

Well, there is a debate on out-of-thin-air (OOTA) values in the C11 and
C++11 memory models.  Maybe that is related?  ;-)

							Thanx, Paul
