Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-889516-1524669692-2-16884733824009880480
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524669692; b=R9n6dRiC1MNxn4ASAr9run1h1giJt2RfjxicM03P5hktj7ZZ6O
    nkwCBeU4P4i0fy8tNqIykpZElwTF3ca5u50dOaTSX/0ylUBDptskRxkuNfg1gFtK
    8Rs9ouBMkJn0tZTBj6euYXzH+nfuX1x2y/TFwRV0Zs2LWCilIReZxL/0M9DYX6ek
    juKAMJ2SCotWd4pXxNWbI3YiLI3/b3sno/5byoJpibSXHF0av/Y5yPGtD+SA0zEQ
    OL2jqG7m9e8nwpDllgEz14llaOxTwS3uSgpP+rTeuZ49QeQB937Ij8UftovnaGBj
    9k6VKgAitwfjjpovYpE4g1UM0raRkYLrhagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524669692; bh=8/irA957Q7TJmNgguxGk2Z6kJUljp1
    9zrMKmcuXz68s=; b=XQjxntoxgERc4+lvfyy5HM97pUbwnFhKeqy2Jv3JObXBTK
    TFiImM/qc+ue8J8u4CSssVZCjfNxtZqlH3o842gzdddr/B54kS5WyItisKP7js9l
    rxeBTZ7gNiCZGzo+nOPB5wKMcSDqeQi42l66KvjCanw22vl1VAak8KQS0OCjqDwN
    wU6rg2k5ocEA0uL7EGzN6pmrpGuYLt3GYhODy1B7oN/EmI2s9+LODlwW6yCo3R93
    h/sl8en7ieQL/F/OfZva8nRc8EPkVRXCgdBmveI86j2CLeHR6U/SJ3Fm+nX9tKC+
    3hbJHPoDlTQ8TvshPWrZBFbx30cxTciCoop3ufDg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OMbSvwgS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OMbSvwgS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI0Xf/d2UvYsQAeTHOn4GwRTKX4GcQfqcvelQZkD3iV4kZ/POBF+QJoDCKCUfSRPHQ7t+zFCpR3Z6ymmf/f8LiH48I3BcVNPKaf/85rxL1vEDvwN6f5g
    WUP/bjMaoRjCfTJatamqUu+nMTu2LI0L8KT7q4igDgbwksEVS70jNBZSvTIO3JJM16dSXcBp7yt99foYBq7wmtj5eKRV9pBJxgmSJ9IaRdowLVkBevmnRJ9o
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=c-n4J4-pAAAA:8 a=xUfyd3I0D5ksHvuB-YkA:9
    a=h7AUlWNVWMQwfqkR:21 a=Obx2vUfTvJWNk1Mm:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbeDYPVS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:21:18 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34284 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbeDYPVQ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 11:21:16 -0400
X-Google-Smtp-Source: AIpwx4+mT1sqTbnlNJ+u3aFHC1/IWsLOP+uPE9fCoL85GVkJXg+g/JEwzw6cbS/2dA+mQP9VuZAuYg==
Date: Wed, 25 Apr 2018 10:21:14 -0500
From: Rob Herring <robh@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-usb@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/2] usb: dwc3: support clocks and resets for DWC3 core
Message-ID: <20180425152114.pzklc5uqva3nil5v@rob-hp-laptop>
References: <1524135818-14825-1-git-send-email-yamada.masahiro@socionext.com>
 <1524135818-14825-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524135818-14825-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 08:03:38PM +0900, Masahiro Yamada wrote:
> Historically, the clocks and resets are handled on the glue layer
> side instead of the DWC3 core.  For simple cases, dwc3-of-simple.c
> takes care of arbitrary number of clocks and resets.  The DT node
> structure typically looks like as follows:
> 
>   dwc3-glue {
>           compatible = "foo,dwc3";
>           clocks = ...;
>           resets = ...;
>           ...
> 
>           dwc3 {
>                   compatible = "snps,dwc3";
>                   ...
>           };
>   }
> 
> By supporting the clocks and the reset in the dwc3/core.c, it will
> be turned into a single node:
> 
>   dwc3 {
>           compatible = "foo,dwc3", "snps,dwc3";
>           clocks = ...;
>           resets = ...;
>           ...
>   }
> 
> This commit adds the binding of clocks and resets specific to this IP.
> The number of clocks should generally be the same across SoCs, it is
> just some SoCs either tie clocks together or do not provide software
> control of some of the clocks.
> 
> I took the clock names from the Synopsys datasheet: "ref" (ref_clk),
> "bus_early" (bus_clk_early), and "suspend" (suspend_clk).
> 
> I found only one reset line in the datasheet, hence the reset-names
> property is omitted.
> 
> Supporting those clocks and resets is the requirement for new platforms.
> Enforcing the new binding breaks existing platforms since they specify
> clocks and resets in their glue layer node, but nothing in the core
> node.  I listed such exceptional cases in the DT binding.  The driver
> code is loosened up to accept no clock/reset.  This change is based
> on the discussion [1].
> 
> I inserted reset_control_deassert() and clk_bulk_enable() before the
> first register access, i.e. dwc3_cache_hwparams().
> 
> [1] https://patchwork.kernel.org/patch/10284265/
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Make clocks specific to this IP based on Synopsys datasheet
>   - Use clk_bulk API
>   - Add description to struct header
> 
>  Documentation/devicetree/bindings/usb/dwc3.txt | 21 ++++++
>  drivers/usb/dwc3/core.c                        | 89 +++++++++++++++++++++++++-
>  drivers/usb/dwc3/core.h                        |  8 +++
>  3 files changed, 116 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 0dbd308..feb1cc33 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -7,6 +7,27 @@ Required properties:
>   - compatible: must be "snps,dwc3"
>   - reg : Address and length of the register set for the device
>   - interrupts: Interrupts used by the dwc3 controller.
> + - clock-names: should contain "ref", "bus_early", "suspend"
> + - clocks: list of phandle and clock specifier pairs corresponding to
> +           entries in the clock-names property.
> + - resets: a single pair of phandle and reset specifier

This should be optional as some SoCs don't have separate, s/w controlled 
resets of modules.

Otherise, for the DT binding:

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
