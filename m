Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753791AbeDTRGn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:06:43 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:34466 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753435AbeDTRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:05:52 -0400
Date: Sat, 21 Apr 2018 01:05:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Wang <davidwang@zhaoxin.com>
Cc: mpm@selenic.com, arnd@arndb.de, grehkg@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        brucechang@via-alliance.com, cooperyan@zhaoxin.com,
        qiyuanwang@zhaoxin.com, benjaminpan@viatech.com, lukelin@viacpu.com,
        timguo@zhaoxin.com
Subject: Re: [PATCH] hwrng: via-rng - support new Centaur CPU
Message-ID: <20180420170536.rglsnmjqqndywb6t@gondor.apana.org.au>
References: <1523602983-3418-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523602983-3418-1-git-send-email-davidwang@zhaoxin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 03:03:03PM +0800, David Wang wrote:
> New Centaur CPU(Family > 6) supprt Random Number Generator, but can't
> support MSR_VIA_RNG. Just like VIA Nano.
> 
> Signed-off-by: David Wang <davidwang@zhaoxin.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
