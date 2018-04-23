Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754115AbeDWHcW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:32:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751314AbeDWHcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:32:17 -0400
Date: Mon, 23 Apr 2018 09:32:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
        Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PULL 0/1] vfio-ccw: bug fix
In-Reply-To: <20180420082404.13949-1-cohuck@redhat.com>
References: <20180420082404.13949-1-cohuck@redhat.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18042307-0044-0000-0000-0000054B16BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042307-0045-0000-0000-0000288B4163
Message-Id: <20180423093209.77edeed4@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230082
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 10:24:03 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> The following changes since commit fae764912153065ea55eda47f834e0764a54df94:
> 
>   s390/signal: cleanup uapi struct sigaction (2018-04-17 10:36:12 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20180420
> 
> for you to fetch changes up to c25e3c8e91318ddc17261c7dff053e00a213f176:
> 
>   vfio: ccw: process ssch with interrupts disabled (2018-04-19 17:29:31 +0200)
> 
> ----------------------------------------------------------------
> A vfio-ccw bug fix (call ssch with interrupts disabled).
> 
> ----------------------------------------------------------------
> 
> Cornelia Huck (1):
>   vfio: ccw: process ssch with interrupts disabled
> 
>  drivers/s390/cio/vfio_ccw_fsm.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 

This is now queued in s390/linux:fixes for the next please-pull.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
