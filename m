Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeCZWaB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:30:01 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36793 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbeCZWYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:24:30 -0400
X-Google-Smtp-Source: AG47ELsD9YAvUMsFKMAxrSfcLX8M4vBCGRjynvqXPuv9TmR+TxFxJB7msZD/C4v9kJqqgTOMgwtagQ==
Date: Mon, 26 Mar 2018 17:24:28 -0500
From: Rob Herring <robh@kernel.org>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/7] dt-bindings: add cdtech vendor prefix
Message-ID: <20180326222428.wblragf6dqj6q2xo@rob-hp-laptop>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 09:03:07PM +0100, Giulio Benetti wrote:
> This adds a vendor prefix "cdtech" for CDTech(H.K.) Electronics Limited

Would be good to have website and/or info about what this company does.

> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

In any case,

Reviewed-by: Rob Herring <robh@kernel.org>
