Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932324AbeBGBb0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:31:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39946 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932184AbeBGBbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:31:24 -0500
To: Colin King <colin.king@canonical.com>
Cc: QLogic-Storage-Upstream@cavium.com,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qedf: remove redundant initialization of 'fcport'
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180206140316.31453-1-colin.king@canonical.com>
Date: Tue, 06 Feb 2018 20:25:39 -0500
In-Reply-To: <20180206140316.31453-1-colin.king@canonical.com> (Colin King's
        message of "Tue, 6 Feb 2018 14:03:16 +0000")
Message-ID: <yq1372d1tgs.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8797 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=623
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802070014
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Pointer fcport is initialized with a value that is never read, it is
> re-assigned a new value later on, hence the initialization is redundant
> and can be removed.

Applied to 4.17/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
