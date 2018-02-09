Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753292AbeBIXti (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:49:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57862 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753073AbeBIXtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:49:36 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] scsi: NCR53c406a: avoid section mismatch with LTO
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180202131225.1658853-1-arnd@arndb.de>
        <20180202131225.1658853-3-arnd@arndb.de>
Date: Fri, 09 Feb 2018 18:47:41 -0500
In-Reply-To: <20180202131225.1658853-3-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 2 Feb 2018 14:12:16 +0100")
Message-ID: <yq1y3k1u3mq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8800 signatures=668666
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=504
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090300
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> Building with link time optimizations produces a false-postive section
> mismatch warning:

Applied to 4.17/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
