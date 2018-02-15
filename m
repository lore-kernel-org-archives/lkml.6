Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425246AbeBOPxA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:53:00 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:39656 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425110AbeBOPw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:52:57 -0500
Date: Thu, 15 Feb 2018 23:52:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Colin King <colin.king@canonical.com>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: qat - Make several functions static
Message-ID: <20180215155243.GP7352@gondor.apana.org.au>
References: <20180206233642.14591-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206233642.14591-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 11:36:42PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Functions qat_rsa_set_n, qat_rsa_set_e and qat_rsa_set_n are local to
> the source and do not need to be in global scope, so make them static.
> 
> Cleans up sparse warnings:
> drivers/crypto/qat/qat_common/qat_asym_algs.c:972:5: warning: symbol
> 'qat_rsa_set_n' was not declared. Should it be static?
> drivers/crypto/qat/qat_common/qat_asym_algs.c:1003:5: warning: symbol
> 'qat_rsa_set_e' was not declared. Should it be static?
> drivers/crypto/qat/qat_common/qat_asym_algs.c:1027:5: warning: symbol
> 'qat_rsa_set_d' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
