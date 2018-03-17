Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeCQWeb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 18:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751809AbeCQWe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 18:34:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DB621741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Mar 2018 22:34:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH 0/2] iio: stm32-dfsdm-adc: fix filter & rate setting
Message-ID: <20180317223422.1a08a254@archlinux>
In-Reply-To: <1ddfcfad-f06e-738f-53cf-11dc56e61da1@st.com>
References: <1520950986-23116-1-git-send-email-fabrice.gasnier@st.com>
        <1ddfcfad-f06e-738f-53cf-11dc56e61da1@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018 10:10:09 +0100
Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:

> Hello,
> 
> For the series:
> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Both applied and marked for stable (as I'm not sure exactly when this will hit
mainline and it may be after the next merge window)

Thanks,

Jonathan

> 
> Thanks,
> Arnaud
> 
> On 03/13/2018 03:23 PM, Fabrice Gasnier wrote:
> > This series brings fixes to STM32 DFSDM ADC driver.
> > 
> > Fabrice Gasnier (2):
> >   iio: adc: stm32-dfsdm: fix successive oversampling settings
> >   iio: adc: stm32-dfsdm: fix sample rate for div2 spi clock
> > 
> >  drivers/iio/adc/stm32-dfsdm-adc.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >   
