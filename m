Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933041AbeBVPOC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:14:02 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:57162 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932837AbeBVPN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:13:59 -0500
Date: Thu, 22 Feb 2018 23:13:49 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-crypto@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Rice <rob.rice@broadcom.com>, Steve Lin <steven.lin1@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: bcm: Delete an error message for a failed
 memory allocation in do_shash()
Message-ID: <20180222151349.GL29815@gondor.apana.org.au>
References: <68946b12-83d6-ab74-fd54-71b23cf9b7ef@users.sourceforge.net>
 <35f107c8-c640-07f9-c10f-83fbe1ce4259@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35f107c8-c640-07f9-c10f-83fbe1ce4259@users.sourceforge.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 10:39:25PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 14 Feb 2018 22:05:11 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
