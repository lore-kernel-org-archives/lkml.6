Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031958AbeE2Bcq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:32:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53384 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936805AbeE2Bcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:32:42 -0400
To: Colin King <colin.king@canonical.com>
Cc: "Nicholas A . Bellinger" <nab@linux-iscsi.org>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: target: fix spelling mistake "Uknown" -> "Unknown"
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180526150229.10416-1-colin.king@canonical.com>
Date: Mon, 28 May 2018 21:32:33 -0400
In-Reply-To: <20180526150229.10416-1-colin.king@canonical.com> (Colin King's
        message of "Sat, 26 May 2018 16:02:29 +0100")
Message-ID: <yq160374572.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8907 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=375
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805290016
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Trivial fix to spelling mistake in pr_err message text

Applied to 4.18/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
