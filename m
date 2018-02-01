Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbeBAKcD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:32:03 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57418 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbeBAKb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:31:59 -0500
Date: Thu, 1 Feb 2018 13:25:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: reduce false positives
Message-ID: <20180201102501.kc5pfxojn7fhxat4@mwanda>
References: <1517478532-5444-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517478532-5444-1-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8791 signatures=668659
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=694
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802010136
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 10:48:52AM +0100, Julia Lawall wrote:
> Some files use both a non-devm allocation and a devm_allocation.  Don't
> complain about a free when the same function contains a non-devm
> allocation.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 

That's surprising...  Do you have an example false positive?

regards,
dan carpenter
