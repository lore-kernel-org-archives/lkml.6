Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeDTUaS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 16:30:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752590AbeDTUaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 16:30:15 -0400
Date: Fri, 20 Apr 2018 13:31:21 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 0/2] tools/memory-model: References updates
Reply-To: paulmck@linux.vnet.ibm.com
References: <1524241813-14045-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524241813-14045-1-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042020-0044-0000-0000-000004089D5D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008889; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01020807; UDB=6.00520894; IPR=6.00800045;
 MB=3.00020688; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-20 20:30:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042020-0045-0000-0000-0000083AA4A6
Message-Id: <20180420203121.GR26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804200207
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 06:30:11PM +0200, Andrea Parri wrote:
> A couple of fixes to our references and comments: the first updating
> ASPLOS information, the second adding a reference.

I applied both, thank you!

							Thanx, Paul

> Cheers,
>   Andrea
> 
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> 
> Andrea Parri (2):
>   tools/memory-model: Update ASPLOS information
>   tools/memory-model: Add reference for 'Simplifying ARM concurrency'
> 
>  tools/memory-model/Documentation/references.txt | 17 ++++++++++++-----
>  tools/memory-model/linux-kernel.bell            |  4 ++--
>  tools/memory-model/linux-kernel.cat             |  4 ++--
>  tools/memory-model/linux-kernel.def             |  4 ++--
>  4 files changed, 18 insertions(+), 11 deletions(-)
> 
> -- 
> 2.7.4
> 
