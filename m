Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935572AbeEJMqB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:46:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49000 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935393AbeEJMp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:45:59 -0400
Date: Thu, 10 May 2018 15:45:46 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: qlogicpti: Fix an error handling path in
 'qpti_sbus_probe()'
Message-ID: <20180510124546.gp5f66ugkivwfbhn@mwanda>
References: <20180510114558.20769-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510114558.20769-1-christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8888 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=733
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805100123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 01:45:58PM +0200, Christophe JAILLET wrote:
> The 'free_irq()' call is not at the right place in the error handling path.
> The changed order has been introduced in commit 3d4253d9afab
> ("[SCSI] qlogicpti: Convert to new SBUS device framework.")
> 
> Fixes: 3d4253d9afab ("[SCSI] qlogicpti: Convert to new SBUS device framework.")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Please review carefully.  This patch is proposed because it triggers one of
> my coccinelle scripts. I'm not 100% sure if correct.

Looks good to me.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter
