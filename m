Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeDTWi2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 18:38:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49218 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeDTWiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 18:38:25 -0400
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: Kai.Makisara@kolumbus.fi, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: st: Replace GFP_ATOMIC with GFP_KERNEL in st_probe
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1523363879-31242-1-git-send-email-baijiaju1990@gmail.com>
Date: Fri, 20 Apr 2018 18:38:06 -0400
In-Reply-To: <1523363879-31242-1-git-send-email-baijiaju1990@gmail.com>
        (Jia-Ju Bai's message of "Tue, 10 Apr 2018 20:37:59 +0800")
Message-ID: <yq1y3hhh5bl.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8869 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=594
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804200225
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jia-Ju,

> st_probe() is never called in atomic context.

Applied patches 1 and 2 to 4.18/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
