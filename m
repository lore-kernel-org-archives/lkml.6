Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9694CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C72B208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C72B208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeHQRNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:13:15 -0400
Received: from foss.arm.com ([217.140.101.70]:47722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeHQRNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:13:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A33580D;
        Fri, 17 Aug 2018 07:09:45 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EAD53F5BC;
        Fri, 17 Aug 2018 07:09:42 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: irqchip: renesas-irqc: Document r8a774a1
 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <1534250008-15680-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <4177b31e-dbef-a2f1-fc63-927fe8f70713@arm.com>
Date:   Fri, 17 Aug 2018 15:09:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534250008-15680-1-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/18 13:33, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
> index 697ca2f2..a046ed3 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
> @@ -13,6 +13,7 @@ Required properties:
>      - "renesas,irqc-r8a7792" (R-Car V2H)
>      - "renesas,irqc-r8a7793" (R-Car M2-N)
>      - "renesas,irqc-r8a7794" (R-Car E2)
> +    - "renesas,intc-ex-r8a774a1" (RZ/G2M)
>      - "renesas,intc-ex-r8a7795" (R-Car H3)
>      - "renesas,intc-ex-r8a7796" (R-Car M3-W)
>      - "renesas,intc-ex-r8a77965" (R-Car M3-N)
> 

Queued, thanks.

	M.
-- 
Jazz is not dead. It just smells funny...
