Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937036AbeE2CsR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 22:48:17 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59504 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932498AbeE2CsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 22:48:09 -0400
To: John Garry <john.garry@huawei.com>
Cc: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] hisi_sas: Misc improvements, bugfixes, etc.
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1526897365-228549-1-git-send-email-john.garry@huawei.com>
Date: Mon, 28 May 2018 22:47:50 -0400
In-Reply-To: <1526897365-228549-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Mon, 21 May 2018 18:09:12 +0800")
Message-ID: <yq1wovn2n55.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8907 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=555
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805290028
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This patchset introduces some misc improvements, bugfixes,
> and SoC workarounds for the driver, including:

> - workaround for v2 hw reset with SATA disks attached
> - LED SGPIO support for v3 hw
> - Fix for error path in task_prep function
> - change slot and disk allocation method to avoid
>   unknown SoC bugs
> - fix potential problem of removing the driver when
>   a disk is mounted
> - other more minor stuff

Applied to 4.18/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
