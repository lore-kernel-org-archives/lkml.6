Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbeAaCYw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:24:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54052 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753146AbeAaCYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:24:50 -0500
To: Colin King <colin.king@canonical.com>
Cc: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Varun Prakash <varun@chelsio.com>, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: csiostor: remove redundant assignment to pointer 'ln'
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180124145801.18920-1-colin.king@canonical.com>
Date: Tue, 30 Jan 2018 21:24:41 -0500
In-Reply-To: <20180124145801.18920-1-colin.king@canonical.com> (Colin King's
        message of "Wed, 24 Jan 2018 14:58:01 +0000")
Message-ID: <yq1shamg3yu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8790 signatures=668657
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=734
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801310026
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> The pointer ln is assigned a value that is never read, it is re-assigned
> a new value in the list_for_each loop hence the initialization is
> redundant and can be removed.

Applied to 4.16/scsi-fixes. Thank you.

-- 
Martin K. Petersen	Oracle Linux Engineering
