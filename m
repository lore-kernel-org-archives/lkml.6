Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeCODhc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 23:37:32 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33390 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeCODhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 23:37:31 -0400
To: Colin King <colin.king@canonical.com>
Cc: James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: lpfc: make several unions static, fix non-ANSI prototype
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180313120849.30128-1-colin.king@canonical.com>
Date: Wed, 14 Mar 2018 23:37:21 -0400
In-Reply-To: <20180313120849.30128-1-colin.king@canonical.com> (Colin King's
        message of "Tue, 13 Mar 2018 12:08:49 +0000")
Message-ID: <yq1o9jq9fgu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=672
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150041
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There are several unions that are local to the source and do not need
> to be in global scope, so make them static. Also add in a missing void
> parameter to functions lpfc_nvme_cmd_template and
> lpfc_nvmet_cmd_template to clean up non-ANSI warning.

Applied to 4.17/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
