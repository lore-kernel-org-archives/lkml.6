Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeFDHms (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:42:48 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37594 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeFDHmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:42:47 -0400
X-Google-Smtp-Source: ADUXVKKPri6cI55wMeTJK7YPpV3ABdSvVs49Q+yhphibwn0gpU4a7U3hU5V8xW0//TTmjCZ7LVbijw==
Date: Mon, 4 Jun 2018 08:42:43 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: bleung@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cros_ec: Use devm_kzalloc for private data
Message-ID: <20180604074243.GJ25455@dell>
References: <CAFqH_50VYJC7aep6P+KtN4qmFeV66GEXvxmFy8KrNp1BRv33xg@mail.gmail.com>
 <20180530165422.51178-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180530165422.51178-1-gwendal@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018, Gwendal Grignou wrote:

> Use dev_kzmalloc, remove .release entry point.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Change sinc v1:
> - Readd __remove to avoid a warning when loaded as a module.
> 
>  drivers/mfd/cros_ec_dev.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
