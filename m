Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeDLV2m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:28:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45982 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbeDLV2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:28:41 -0400
To: Micah Parrish <micah.parrish@hpe.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, pragyansri.pathi@intel.com,
        jeffrey.wang@seagate.com, Kieulien.Dang@seagate.com
Subject: Re: [PATCH] NVMe: Add Quirk Delay before CHK RDY for Seagate Nytro Flash Storage
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
References: <1523561125-31945-1-git-send-email-micah.parrish@hpe.com>
Date: Thu, 12 Apr 2018 17:28:18 -0400
In-Reply-To: <1523561125-31945-1-git-send-email-micah.parrish@hpe.com> (Micah
        Parrish's message of "Thu, 12 Apr 2018 13:25:25 -0600")
Message-ID: <yq1r2nkunbh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8861 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=673
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804120203
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Micah,

> Add Seagate Nytro Flash Storage nvme drive to quirk list for
> NVME_QUIRK_DELAY_BEFORE_CHK_RDY, which solves a bug where the drive is
> probed on hot-add before the firmare is ready, I/O errors are generated
> while reading sector 0, and linux is "unable to read partition table".

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
