Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeBHGIX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 01:08:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52896 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751788AbeBHGIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 01:08:21 -0500
Date: Thu, 8 Feb 2018 07:08:12 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the s390 tree
In-Reply-To: <20180208073539.706e942f@canb.auug.org.au>
References: <20180208073539.706e942f@canb.auug.org.au>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18020806-0020-0000-0000-000003F38154
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020806-0021-0000-0000-00004285FE01
Message-Id: <20180208070812.7dd4e1b6@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802080061
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2018 07:35:39 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Commit
> 
>   b175210bd231 ("s390/kconfig: Remove ARCH_WANTS_PROT_NUMA_PROT_NONE select")
> 
> is missing a Signed-off-by from its committer.
 
It is always that "last" one you add. Fixed. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
