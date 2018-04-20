Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754471AbeDTIGQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:06:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39394 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754423AbeDTIFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:05:37 -0400
X-Google-Smtp-Source: AIpwx4+Qmz4esnDJtXvV7H49Kc5s6MTL8w8IfUK4TnrlZhzwTE+IjYUbkZ/c8fK7O8zjWQDDjmDjtg==
Date: Fri, 20 Apr 2018 09:05:33 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] i2c: i2c-ocores: move header to platform_data
Message-ID: <20180420080533.ohryzn7wkg4525os@dell>
References: <20180419200015.15095-1-wsa@the-dreams.de>
 <20180419200015.15095-4-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419200015.15095-4-wsa@the-dreams.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018, Wolfram Sang wrote:

> This header only contains platform_data. Move it to the proper directory.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  Documentation/i2c/busses/i2c-ocores            | 2 +-
>  drivers/i2c/busses/i2c-ocores.c                | 2 +-
>  drivers/mfd/timberdale.c                       | 2 +-
>  include/linux/{ => platform_data}/i2c-ocores.h | 0
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename include/linux/{ => platform_data}/i2c-ocores.h (100%)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
