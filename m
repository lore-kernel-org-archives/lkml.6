Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbeCMCGt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 22:06:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49292 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932266AbeCMCGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 22:06:48 -0400
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: jazz_esp, sun3x_esp: Pass struct device pointer in dma calls
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <S1751076AbeCGG4t/20180307065702Z+42@vger.kernel.org>
Date: Mon, 12 Mar 2018 22:06:06 -0400
In-Reply-To: <S1751076AbeCGG4t/20180307065702Z+42@vger.kernel.org> (Finn
        Thain's message of "Wed, 07 Mar 2018 17:56:41 +1100")
Message-ID: <yq13714g25t.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8830 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=884
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803130025
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Finn,

> In jazz_esp and sun3x_esp, the esp_driver_ops methods pass esp->dev
> in dma api calls as if it was a pointer to a struct device. But
> it actually points to a struct platform_device. Fix this.

Applied to 4.17/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
