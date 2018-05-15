Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeEODk1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 23:40:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752009AbeEODk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 23:40:26 -0400
Date: Mon, 14 May 2018 20:41:52 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joe Perches <joe@perches.com>
Cc: Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] rcu: Use pr_fmt to prefix "rcu: " to logging output
Reply-To: paulmck@linux.vnet.ibm.com
References: <cover.1525964381.git.joe@perches.com>
 <41d9686471d67f6f98d160e5891bf61061515b6d.1525964386.git.joe@perches.com>
 <20180514202910.GI26088@linux.vnet.ibm.com>
 <32216d8f154b29400d4c11bae91850591114f7f8.camel@perches.com>
 <20180514222456.GO26088@linux.vnet.ibm.com>
 <3c7770a062355650fb61e48a5fbeb9653d98d85a.camel@perches.com>
 <20180514235832.GR26088@linux.vnet.ibm.com>
 <0cb282d85c37d9b626933a03574848d17430f04c.camel@perches.com>
 <20180515003205.GT26088@linux.vnet.ibm.com>
 <56600822d01be60bd96c45afe1bbcad823ac948d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56600822d01be60bd96c45afe1bbcad823ac948d.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051503-0008-0000-0000-00000307A12A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009027; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032466; UDB=6.00527834; IPR=6.00811597;
 MB=3.00021117; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-15 03:40:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051503-0009-0000-0000-00003940B1AD
Message-Id: <20180515034152.GW26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150036
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 06:22:02PM -0700, Joe Perches wrote:
> On Mon, 2018-05-14 at 17:32 -0700, Paul E. McKenney wrote:
> > So this change does not affect WARN_ON_ONCE() and friends?
> 
> Changing define pr_fmt does not modify WARN_ON output.

Very good, I removed my --squash patch adding pr_fmt() to the file
kernel/rcu/rcu_segcblist.c.

							Thanx, Paul
