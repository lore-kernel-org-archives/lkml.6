Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753801AbeBSUel (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:34:41 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40990 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753583AbeBSUek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:34:40 -0500
X-Google-Smtp-Source: AH8x227JoO6lwjm9kV+XcIBZ337kFWsTr3S+FLotQG8QNlEcivVXJ0oRFWL6/LEQf1woOYyJ/YgeUg==
Date: Mon, 19 Feb 2018 14:34:38 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linus.walleij@linaro.org, afaerber@suse.de, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] dt-bindings: pinctrl: Add bindings for Actions
 S900 SoC
Message-ID: <20180219203438.4b6h5m3nzf3ity3u@rob-hp-laptop>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217204433.3095-2-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 02:14:24AM +0530, Manivannan Sadhasivam wrote:
> Add pinctrl bindings for Actions Semi S900 SoC
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/pinctrl/actions,s900-pinctrl.txt      | 171 +++++++++++++++++++++
>  1 file changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt

Reviewed-by: Rob Herring <robh@kernel.org>
