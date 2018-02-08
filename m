Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeBHEJ1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 23:09:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751153AbeBHEJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 23:09:26 -0500
Date: Wed, 7 Feb 2018 20:09:29 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Christopher Lameter <cl@linux.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, mingo@redhat.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, brouer@redhat.com,
        rao.shoaib@oracle.com
Subject: Re: [PATCH 0/2] rcu: Transform kfree_rcu() into kvfree_rcu()
Reply-To: paulmck@linux.vnet.ibm.com
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
 <20180207021703.GC3617@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1802070854080.21329@nuc-kabylake>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1802070854080.21329@nuc-kabylake>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020804-0008-0000-0000-000002CE9021
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008494; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000249; SDB=6.00986543; UDB=6.00500676; IPR=6.00765907;
 BA=6.00005819; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019434; XFM=3.00000015;
 UTC=2018-02-08 04:09:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020804-0009-0000-0000-0000382FFFD5
Message-Id: <20180208040929.GQ3617@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802080036
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 08:55:47AM -0600, Christopher Lameter wrote:
> On Tue, 6 Feb 2018, Paul E. McKenney wrote:
> 
> > So it is OK to kvmalloc() something and pass it to either kfree() or
> > kvfree(), and it had better be OK to kvmalloc() something and pass it
> > to kvfree().
> 
> kvfree() is fine but not kfree().

Ah, even more fun, then!  ;-)

							Thanx, Paul
