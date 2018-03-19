Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755305AbeCSGLi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 02:11:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755200AbeCSGLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 02:11:34 -0400
Date: Mon, 19 Mar 2018 07:11:26 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
        Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Halil Pasic <pasic@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PULL 0/2] vfio-ccw patches for 4.17
In-Reply-To: <20180305123116.4301-1-cohuck@redhat.com>
References: <20180305123116.4301-1-cohuck@redhat.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18031906-0008-0000-0000-000004DFAE60
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031906-0009-0000-0000-00001E72C3E5
Message-Id: <20180319071126.2ecaa081@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803190079
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Mar 2018 13:31:14 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> The following changes since commit 5628683cf77bc8dad3336a9b254e55f728f7c70e:
> 
>   s390/dasd: set timestamps unconditionally (2018-02-27 08:05:29 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20180305
> 
> for you to fetch changes up to 9851bc77e62499957567e7c39a5beba7d6de6296:
> 
>   vfio-ccw: fence off transport mode (2018-03-01 17:35:50 +0100)
> 
> ----------------------------------------------------------------
> A small documentation update, and reject transport mode requests
> (which we don't support).
> 
> ----------------------------------------------------------------
> 
> Cornelia Huck (2):
>   vfio-ccw: update documentation
>   vfio-ccw: fence off transport mode
> 
>  Documentation/s390/vfio-ccw.txt | 79 ++++++++++++++++++++---------------------
>  drivers/s390/cio/vfio_ccw_fsm.c |  5 +++
>  2 files changed, 43 insertions(+), 41 deletions(-)
 
This is now merged into s390/linux:features for the next merge window. Thanks Conny.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
