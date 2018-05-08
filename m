Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754105AbeEHF1M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 01:27:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58060 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbeEHF1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 01:27:10 -0400
To: Colin King <colin.king@canonical.com>
Cc: James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] scsi: lpfc: fix spelling mistakes: "mabilbox" and "maibox"
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180503092612.30007-1-colin.king@canonical.com>
Date: Tue, 08 May 2018 01:27:01 -0400
In-Reply-To: <20180503092612.30007-1-colin.king@canonical.com> (Colin King's
        message of "Thu, 3 May 2018 10:26:12 +0100")
Message-ID: <yq14ljiyaxm.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=586
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080053
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Trivial fix to spelling mistakes in lpfc_printf_log log message
>
> "mabilbox" -> "mailbox"
> "maibox" -> "mailbox"

Applied to 4.18/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
