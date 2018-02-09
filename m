Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753361AbeBIXY7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:24:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48156 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbeBIXY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:24:57 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        QLogic-Storage-Upstream@cavium.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Chad Dupuis <chad.dupuis@cavium.com>,
        Nilesh Javali <nilesh.javali@cavium.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] scsi: qedf: fix LTO-enabled build
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180202131225.1658853-1-arnd@arndb.de>
        <20180202131225.1658853-5-arnd@arndb.de>
Date: Fri, 09 Feb 2018 18:24:42 -0500
In-Reply-To: <20180202131225.1658853-5-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 2 Feb 2018 14:12:18 +0100")
Message-ID: <yq1mv0hvj9h.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8800 signatures=668666
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=481
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090294
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> The prototype for qedf_dbg_fops/qedf_debugfs_ops doesn't match the
> definition, which causes the final link to fail with link-time
> optimizations:

Applied to 4.17/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
