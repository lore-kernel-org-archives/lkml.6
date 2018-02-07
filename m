Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932213AbeBGB0e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:26:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42296 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754189AbeBGB0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:26:32 -0500
To: Colin King <colin.king@canonical.com>
Cc: Johannes Thumshirn <jth@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: libfc: remove redundant initialization of 'disc'
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180206142157.32001-1-colin.king@canonical.com>
Date: Tue, 06 Feb 2018 20:26:23 -0500
In-Reply-To: <20180206142157.32001-1-colin.king@canonical.com> (Colin King's
        message of "Tue, 6 Feb 2018 14:21:57 +0000")
Message-ID: <yq1y3k5zj28.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8797 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=603
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802070013
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Pointer disc is being intializated a value that is never read and then
> re-assigned the same value later on, hence the initialization is redundant
> and can be removed.

Applied to 4.17/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
