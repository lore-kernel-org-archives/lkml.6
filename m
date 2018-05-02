Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbeEBDcV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 23:32:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39080 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeEBDcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 23:32:18 -0400
To: Colin King <colin.king@canonical.com>
Cc: Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: isci: remove redundant check on in_connection_align_insertion_frequency
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180425105843.8607-1-colin.king@canonical.com>
Date: Tue, 01 May 2018 23:32:08 -0400
In-Reply-To: <20180425105843.8607-1-colin.king@canonical.com> (Colin King's
        message of "Wed, 25 Apr 2018 11:58:43 +0100")
Message-ID: <yq14ljq7mx3.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8880 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=717
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805020034
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> The sanity check on u->in_connection_align_insertion_frequency is
> being performed twice and hence the first check can be removed since
> it is redundant. Cleans up cppcheck warning:
>
> drivers/scsi/ibmvscsi/ibmvscsi.c:1711: (warning) Identical inner 'if'
> condition is always true.

Applied to 4.18/scsi-queue. Thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
