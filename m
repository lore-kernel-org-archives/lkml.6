Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753938AbeC1P1s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:27:48 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:40657 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753892AbeC1P1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:27:44 -0400
X-Google-Smtp-Source: AIpwx49mfbI6uDt0U9fWYBYW8EX5MBG2Q8SId/dEaqbyN5+7Y9AeXRakkIkANju9P4U0dj8002W1wg==
Date: Wed, 28 Mar 2018 16:27:41 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, cphealy@gmail.com,
        andrew.smirnov@gmail.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: MC13783: add uid and die temperature sensor
 inputs
Message-ID: <20180328152741.st7rjnzlryzazjfh@dell>
References: <1522160389-18822-1-git-send-email-andrey.gusakov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522160389-18822-1-git-send-email-andrey.gusakov@cogentembedded.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018, Andrey Gusakov wrote:

> The uid and die temperature can be read out on the ADIN7 using
> input mux. Map uid and die temperature sensor to channels 16
> and 17.
> 
> Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> ---
> Changes in v3:
> - comment style fixes
> Changes in v2:
> - suport both mc13783 and mc13892
> - uid_input renamed to in16_input
> - style fixes
> ---
>  drivers/hwmon/mc13783-adc.c | 60 +++++++++++++++++++++++++++++++++++++++++++++

>  drivers/mfd/mc13xxx-core.c  | 15 +++++++++++-
>  include/linux/mfd/mc13xxx.h |  2 ++

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
