Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeFDI7F (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:59:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34002 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeFDI7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:59:04 -0400
X-Google-Smtp-Source: ADUXVKJq6wJo/vUmwBwgIDKQUYjdaNJJyRdZSQdL6inMp8BD+/dmTLd+6ZdiysRD3yZdtimuxyAC6w==
Date: Mon, 4 Jun 2018 09:59:00 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabien Parent <fparent@baylibre.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com, gpain@baylibre.com
Subject: Re: [PATCH 1/3] mfd: cros: add charger port count command definition
Message-ID: <20180604085900.GN25455@dell>
References: <20180530031704.18597-1-fparent@baylibre.com>
 <20180530031704.18597-2-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180530031704.18597-2-fparent@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018, Fabien Parent wrote:

> A new more command has been added to the ChromeOS embedded controller
> that allows to get the number of charger port count. Unlike
> EC_CMD_USB_PD_PORTS, this new command also includes the dedicated
> port if present.
> 
> This command will be used to expose the dedicated charger port
> in the ChromeOS charger driver.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  include/linux/mfd/cros_ec_commands.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Does not want to apply.  I didn't investigate why.

Please rebase and resend?
-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
