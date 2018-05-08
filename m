Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754009AbeEHFQb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 01:16:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46582 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeEHFQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 01:16:30 -0400
To: John Garry <john.garry@huawei.com>
Cc: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/11] hisi_sas: some misc patches
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1525276594-92173-1-git-send-email-john.garry@huawei.com>
Date: Tue, 08 May 2018 01:16:17 -0400
In-Reply-To: <1525276594-92173-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Wed, 2 May 2018 23:56:23 +0800")
Message-ID: <yq1tvriybfi.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=475
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080051
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This patchset introduces some misc changes for the
> driver. These include:
> - fixes for potential problems related to SCSI EH
>   and device removal races
> - fix protection info size for all hw versions
> - some SoC bug workarounds
> - minor optimisations
> - other more minor things

Applied to 4.18/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
