Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751763AbeEVRrD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:47:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751425AbeEVRqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:46:55 -0400
Date: Tue, 22 May 2018 10:47:11 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, byungchul.park@lge.com,
        mathieu.desnoyers@efficios.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: Tasks RCU vs Preempt RCU
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180519022918.GV3803@linux.vnet.ibm.com>
 <20180519225905.GB134184@joelaf.mtv.corp.google.com>
 <20180520004938.GZ3803@linux.vnet.ibm.com>
 <20180520112843.57079857@grimm.local.home>
 <20180520191846.GA248075@joelaf.mtv.corp.google.com>
 <20180521215951.2d6abfcb@gandalf.local.home>
 <20180522045414.GG40541@joelaf.mtv.corp.google.com>
 <20180522083832.45353d5f@gandalf.local.home>
 <20180522160949.GU3803@linux.vnet.ibm.com>
 <20180522132700.68b6660d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522132700.68b6660d@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052217-0028-0000-0000-000009AAC571
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009066; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036108; UDB=6.00530013; IPR=6.00815236;
 MB=3.00021242; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-22 17:46:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052217-0029-0000-0000-00003AF2084D
Message-Id: <20180522174711.GY3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220191
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 01:27:00PM -0400, Steven Rostedt wrote:
> On Tue, 22 May 2018 09:09:49 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > Just for the record, if you guys realy want to take over Tasks RCU,
> > I have no objections.  For one thing, I don't anticipate any other use
> > cases for it (famous last words!).  But you break it, you buy it!  ;-)
> 
> It really matters how much of a burden is RCU_tasks to RCU itself? If
> it causes a lot of headache for you, and it prevents you from cleaning
> up RCU or making it better, then I would be happy to take it out of RCU
> and maintain it separately myself. But if that's not the case, I'm happy
> with keeping it within the RCU umbrella. Which brings me to the
> question of what motivation does Joel have to remove it?

The burden on me from Tasks RCU has been quite light, so no need for a
change from my end.

Over to you, Joel!  ;-)

							Thanx, Paul
