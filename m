Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966949AbeBNJjA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:39:00 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37839 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966706AbeBNJi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:38:58 -0500
X-Google-Smtp-Source: AH8x224j2Y5uc5exLCKKqFl83eD6M7heLYkV1HXYmjbCFIurK+E3h+sfeoJB5C5ASHvlpGfHhMdktg==
Date: Wed, 14 Feb 2018 09:38:53 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com,
        benjamin.gaignard@linaro.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mcoquelin.stm32@gmail.com,
        benjamin.gaignard@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Add support for PWM input capture on STM32
Message-ID: <20180214093853.4sskffpd5iasswen@dell>
References: <1516979499-3665-1-git-send-email-fabrice.gasnier@st.com>
 <5ade7f05-f5cc-e272-842c-22effa78b716@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ade7f05-f5cc-e272-842c-22effa78b716@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018, Fabrice Gasnier wrote:

> On 01/26/2018 04:11 PM, Fabrice Gasnier wrote:
> > This series adds support for capture to stm32-pwm driver.
> > Capture is based on DMAs.
> > - First two patches are precursor patches
> > - Subsequent two patches add support for requesting DMAs to MFD core
> > - Next three patches add support for capture to stm32-pwm driver
> > - This has been tested on stm32429i-eval board.
> > 
> > ---
> > Changes in v2:
> > - Abstract DMA handling from child driver: move it to MFD core
> > - Rework pwm capture routines to adopt this change
> > - Comment on optional dma support, beautify DMAs probe
> 
> Hi all,
> 
> Gentle ping for v2 driver review since DT Bindings has been reviewed by
> Rob and the series by Benjamin.

Best thing to do is collect the Acks you have and send the set out as
a [RESEND].

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
