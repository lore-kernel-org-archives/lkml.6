Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934189AbeCGQxC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:53:02 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:55780 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934235AbeCGQwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:52:37 -0500
X-Google-Smtp-Source: AG47ELvxOV6JMM0+CEKVZW5U7QDEH5/sBiRrKWYqnpFDg4SC2iwAwihIBNVanEbAX2NTlBnabLQ2JQ==
Date: Wed, 7 Mar 2018 16:52:33 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/3] mfd: rave-sp: Check received frame length before
 accepting next byte
Message-ID: <20180307165233.fz356kmooqre43nh@dell>
References: <20180226150739.13457-1-andrew.smirnov@gmail.com>
 <20180226150739.13457-3-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226150739.13457-3-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018, Andrey Smirnov wrote:

> Check received frame length _before_ accepting next byte in order to
> avoid incorrectly rejecting payloads that are RAVE_SP_RX_BUFFER_SIZE
> long.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: cphealy@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/mfd/rave-sp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
