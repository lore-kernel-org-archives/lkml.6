Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8096BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52681218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbeLTMdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:33:54 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60634 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731119AbeLTMdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:33:54 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DB836207AD; Thu, 20 Dec 2018 13:33:51 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id A6ADE2072C;
        Thu, 20 Dec 2018 13:33:41 +0100 (CET)
Date:   Thu, 20 Dec 2018 13:33:41 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: display: ssd1307fb: Remove
 reset-active-low from examples
Message-ID: <20181220123341.GE2188@piout.net>
References: <1545308005-51559-1-git-send-email-michal.vokac@ysoft.com>
 <1545308005-51559-2-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1545308005-51559-2-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2018 12:13:54+0000, Vokáč Michal wrote:
> The reset-active-low property has been removed brom the binding a while
> ago. So remove it from the examples as well.
> 
> Fixes: 519b4db ("fbdev: ssd1307fb: Remove reset-active-low from the DT binding document")
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> Changes from v1:
>  - Add R-by from Rob
> 
>  Documentation/devicetree/bindings/display/ssd1307fb.txt | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
> index 209d931..b67f8ca 100644
> --- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
> +++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
> @@ -36,7 +36,6 @@ ssd1307: oled@3c {
>          reg = <0x3c>;
>          pwms = <&pwm 4 3000>;
>          reset-gpios = <&gpio2 7>;
> -        reset-active-low;
>  };
>  
>  ssd1306: oled@3c {
> @@ -44,7 +43,6 @@ ssd1306: oled@3c {
>          reg = <0x3c>;
>          pwms = <&pwm 4 3000>;
>          reset-gpios = <&gpio2 7>;
> -        reset-active-low;
>          solomon,com-lrremap;
>          solomon,com-invdir;
>          solomon,com-offset = <32>;
> -- 
> 2.1.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
