Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752385AbeDSEJZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 00:09:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51252 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbeDSEJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 00:09:24 -0400
To: Colin King <colin.king@canonical.com>
Cc: Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mptfc: fix spelling mistake in macro names
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180418113038.1239-1-colin.king@canonical.com>
Date: Thu, 19 Apr 2018 00:09:16 -0400
In-Reply-To: <20180418113038.1239-1-colin.king@canonical.com> (Colin King's
        message of "Wed, 18 Apr 2018 12:30:38 +0100")
Message-ID: <yq1y3hjltw3.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8867 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=419
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804190036
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Rename macros MPI_FCPORTPAGE0_SUPPORT_SPEED_UKNOWN and
> MPI_FCPORTPAGE0_CURRENT_SPEED_UKNOWN to add in missing N in UNKNOWN

Applied to 4.18/scsi-queue. Thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
