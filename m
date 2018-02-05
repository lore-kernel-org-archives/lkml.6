Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbeBEGxc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:53:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750949AbeBEGx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:53:27 -0500
Date: Mon, 5 Feb 2018 07:53:18 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the s390 tree
In-Reply-To: <20180203130348.74f7b89b@canb.auug.org.au>
References: <20180203130348.74f7b89b@canb.auug.org.au>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18020506-0040-0000-0000-0000042C67C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020506-0041-0000-0000-000020D01169
Message-Id: <20180205075318.32ef7fd4@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802050087
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Sat, 3 Feb 2018 13:03:48 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Commits
> 
>   a39892ed47bf ("s390/runtime_instrumentation: re-add signum system call parameter")
>   279d2cea3aad ("s390/cio: fix kernel-doc usage")
> 
> are missing a Signed-off-by from their committer.

Thanks for the heads up, fixed it.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
