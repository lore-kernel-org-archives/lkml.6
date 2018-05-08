Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754161AbeEHF1s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 01:27:48 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43772 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbeEHF1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 01:27:46 -0400
To: Colin King <colin.king@canonical.com>
Cc: Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mptsas: fix spelling mistake: "matchs" -> "matches"
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180503101807.30482-1-colin.king@canonical.com>
Date: Tue, 08 May 2018 01:27:39 -0400
In-Reply-To: <20180503101807.30482-1-colin.king@canonical.com> (Colin King's
        message of "Thu, 3 May 2018 11:18:07 +0100")
Message-ID: <yq1zi1awwc4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=531
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080053
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Trivial fix to spelling mistake in warning message

Applied to 4.18/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
