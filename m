Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162370AbeCAVvr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:51:47 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46268 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162122AbeCAVvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:51:44 -0500
X-Google-Smtp-Source: AG47ELtVQXg4mn99hq3z0BGpi833VuR7xWhRbQxicfOXz6byH5cfPaZXR4uiWXhwLg9qCCsraqw0kg==
Date: Thu, 1 Mar 2018 15:51:42 -0600
From: Rob Herring <robh@kernel.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/19] dt-bindings: gpio: Add support for r8a77965
Message-ID: <20180301215142.fr3s5ycsuoq7jvbb@rob-hp-laptop>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-16-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519139541-18783-16-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 04:12:17PM +0100, Jacopo Mondi wrote:
> Add compatible string for R-Car M3-N (r8a77965) in gpio-rcar.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> ---
> v1 -> v2:
> - Drop SoC-specific compatible string from drivers/gpio/gpio-rcar.c
> - Change patch subject to reflect it only changes dt bindings
> ---
>  Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
