Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeCCPIN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 10:08:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751923AbeCCPIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 10:08:11 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6FD2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 3 Mar 2018 15:08:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, lars@metafoo.de, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, benjamin.gaignard@linaro.org,
        arnaud.pouliquen@st.com
Subject: Re: [PATCH] dt-bindings: iio: adc: stm32-dfsdm: fix types, add
 missing pinctrl
Message-ID: <20180303150805.39f07a54@archlinux>
In-Reply-To: <20180302162513.umh2a2g4io3x26uz@rob-hp-laptop>
References: <1519384260-23875-1-git-send-email-fabrice.gasnier@st.com>
        <20180302162513.umh2a2g4io3x26uz@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2018 10:25:13 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, Feb 23, 2018 at 12:11:00PM +0100, Fabrice Gasnier wrote:
> > - Add missing pinctrl description. Support is made optional as dfsdm
> >   may use internal sources (e.g. via registers)
> > - Fix typo in IIO STM32 DFSDM filter "MANCH_F" description.
> > Basically, this should be "falling edge = logic 0", not "1" that applies
> > to "MANCH_R".
> > BTW, make the description complete by describing both rising/falling
> > edges as described in reference manuals.
> > 
> > Fixes: 6c82f947fc97 ("IIO: add DT bindings for stm32 DFSDM filter")
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
