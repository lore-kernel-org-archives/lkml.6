Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbeDLVFe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:05:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751946AbeDLVFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:05:30 -0400
Date: Thu, 12 Apr 2018 14:06:27 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] tools/memory-model: Model 'smp_store_mb()'
Reply-To: paulmck@linux.vnet.ibm.com
References: <1523535770-10781-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523535770-10781-1-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18041221-0044-0000-0000-0000040300A4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008844; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01016983; UDB=6.00518660; IPR=6.00796220;
 MB=3.00020544; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-12 21:05:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041221-0045-0000-0000-00000835009A
Message-Id: <20180412210627.GF3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804120200
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 02:22:48PM +0200, Andrea Parri wrote:
> Hi,
> 
> This (tiny) series adds 'smp_store_mb()' to the model (patch 1/2), and
> it fixes a stylistic discrepancy in 'linux-kernel.def (patch 2/2).

I applied them both, thank you!

I had to apply 2/2 by hand for reasons that are not at all clear to
me.  Please check to make sure I got it right.

							Thanx, Paul

> Cheers,
>   Andrea
> 
> Andrea Parri (2):
>   tools/memory-model: Model 'smp_store_mb()'
>   tools/memory-model: Fix coding style in 'linux-kernel.def'
> 
>  tools/memory-model/linux-kernel.def | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> -- 
> 2.7.4
> 
