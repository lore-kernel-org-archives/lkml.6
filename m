Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753776AbeC1WR3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:17:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57418 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753293AbeC1WR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:17:27 -0400
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] scsi: don't look for NULL devices handlers by name
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180323133705.14556-1-jthumshirn@suse.de>
Date: Wed, 28 Mar 2018 18:16:57 -0400
In-Reply-To: <20180323133705.14556-1-jthumshirn@suse.de> (Johannes Thumshirn's
        message of "Fri, 23 Mar 2018 14:37:05 +0100")
Message-ID: <yq1bmf7hmli.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=393
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803280223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Johannes,

> Currently scsi_dh_lookup() doesn't check for NULL as a device
> name. This combined with nvme over dm-mapth results in the following
> messages emitted by device-mapper:

Applied to 4.16/scsi-fixes. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
