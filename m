Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754712AbeDPM6j (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:58:39 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35104 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbeDPM6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:58:37 -0400
X-Google-Smtp-Source: AIpwx48WDkCe926iXm+sXKIYMDZwbNPPD51VhTXFQ/5KvdNjrFVdmVp/L4ybwDJpPP9ZOQrxULAiWQ==
Date: Mon, 16 Apr 2018 13:58:33 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv6 1/2] dt-bindings: mfd: motorola-cpcap: document
 audio-codec
Message-ID: <20180416125833.pjz3qhe2naeebply@dell>
References: <20180330125824.21418-1-sebastian.reichel@collabora.co.uk>
 <20180330125824.21418-2-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180330125824.21418-2-sebastian.reichel@collabora.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018, Sebastian Reichel wrote:

> This adds the DT binding for the audio-codec sub-module found
> inside the Motorola CPCAP PMIC.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  .../devicetree/bindings/mfd/motorola-cpcap.txt     | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
