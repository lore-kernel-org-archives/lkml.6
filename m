Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753918AbeEAIch (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:32:37 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37014 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbeEAIcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:32:33 -0400
X-Google-Smtp-Source: AB8JxZoPrsk+mMwzwmbSyXwl33PJwHv10lbiKlVWUi55vq9C0wrhTLJmpbg1rBi4eqnqD+V9SYaOKA==
Date: Tue, 1 May 2018 09:32:29 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 3/3] mfd: cros_ec_dev: Register cros_usbpd-charger
 driver as a subdevice.
Message-ID: <20180501083229.GL5147@dell>
References: <20180430131403.14296-1-enric.balletbo@collabora.com>
 <20180430131403.14296-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180430131403.14296-4-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2018, Enric Balletbo i Serra wrote:

> Check whether this EC instance has USBPD host command support and
> instatiate the cros_usbpd-charger driver as a subdevice in such case.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2:
> - [3/3] Use ARRAY_SIZE instead of hardcoded 1.
> 
>  drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Patch looks good to me.

Does it depend on any of the other patches in the series?

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
