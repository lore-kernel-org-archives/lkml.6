Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeEOCtJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 22:49:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52702 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeEOCtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 22:49:08 -0400
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, LKML <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] scsi: clean up generated file scsi_devinfo_tbl.c
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <6e64c815-43dd-3945-6c58-66b1e0533403@infradead.org>
Date: Mon, 14 May 2018 22:48:38 -0400
In-Reply-To: <6e64c815-43dd-3945-6c58-66b1e0533403@infradead.org> (Randy
        Dunlap's message of "Sun, 13 May 2018 17:10:52 -0700")
Message-ID: <yq17eo5my61.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8893 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=586
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805150026
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Randy,

> "make clean" should remove the generated file "scsi_devinfo_tbl.c", so
> list it in the clean-files variable so that the file gets cleaned up.

Applied to 4.17/scsi-fixes. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
