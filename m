Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbeEVTd2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:33:28 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33509 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752727AbeEVTdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:33:05 -0400
X-Google-Smtp-Source: AB8JxZp7hj9/u4K9FyW3NBH2H0BWWVycJ0gNDCZXrKG7Pk5yxAjhswOC+/xz1lYbB6tObmrwH+fm5A==
Date: Tue, 22 May 2018 14:33:03 -0500
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linus.walleij@linaro.org, afaerber@suse.de, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com
Subject: Re: [PATCH v2 1/5] dt-bindings: pinctrl: Add gpio bindings for
 Actions S900 SoC
Message-ID: <20180522193303.GA8957@rob-hp-laptop>
References: <20180520051736.4842-1-manivannan.sadhasivam@linaro.org>
 <20180520051736.4842-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180520051736.4842-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 10:47:32AM +0530, Manivannan Sadhasivam wrote:
> Add gpio bindings for Actions Semi S900 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/actions,s900-pinctrl.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
