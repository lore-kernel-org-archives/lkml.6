Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934237AbeCGQwh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:52:37 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53760 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934156AbeCGQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:52:04 -0500
X-Google-Smtp-Source: AG47ELv0X4/aq/pXAqBa4LUaho+0IXJ40vO5ffGhKtAs2n760jTPk5qRlyxncKHTysB2VoSQkOMqcw==
Date: Wed, 7 Mar 2018 16:52:01 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/3] mfd: rave-sp: Convert print_hex_dump() to
 print_hex_dump_debug()
Message-ID: <20180307165201.xfirbmhrjeqvywef@dell>
References: <20180226150739.13457-1-andrew.smirnov@gmail.com>
 <20180226150739.13457-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226150739.13457-2-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018, Andrey Smirnov wrote:

> Convert print_hex_dump() to print_hex_dump_debug() to be able to
> leverage CONFIG_DYNAMIC_DEBUG.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: cphealy@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/mfd/rave-sp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
