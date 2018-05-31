Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932660AbeEaBAX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 21:00:23 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33116 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932475AbeEaBAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 21:00:20 -0400
X-Google-Smtp-Source: ADUXVKIhCiBEJkHzrBr1x+YFH6peqoYKbXt/HBaKJm1mPNLcBeV5H8iGmgcCio1o1gwuMC2VyY4j7A==
Date: Wed, 30 May 2018 20:00:18 -0500
From: Rob Herring <robh@kernel.org>
To: Radu Pirea <radu.pirea@microchip.com>
Cc: broonie@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, lee.jones@linaro.org,
        richard.genoud@gmail.com, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 2/6] dt-bindings: add binding for atmel-usart in SPI
 mode
Message-ID: <20180531010018.GA24002@rob-hp-laptop>
References: <20180525171941.26766-1-radu.pirea@microchip.com>
 <20180525171941.26766-3-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525171941.26766-3-radu.pirea@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 08:19:37PM +0300, Radu Pirea wrote:
> This patch moves the bindings for serial from serial/atmel-usart.txt to
> mfd/atmel-usart.txt and adds bindings for USART in SPI mode.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  .../bindings/{serial => mfd}/atmel-usart.txt  | 25 +++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)

Reviewed-by: Rob Herring <robh@kernel.org>
