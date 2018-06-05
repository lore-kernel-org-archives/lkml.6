Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeFEHFz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:05:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41273 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbeFEHFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:05:45 -0400
X-Google-Smtp-Source: ADUXVKLBW9PXW9iH5s0O+TUetXMsjxJFsMhvWKjxemEl6i7ppi5AUhz4PtSK4vcsWe+thuK6bTLNAQ==
Date: Tue, 5 Jun 2018 08:05:42 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 03/10] mfd: da9063: Rename PMIC_DA9063 to
 PMIC_CHIP_ID_DA9063
Message-ID: <20180605070542.GG21163@dell>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-3-marek.vasut+renesas@gmail.com>
 <20180604122658.GC21163@dell>
 <3853ee6e-86a7-793e-c633-fc9c2910976f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3853ee6e-86a7-793e-c633-fc9c2910976f@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Jun 2018, Marek Vasut wrote:

> On 06/04/2018 02:26 PM, Lee Jones wrote:
> > On Sat, 02 Jun 2018, Marek Vasut wrote:
> > 
> >> The PMIC_DA9063 is a complete misnomer, it denotes the value of the
> >> DA9063 chip ID register, so rename it as such. It is also the value
> >> of chip ID register of DA9063L though, so drop the enum as all the
> >> DA9063 "models" share the same chip ID and thus the distinction will
> >> have to be made using DT or otherwise.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> Cc: Mark Brown <broonie@kernel.org>
> >> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> >> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >> Cc: linux-renesas-soc@vger.kernel.org
> >> Acked-by: Mark Brown <broonie@kernel.org>
> >> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >> V2: No change
> >> V3: No change
> >> ---
> >>  drivers/mfd/da9063-core.c            | 2 +-
> >>  drivers/mfd/da9063-i2c.c             | 2 +-
> >>  drivers/regulator/da9063-regulator.c | 2 +-
> >>  include/linux/mfd/da9063/core.h      | 4 +---
> >>  4 files changed, 4 insertions(+), 6 deletions(-)
> > 
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Thanks.
> 
> Any other comments before I submit the next round in a few days?

Yes, please hold off until I can complete the set.

Should be done by EOD today.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
