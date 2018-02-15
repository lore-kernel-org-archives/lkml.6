Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425259AbeBOPxM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:53:12 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:39664 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425004AbeBOPxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:53:11 -0500
Date: Thu, 15 Feb 2018 23:53:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Fabien Dessenne <fabien.dessenne@st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Corentin LABBE <clabbe.montjoie@gmail.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Lionel Debieve <lionel.debieve@st.com>
Subject: Re: [PATCH 0/2] crypto: stm32/cryp - add AEAD cipher algorithms
Message-ID: <20180215155302.GQ7352@gondor.apana.org.au>
References: <1518008935-30428-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518008935-30428-1-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 02:08:53PM +0100, Fabien Dessenne wrote:
> This patchset depends on "crypto: engine - Permit to enqueue all async requests"
> proposed by Corentin Labbe [https://lkml.org/lkml/2018/1/26/608].
> stm32-cryp uses this updated crpyto engine to handle AEAD cipher algortihms.
> 
> Fabien Dessenne (2):
>   crypto: stm32/cryp - add aes gcm / ccm support
>   crypto: stm32/cryp - add stm32mp1 support

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
