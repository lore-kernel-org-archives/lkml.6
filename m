Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932624AbeEaBCQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 21:02:16 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41479 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932475AbeEaBCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 21:02:14 -0400
X-Google-Smtp-Source: ADUXVKIQkqFWQjReAyQjVCqEbTh1sPCSq2hhr1Fi6JnoGRMlzMiwEcKw6rL6I28bAyTVZhoJQdq/Aw==
Date: Wed, 30 May 2018 20:02:12 -0500
From: Rob Herring <robh@kernel.org>
To: Radu Pirea <radu.pirea@microchip.com>
Cc: broonie@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, lee.jones@linaro.org,
        richard.genoud@gmail.com, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 3/6] mfd: at91-usart: added mfd driver for usart
Message-ID: <20180531010212.GA26508@rob-hp-laptop>
References: <20180525171941.26766-1-radu.pirea@microchip.com>
 <20180525171941.26766-4-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525171941.26766-4-radu.pirea@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 08:19:38PM +0300, Radu Pirea wrote:
> This mfd driver is just a wrapper over atmel_serial driver and
> spi-at91-usart driver. Selection of one of the drivers is based on a
> property from device tree. If the property is not specified, the default
> driver is atmel_serial.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  drivers/mfd/Kconfig                  | 10 ++++
>  drivers/mfd/Makefile                 |  1 +
>  drivers/mfd/at91-usart.c             | 75 ++++++++++++++++++++++++++++

>  include/dt-bindings/mfd/at91-usart.h | 17 +++++++

This really should be part of the binding patch.

Acked-by: Rob Herring <robh@kernel.org>

>  4 files changed, 103 insertions(+)
>  create mode 100644 drivers/mfd/at91-usart.c
>  create mode 100644 include/dt-bindings/mfd/at91-usart.h
