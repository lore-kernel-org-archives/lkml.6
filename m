Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752799AbeD0FYZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 01:24:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750982AbeD0FYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 01:24:23 -0400
Date: Fri, 27 Apr 2018 07:24:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
        Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PULL 0/1] vfio-ccw: another bugfix
In-Reply-To: <20180424112656.10243-1-cohuck@redhat.com>
References: <20180424112656.10243-1-cohuck@redhat.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18042705-0020-0000-0000-0000041690BE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042705-0021-0000-0000-000042AB9A87
Message-Id: <20180427072414.22118caa@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804270052
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018 13:26:55 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> The following changes since commit 6cf09958f32b9667bb3ebadf74367c791112771b:
> 
>   s390: correct module section names for expoline code revert (2018-04-23 07:57:17 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20180424
> 
> for you to fetch changes up to 427e522fc72395a4571b8dd7fe6d116927496bf7:
> 
>   vfio: ccw: fix cleanup if cp_prefetch fails (2018-04-23 14:11:20 +0200)
> 
> ----------------------------------------------------------------
> Another vfio-ccw bug fix: Don't clean up things on error that were
> never translated in the first place.
> 
> ----------------------------------------------------------------
> 
> Halil Pasic (1):
>   vfio: ccw: fix cleanup if cp_prefetch fails
> 
>  drivers/s390/cio/vfio_ccw_cp.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 

Now added the s390/linux:fixes. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
