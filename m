Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753890AbeCFSKV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:10:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60902 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeCFSKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 13:10:19 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mpt3sas: clarify mmio pointer types
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180301130729.3278022-1-arnd@arndb.de>
Date: Tue, 06 Mar 2018 13:09:15 -0500
In-Reply-To: <20180301130729.3278022-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Thu, 1 Mar 2018 14:07:07 +0100")
Message-ID: <yq1zi3lqdo4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8824 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=602
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060200
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> The newly added code mixes up phys_addr_t/resource_size_t with dma_addr_t
> and void pointers, as seen from these compiler warning:

Applied to 4.17/scsi-queue. Thanks for fixing this up!

-- 
Martin K. Petersen	Oracle Linux Engineering
