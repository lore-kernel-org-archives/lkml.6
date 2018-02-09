Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753309AbeBIXou (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:44:50 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42228 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753167AbeBIXor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:44:47 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        QLogic-Storage-Upstream@cavium.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Saurav Kashyap <saurav.kashyap@cavium.com>,
        "Dupuis\, Chad" <chad.dupuis@cavium.com>,
        Arun Easi <arun.easi@cavium.com>,
        Nilesh Javali <nilesh.javali@cavium.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] scsi: qedf: use correct strncpy() size
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180202131225.1658853-1-arnd@arndb.de>
        <20180202131225.1658853-7-arnd@arndb.de>
Date: Fri, 09 Feb 2018 18:36:53 -0500
In-Reply-To: <20180202131225.1658853-7-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 2 Feb 2018 14:12:20 +0100")
Message-ID: <yq1bmgxvip6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8800 signatures=668666
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=652
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090299
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> gcc-8 warns during link-time optimization that the strncpy() call
> passes the size of the source buffer rather than the destination:

Applied to 4.17/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
