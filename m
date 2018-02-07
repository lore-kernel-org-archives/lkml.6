Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932281AbeBGB32 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:29:28 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54932 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932184AbeBGB30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:29:26 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        QLogic-Storage-Upstream@cavium.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Manish Rangankar <Manish.Rangankar@cavium.com>,
        Tomer Tayar <Tomer.Tayar@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ariel Elior <Ariel.Elior@cavium.com>, Arun Easi <arun.easi@cavium.com>,
        Nilesh Javali <nilesh.javali@cavium.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] scsi: qedi: fix building with LTO
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180202131225.1658853-1-arnd@arndb.de>
        <20180202131225.1658853-6-arnd@arndb.de>
Date: Tue, 06 Feb 2018 20:24:08 -0500
In-Reply-To: <20180202131225.1658853-6-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 2 Feb 2018 14:12:19 +0100")
Message-ID: <yq17erp1tjb.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8797 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=514
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802070014
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> When link-time optimizations are enabled, qedi fails to build because
> of mismatched prototypes:

Applied to 4.17/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
