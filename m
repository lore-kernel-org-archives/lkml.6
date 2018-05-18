Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeERQZ4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:25:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37802 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERQZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:25:52 -0400
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: qlogicpti: Fix an error handling path in 'qpti_sbus_probe()'
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180510114558.20769-1-christophe.jaillet@wanadoo.fr>
Date: Fri, 18 May 2018 12:25:46 -0400
In-Reply-To: <20180510114558.20769-1-christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Thu, 10 May 2018 13:45:58 +0200")
Message-ID: <yq1h8n5exrp.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8897 signatures=668699
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=648
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805180177
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> The 'free_irq()' call is not at the right place in the error handling
> path.  The changed order has been introduced in commit 3d4253d9afab
> ("[SCSI] qlogicpti: Convert to new SBUS device framework.")

Applied to 4.18/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
