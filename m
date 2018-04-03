Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbeDCRNe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:13:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751270AbeDCRNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:13:33 -0400
Date: Tue, 3 Apr 2018 10:14:23 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: SeongJae Park <sj38.park@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] memory-barriers.txt: Applies upstream changes to the
 Korean version
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180403092027.13471-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403092027.13471-1-sj38.park@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040317-0052-0000-0000-000002D3B5EC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008796; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012592; UDB=6.00516081; IPR=6.00791858;
 MB=3.00020396; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-03 17:13:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040317-0053-0000-0000-00005C349CF8
Message-Id: <20180403171423.GQ3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-03_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804030176
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 06:20:22PM +0900, SeongJae Park wrote:
> This patchset applies upstream changes for memory-barriers.txt to the Korean
> version of it.
> 
> SeongJae Park (5):
>   kokr/doc: READ_ONCE() now implies smp_barrier_depends()
>   kokr/doc: De-emphasize smp_read_barrier_depends
>   kokr/Documentation/memory-barriers.txt: Cross-reference
>     "tools/memory-model/"
>   kokr/memory-barriers: Fix description of data dependency barriers
>   kokr/locking/memory-barriers: De-emphasize smp_read_barrier_depends()
>     some more
> 
>  .../translations/ko_KR/memory-barriers.txt         | 50 +++++++++++++++-------
>  1 file changed, 34 insertions(+), 16 deletions(-)

Thank you!  I have pulled these into the "lkmm" branch of -rcu.

							Thanx, Paul
