Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeERQ0l (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:26:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51988 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbeERQ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:26:39 -0400
To: Colin King <colin.king@canonical.com>
Cc: Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: snic: fix a couple of spelling mistakes: "COMPLETE"
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180517075738.22821-1-colin.king@canonical.com>
Date: Fri, 18 May 2018 12:26:29 -0400
In-Reply-To: <20180517075738.22821-1-colin.king@canonical.com> (Colin King's
        message of "Thu, 17 May 2018 08:57:38 +0100")
Message-ID: <yq18t8hexqi.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8897 signatures=668699
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=663
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805180177
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Trivial fix to spelling mistakes/typos:
> "SNIC_IOREQ_ABTS_COMPELTE" -> "SNIC_IOREQ_ABTS_COMPLETE"
> "SNIC_IOREQ_LR_COMPELTE"   -> "SNIC_IOREQ_LR_COMPLETE"
> "SNIC_IOREQ_CMD_COMPELTE"  -> "SNIC_IOREQ_CMD_COMPLETE"

Applied to 4.18/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
