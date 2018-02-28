Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751723AbeB1CTp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 21:19:45 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60416 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbeB1CTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 21:19:44 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: QLogic-Storage-Upstream@cavium.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Manish Rangankar <Manish.Rangankar@cavium.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qedi: fix build regression
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180226094422.2607574-1-arnd@arndb.de>
Date: Tue, 27 Feb 2018 21:19:32 -0500
In-Reply-To: <20180226094422.2607574-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Mon, 26 Feb 2018 10:44:14 +0100")
Message-ID: <yq1woyx500b.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8817 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=714
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280026
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> A bugfix I did caused a build regression in some other randconfig
> builds in a rare combination of options:
>
> In file included from drivers/scsi/qedi/qedi_fw.c:16:
> drivers/scsi/qedi/qedi_gbl.h:26:38: error: array type has incomplete element type 'struct qedi_debugfs_ops'
>  extern const struct qedi_debugfs_ops qedi_debugfs_ops[];
>                                       ^~~~~~~~~~~~~~~~
>
> This removes the useless #ifdef around the declarations in qedi_dbg.h
> to make it always build.

Applied to 4.17/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
