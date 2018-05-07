Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbeEGRUh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752721AbeEGRUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:20:34 -0400
Date: Mon, 7 May 2018 18:20:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, alexandre.torgue@st.com,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com, lars@metafoo.de,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, benjamin.gaignard@linaro.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: stm32-adc: add support for
 STM32MP1
Message-ID: <20180507182008.441e6ca8@archlinux>
In-Reply-To: <20180507162830.GA11497@rob-hp-laptop>
References: <1525247091-18143-1-git-send-email-fabrice.gasnier@st.com>
        <1525247091-18143-2-git-send-email-fabrice.gasnier@st.com>
        <20180507162830.GA11497@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2018 11:28:31 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, May 02, 2018 at 09:44:49AM +0200, Fabrice Gasnier wrote:
> > Document support for STM32MP1 ADC. It's quite similar to STM32H7 ADC.
> > Introduce "st,stm32mp1-adc" compatible to handle variants of this
> > hardware such as vregready flag, interrupts, clock rate.
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> > Changes in v2:
> > - Update dt-bindings following Rob's remark: STM32MP1 ADC has two
> >   interrupt lines
> > ---
> >  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
Thanks.  Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Jonathan
