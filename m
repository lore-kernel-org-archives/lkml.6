Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeEEHRM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 03:17:12 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:35162 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeEEHRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 03:17:10 -0400
Date: Sat, 5 May 2018 15:16:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lionel Debieve <lionel.debieve@st.com>
Cc: Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <rob.herring@linaro.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: Re: [PATCH 0/2] Fix stm32-rng for default state and suspend
Message-ID: <20180505071651.qmroqj3ys3pve2x7@gondor.apana.org.au>
References: <20180423150426.22198-1-lionel.debieve@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423150426.22198-1-lionel.debieve@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 05:04:24PM +0200, Lionel Debieve wrote:
> This series are fixing the default build state for stm32-rng that
> activate the driver with arm multi_v7_defconfig.
> Second patch is fixing the power suspend/resume behavior which was
> not working.
> 
> Lionel Debieve (2):
>   hwrng: stm32 - define default state for rng driver
>   hwrng: stm32-rng: Fix pm_suspend issue
> 
>  drivers/char/hw_random/Kconfig     | 1 +
>  drivers/char/hw_random/stm32-rng.c | 9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
