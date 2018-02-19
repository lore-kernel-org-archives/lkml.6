Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932305AbeBSUtX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:49:23 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34179 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932135AbeBSUtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:49:18 -0500
X-Google-Smtp-Source: AH8x227mt5h15QylE3DLoJqUATFZoavN/oG2B/il2US+yaW9dKJahKYfEUiD8XHh4V6sNKYJEcuriw==
Date: Mon, 19 Feb 2018 14:49:15 -0600
From: Rob Herring <robh@kernel.org>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>, Ofir Drang <ofir.drang@arm.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: Add DT bindings for ccree 710 and 630p
Message-ID: <20180219204915.wepfsovgnxf5ivx5@rob-hp-laptop>
References: <1519051887-4668-1-git-send-email-gilad@benyossef.com>
 <1519051887-4668-3-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519051887-4668-3-git-send-email-gilad@benyossef.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 02:51:22PM +0000, Gilad Ben-Yossef wrote:
> Add device tree bindings for Arm CryptoCell 710 and 630p hardware
> revisions.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> ---
>  Documentation/devicetree/bindings/crypto/arm-cryptocell.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
