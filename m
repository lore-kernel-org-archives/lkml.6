Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C562CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85876214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85876214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free-electrons.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbeLDHxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:53:05 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45218 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbeLDHxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:53:04 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B545A207B0; Tue,  4 Dec 2018 08:53:02 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7F9DD20736;
        Tue,  4 Dec 2018 08:53:02 +0100 (CET)
Date:   Tue, 4 Dec 2018 08:53:02 +0100
From:   Antoine Tenart <antoine.tenart@free-electrons.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 11/34] dt-bindings: arm: Convert Alpine board/soc
 bindings to json-schema
Message-ID: <20181204075302.GC3173@kwain>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-12-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181203213223.16986-12-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Dec 03, 2018 at 03:32:00PM -0600, Rob Herring wrote:
> diff --git a/Documentation/devicetree/bindings/arm/al,alpine.yaml b/Documentation/devicetree/bindings/arm/al,alpine.yaml
> new file mode 100644
> index 000000000000..82e2fafdfece
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/al,alpine.yaml
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/al,alpine.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Annapurna Labs Alpine Platform Device Tree Bindings
> +
> +maintainers:
> +  - Tsahee Zidenberg <tsahee@annapurnalabs.com>

Could you add '- Antoine Tenart <antoine.tenart@bootlin.com>' here?

Thanks!
Antoine

> +description: test
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: al,alpine
> +  model:
> +    items:
> +      - const: "Annapurna Labs Alpine Dev Board"
> +
> +...
> -- 
> 2.19.1
> 

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
