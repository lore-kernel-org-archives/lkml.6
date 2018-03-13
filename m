Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932501AbeCMB7k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 21:59:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58206 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751397AbeCMB72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 21:59:28 -0400
To: John Garry <john.garry@huawei.com>
Cc: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <hare@suse.de>,
        <linux-scsi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v4 0/10] hisi_sas: support x6000 board and some misc changes
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1520425514-205565-1-git-send-email-john.garry@huawei.com>
Date: Mon, 12 Mar 2018 21:59:07 -0400
In-Reply-To: <1520425514-205565-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Wed, 7 Mar 2018 20:25:04 +0800")
Message-ID: <yq1efkog2hg.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8830 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=555
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803130024
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This patchset primarily adds support for the Huawei x6000 board,
> which includes hip07 chipset. Unfortunately, due to some board
> layout differences with our development board, we need to set
> a PHY-related register differently for optimal signal quality. As
> such, a signal attenuation property is added to describe the
> differences in the boards and allow the PHY register to be set
> appropriately.

Applied to 4.17/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
