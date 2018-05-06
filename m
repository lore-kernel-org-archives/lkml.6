Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeEFRyM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 13:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751751AbeEFRyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 13:54:10 -0400
Date: Sun, 6 May 2018 18:54:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH v2 0/3] Add support for STM32MP1 ADC
Message-ID: <20180506185404.1e2b1d7a@archlinux>
In-Reply-To: <1525247091-18143-1-git-send-email-fabrice.gasnier@st.com>
References: <1525247091-18143-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2018 09:44:48 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add support for STM32MP1 Analog to Digital Converter variant.
> It's quite similar to STM32H7 ADC and re-use most of existing driver.
This series looks good to me. I just want to give Rob in particular
time to have another look if he likes.

Give me a poke if I seem to have forgotten it in a week or so.

Thanks,

Jonathan

> 
> ---
> Changes in v2:
> - Update dt-bindings following Rob's remark: STM32MP1 ADC has two
>   interrupt lines
> 
> Fabrice Gasnier (3):
>   dt-bindings: iio: stm32-adc: add support for STM32MP1
>   iio: adc: stm32-adc: add support for STM32MP1
>   ARM: dts: stm32: Add ADC support to stm32mp157c
> 
>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  6 +-
>  arch/arm/boot/dts/stm32mp157c.dtsi                 | 32 +++++++++++
>  drivers/iio/adc/stm32-adc-core.c                   | 66 ++++++++++++++++------
>  drivers/iio/adc/stm32-adc.c                        | 47 +++++++++++++--
>  4 files changed, 128 insertions(+), 23 deletions(-)
> 
