Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753544AbeDTGHs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 02:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750751AbeDTGHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 02:07:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A479E217D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AIpwx49jJctlLYpHP3YK/v4b5X27fQGmSebzxtiF/c9B8MnzBwgW/kA2A4mm5y2IlP0WLN7kIU4YYuYrBBo+XsD7pDU=
MIME-Version: 1.0
In-Reply-To: <20180419140641.27926-7-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com> <20180419140641.27926-7-wsa+renesas@sang-engineering.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 20 Apr 2018 08:07:43 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcpOHF6a_XtvKD-PUw_CRsXXrb-fHSm+HOug9YX=zj68w@mail.gmail.com>
Message-ID: <CAJKOXPcpOHF6a_XtvKD-PUw_CRsXXrb-fHSm+HOug9YX=zj68w@mail.gmail.com>
Subject: Re: [PATCH 06/61] crypto: simplify getting .drvdata
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Kukjin Kim <kgene@kernel.org>,
        Jamie Iles <jamie@jamieiles.com>, linux-crypto@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 4:05 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Build tested only. buildbot is happy. Please apply individually.
>
>  drivers/crypto/exynos-rng.c       | 6 ++----
>  drivers/crypto/picoxcell_crypto.c | 6 ++----
>  2 files changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
