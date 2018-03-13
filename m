Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbeCMU6A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:58:00 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34875 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbeCMU56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:57:58 -0400
X-Google-Smtp-Source: AG47ELtsuBM4OIHBGBsBAT11ezlKuv1qt2+kd/Ww0rIJTobqu7YtdX0uTe0e00Lx3bwS1zjanOiZJCDiM7EPBENbXQs=
MIME-Version: 1.0
In-Reply-To: <20180313183807.6701-4-thierry.escande@linaro.org>
References: <20180313183807.6701-1-thierry.escande@linaro.org> <20180313183807.6701-4-thierry.escande@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 22:57:57 +0200
Message-ID: <CAHp75Vc0oka68fZv6tm6zrtZEH+5hRmD+PmmG5bc0EgPQHGuTQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Bluetooth: hci_qca: Add serdev support
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 8:38 PM, Thierry Escande
<thierry.escande@linaro.org> wrote:
> Add support for Qualcomm serial slave devices. Probe the serial device,
> retrieve its maximum speed and register a new hci uart device.

>  config BT_HCIUART_QCA
>         bool "Qualcomm Atheros protocol support"
> -       depends on BT_HCIUART
> +       depends on BT_HCIUART_SERDEV

Consider to address Loic's comments.

> +#include <linux/of.h>

This is still here. Why?

-- 
With Best Regards,
Andy Shevchenko
