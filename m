Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbeDJCHx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 22:07:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41428 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeDJCHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 22:07:52 -0400
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: devinfo: Add Microsoft iSCSI target to 1024 sector blacklist
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180326135651.8193-1-ross.lagerwall@citrix.com>
Date: Mon, 09 Apr 2018 22:07:42 -0400
In-Reply-To: <20180326135651.8193-1-ross.lagerwall@citrix.com> (Ross
        Lagerwall's message of "Mon, 26 Mar 2018 14:56:51 +0100")
Message-ID: <yq1woxf24r5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8858 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=637
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804100020
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ross,

> The Windows Server 2016 iSCSI target doesn't work with the Linux
> kernel initiator since the kernel started sending larger requests by
> default, nor does it implement the block limits VPD page. Apply the
> sector limit workaround for these targets.

Applied to 4.17/scsi-fixes, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
