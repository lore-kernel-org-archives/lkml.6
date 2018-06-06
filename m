Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752714AbeFFBiu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 21:38:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59708 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbeFFBis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 21:38:48 -0400
To: Colin King <colin.king@canonical.com>
Cc: Hannes Reinecke <hare@suse.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: aic7xxx: aic79xx: fix potential null pointer dereference on ahd
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180531123117.32118-1-colin.king@canonical.com>
Date: Tue, 05 Jun 2018 21:38:37 -0400
In-Reply-To: <20180531123117.32118-1-colin.king@canonical.com> (Colin King's
        message of "Thu, 31 May 2018 13:31:17 +0100")
Message-ID: <yq1vaawelsy.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8915 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=566
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806060015
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> If AHD_DEBUG is enabled and ahd_platform_alloc fails then ahd is set
> to null and the debug printk dereferences ahd when passing it to
> ahd_name.  Fix this by moving the debug printk to before the call to
> ahd_platform_alloc where ahd is not null at that point.

Applied to 4.18/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
