Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeB1C62 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 21:58:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46362 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbeB1C60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 21:58:26 -0500
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: core: fix two wrong indentation cases
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1519631956-1775-1-git-send-email-jianchao.w.wang@oracle.com>
Date: Tue, 27 Feb 2018 21:58:21 -0500
In-Reply-To: <1519631956-1775-1-git-send-email-jianchao.w.wang@oracle.com>
        (Jianchao Wang's message of "Mon, 26 Feb 2018 15:59:16 +0800")
Message-ID: <yq1fu5l4y7m.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8817 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=653
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280033
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jianchao,

> No functional changes. Just fix two wrong indentation cases in
> scsi_finish_command and scsi_decide_disposition.

Applied to 4.17/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
