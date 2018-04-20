Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754463AbeDTIFw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:05:52 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:41922 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754447AbeDTIFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:05:49 -0400
X-Google-Smtp-Source: AIpwx49gmF2YVbU/nClOlzrbCPp48UF5qGIKK2UQJRgl+8LjvG9Vfb1i9ZlEALiiQSSOROGBDOKfnQ==
Date: Fri, 20 Apr 2018 09:05:46 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] i2c: i2c-xiic: move header to platform_data
Message-ID: <20180420080546.7cywc752teflrag5@dell>
References: <20180419200015.15095-1-wsa@the-dreams.de>
 <20180419200015.15095-7-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419200015.15095-7-wsa@the-dreams.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018, Wolfram Sang wrote:

> This header only contains platform_data. Move it to the proper directory.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/i2c/busses/i2c-xiic.c                | 2 +-
>  drivers/mfd/timberdale.c                     | 2 +-
>  include/linux/{ => platform_data}/i2c-xiic.h | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename include/linux/{ => platform_data}/i2c-xiic.h (100%)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
