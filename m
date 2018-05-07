Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbeEGUv6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:51:58 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33932 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753110AbeEGUvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:51:53 -0400
X-Google-Smtp-Source: AB8JxZoEfztX7xEI2RINbQ5Q3nrrvQBW2H621vjfmW0ng2idrhwBCgFGQH73McGFTM+KKIpbG/eA3Q==
Date: Mon, 7 May 2018 15:51:51 -0500
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: jic23@kernel.org, alexandre.torgue@st.com, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, benjamin.gaignard@linaro.org,
        arnaud.pouliquen@st.com
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: Add support for stm32mp1
Message-ID: <20180507205151.GA25321@rob-hp-laptop>
References: <1525266323-4922-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525266323-4922-1-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 03:05:23PM +0200, Fabrice Gasnier wrote:
> Add support for DFSDM (Digital Filter For Sigma Delta Modulators)
> to STM32MP1. This variant is close to STM32H7 DFSDM, it implements
> 6 filter instances. Registers map is also increased.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.txt         |  7 +++++--
>  drivers/iio/adc/stm32-dfsdm-core.c                  | 21 +++++++++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
