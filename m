Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeAaCwD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:52:03 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44594 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbeAaCwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:52:01 -0500
To: Corentin Labbe <clabbe@baylibre.com>
Cc: hare@suse.com, jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: aic7xxx: remove really aiclib.c
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1517124234-23425-1-git-send-email-clabbe@baylibre.com>
Date: Tue, 30 Jan 2018 21:51:52 -0500
In-Reply-To: <1517124234-23425-1-git-send-email-clabbe@baylibre.com> (Corentin
        Labbe's message of "Sun, 28 Jan 2018 07:23:54 +0000")
Message-ID: <yq17eryg2pj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8790 signatures=668657
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=549
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801310032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Corentin,

> aiclib.c is unused (and contain no code) since commit 1ff927306e08
> ("[SCSI] aic7xxx: remove aiclib.c")
> 13 years later, finish the cleaning by remove it from tree.

Applied to 4.16/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
