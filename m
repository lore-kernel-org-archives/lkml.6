Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeEOCv4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 22:51:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34516 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752310AbeEOCvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 22:51:53 -0400
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] mptlan: fix mpt_lan_sdu_send()'s return type
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180424131558.3010-1-luc.vanoostenryck@gmail.com>
        <yq1h8niyb63.fsf@oracle.com>
        <20180508154415.neutsgpi2nwffwec@ltop.local>
Date: Mon, 14 May 2018 22:51:38 -0400
In-Reply-To: <20180508154415.neutsgpi2nwffwec@ltop.local> (Luc Van
        Oostenryck's message of "Tue, 8 May 2018 17:44:16 +0200")
Message-ID: <yq136ytmy11.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8893 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=517
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805150027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Luc,

>> You forgot to update the function prototype accordingly.
>
> Hmmm, the function mpt_lan_sdu_send() has no other declaration
> than the one I modified the return type in this patch.
>
> Must be a misunderstanding somewhere.

My bad, I thought you were updating mpt_lan_send_reply().

Applied to 4.18/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
