Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeDJBSJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:18:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41370 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbeDJBSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:18:07 -0400
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2] qla2xxx: correctly shift host byte
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180409122423.32231-1-jthumshirn@suse.de>
Date: Mon, 09 Apr 2018 21:17:59 -0400
In-Reply-To: <20180409122423.32231-1-jthumshirn@suse.de> (Johannes Thumshirn's
        message of "Mon, 9 Apr 2018 14:24:23 +0200")
Message-ID: <yq1muyb3lmg.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8858 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=637
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804100012
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Johannes,

> The SCSI host byte has to be shifted by 16 not 6.
>
> As Bart pointed out this patch does not change any functionality
> because DID_OK == 0, but a wrong shift is irritating for the reviewer.

Applied to 4.17/scsi-fixes. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
