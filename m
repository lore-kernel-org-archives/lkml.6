Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeEVSvt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:51:49 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37784 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeEVSvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:51:47 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] block: Create scsi_sense.h for SCSI and ATAPI
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180522181512.39316-1-keescook@chromium.org>
        <20180522181512.39316-4-keescook@chromium.org>
        <20180522183613.GA3784@infradead.org>
Date: Tue, 22 May 2018 14:50:43 -0400
In-Reply-To: <20180522183613.GA3784@infradead.org> (Christoph Hellwig's
        message of "Tue, 22 May 2018 11:36:13 -0700")
Message-ID: <yq1efi3bk3g.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8901 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=851
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805220198
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph,

> On Tue, May 22, 2018 at 11:15:09AM -0700, Kees Cook wrote:
>> Both SCSI and ATAPI share the sense header. In preparation for using the
>> struct scsi_sense_hdr more widely, move this into a separate header and
>> move the helper function to scsi_ioctl.c which is linked with CONFIG_IDE
>> by way of CONFIG_BLK_SCSI_REQUEST.
>
> Please keep the code where it is and just depend on SCSI on the legacy
> ide driver.  No need to do gymnastics just for a legacy case.

Yup, I agree.

-- 
Martin K. Petersen	Oracle Linux Engineering
