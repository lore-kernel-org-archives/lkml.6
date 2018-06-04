Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeFDGTC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:19:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55257 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeFDGTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:19:00 -0400
X-Google-Smtp-Source: ADUXVKJY6YricUsEcFUm/P8SpHjeP5AwsNnd2/4/JufQxgHOpeEjijtEHN/KGtzK8Yu6KvPqbr/aDw==
Date: Mon, 4 Jun 2018 07:18:56 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc: dmitry.torokhov@gmail.com, ravisadineni@google.com, dtor@google.com,
        briannorris@chromium.org, tbroch@google.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        rajatja@google.com, bleung@google.com
Subject: Re: [PATCH V2] cros_ec_keyb: Mark cros_ec_keyb driver as wake
 enabled device.
Message-ID: <20180604061856.GF25455@dell>
References: <20180524234213.GE177107@dtor-ws>
 <20180526011440.102417-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180526011440.102417-1-ravisadineni@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018, Ravi Chandra Sadineni wrote:

> Mark cros_ec_keyb has wake enabled by default. If we see a MKBP event
> related to keyboard,  call pm_wakeup_event() to make sure wakeup
> triggers are accounted to keyb during suspend resume path.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
> V2: Marked the ckdev as wake enabled instead of input devices.
> 
>  drivers/input/keyboard/cros_ec_keyb.c | 21 +++++++++++++++++----

>  drivers/mfd/cros_ec.c                 | 19 +++++++------------

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
