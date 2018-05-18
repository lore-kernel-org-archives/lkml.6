Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeEROjK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:39:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41152 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeEROjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:39:09 -0400
To: Kees Cook <keescook@chromium.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: ufshcd: Remove VLA usage
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180502235809.GA13998@beast>
Date: Fri, 18 May 2018 10:38:59 -0400
In-Reply-To: <20180502235809.GA13998@beast> (Kees Cook's message of "Wed, 2
        May 2018 16:58:09 -0700")
Message-ID: <yq1tvr5gha4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8897 signatures=668699
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=941
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805180160
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> On the quest to remove all VLAs from the kernel[1] this moves buffers
> off the stack. In the second instance, this collapses two separately
> allocated buffers into a single buffer, since they are used
> consecutively, which saves 256 bytes (QUERY_DESC_MAX_SIZE + 1) of
> stack space.

Applied to 4.18/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
