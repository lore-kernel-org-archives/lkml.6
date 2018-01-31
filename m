Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeAaCWF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 21:22:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36358 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbeAaCWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 21:22:03 -0500
To: Asutosh Das <asutoshd@codeaurora.org>
Cc: subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org,
        Sujit Reddy Thumma <sthumma@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 1/1] scsi: ufs: Enable quirk to ignore sending WRITE_SAME command
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1516767755-22855-1-git-send-email-asutoshd@codeaurora.org>
Date: Tue, 30 Jan 2018 21:21:55 -0500
In-Reply-To: <1516767755-22855-1-git-send-email-asutoshd@codeaurora.org>
        (Asutosh Das's message of "Wed, 24 Jan 2018 09:52:35 +0530")
Message-ID: <yq1wozyg43g.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8790 signatures=668657
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=485
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801310026
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Asutosh,

>  	/* WRITE_SAME command is not supported*/
>  	sdev->no_write_same = 1;
>  
> +	/* WRITE_SAME command is not supported*/
> +	sdev->no_write_same = 1;
> +

Uhm...

I applied this change to 4.16/scsi-fixes by hand.

-- 
Martin K. Petersen	Oracle Linux Engineering
