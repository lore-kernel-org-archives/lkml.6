Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeCNSau (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:30:50 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35121 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbeCNSaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:30:46 -0400
X-Google-Smtp-Source: AG47ELsFpSdLMkisUoOCzVchp8i+WURVvvFjCCDmiy+AxbXrV5LqGGyzqRTx2pPg3HYBytvqTj5Dcw==
Date: Wed, 14 Mar 2018 11:30:43 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Thierry Escande <thierry.escande@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Bluetooth mailing list
        <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
Message-ID: <20180314183043.GX18510@minitux>
References: <20180314155514.3374-1-thierry.escande@linaro.org>
 <20180314155514.3374-3-thierry.escande@linaro.org>
 <FF2E3FDE-76C5-477A-A904-32AC064297DA@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FF2E3FDE-76C5-477A-A904-32AC064297DA@holtmann.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Mar 09:13 PDT 2018, Marcel Holtmann wrote:
> > +		bt-disable-n-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
> 
> can we use a common name here. I think that Nokia and Broadcom drivers
> define one. And if this is the enable/shutdown GPIO, we should name it
> consistently across all manufacturers. It essentially does the same on
> Bluetooth UART chips no matter what chip is behind them.
> 

Broadcomm has a device-wakup-gpios and Nokia has bluetooth-wakup-gpios.
It might be that these behave in the same way, but from the description
they only trigger the wakeup.

The reason for the proposed naming here is that the pin is named
"BT_DISABLE_N" in the datasheet.

Regards,
Bjorn
