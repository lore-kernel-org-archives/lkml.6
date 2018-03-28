Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753716AbeC1WKl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:10:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51766 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753228AbeC1WKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:10:39 -0400
To: Colin King <colin.king@canonical.com>
Cc: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][scsi-next] scsi: core: remove redundant assignment to shost->use_blk_mq
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180328164142.27201-1-colin.king@canonical.com>
Date: Wed, 28 Mar 2018 18:10:31 -0400
In-Reply-To: <20180328164142.27201-1-colin.king@canonical.com> (Colin King's
        message of "Wed, 28 Mar 2018 17:41:42 +0100")
Message-ID: <yq1lgebhmw8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=574
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803280223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> The first assignment to shost->use_blk_mq is redundant as it is
> overwritten by the following statement. Remove this redundant code.

Applied to 4.16/scsi-fixes. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
