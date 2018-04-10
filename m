Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754474AbeDJNx7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:53:59 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46306 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753206AbeDJNx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:53:56 -0400
X-Google-Smtp-Source: AIpwx48jrZzSB3Q8n7uUlarKQYgpaaP7yix3U/hwzBc98xGvUVgjfZfDvH26BBGEWec0mv6RNTxdBg==
Date: Tue, 10 Apr 2018 08:53:53 -0500
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linus.walleij@linaro.org, afaerber@suse.de, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com
Subject: Re: [PATCH v7 4/9] dt-bindings: gpio: Add gpio nodes for Actions
 S900 SoC
Message-ID: <20180410135353.yyyv54ik6nkimb6j@rob-hp-laptop>
References: <20180404172258.7678-1-manivannan.sadhasivam@linaro.org>
 <20180404172258.7678-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404172258.7678-5-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 10:52:53PM +0530, Manivannan Sadhasivam wrote:
> Add gpio nodes for Actions Semi S900 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/gpio/actions,owl-gpio.txt  | 87 ++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt

Reviewed-by: Rob Herring <robh@kernel.org>
