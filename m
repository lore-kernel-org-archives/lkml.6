Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0349C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6780420862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6780420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbeKFV0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:26:32 -0500
Received: from gloria.sntech.de ([185.11.138.130]:37890 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729728AbeKFV0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:26:32 -0500
Received: from wd0416.dip.tu-dresden.de ([141.76.109.160] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gK034-0000MJ-Ig; Tue, 06 Nov 2018 13:01:34 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Frank Lee <tiny.windzz@gmail.com>, peda@axentia.se
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: rk3x: fix some typo
Date:   Tue, 06 Nov 2018 13:01:33 +0100
Message-ID: <12637568.SqdzpTGmKQ@phil>
In-Reply-To: <CAEExFWtQrPD8hUn15Add-EuueCL5=Crb+yvDckWejG75BExGug@mail.gmail.com>
References: <20181102124535.24331-1-tiny.windzz@gmail.com> <19a28033-9241-1f4e-97cd-7c6648a73c6d@axentia.se> <CAEExFWtQrPD8hUn15Add-EuueCL5=Crb+yvDckWejG75BExGug@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao, Peter,

Am Montag, 5. November 2018, 16:59:58 CET schrieb Frank Lee:
> I am sorry.
> -- Yangtao

If anything, it is me that should be sorry, as I did suggest the
patch description, including the new spelling error.

And it took me like the whole weekend to actually realize where the
Calculated / Calculates error was hiding ;-) .


Heiko

> On Fri, Nov 2, 2018 at 8:58 PM Peter Rosin <peda@axentia.se> wrote:
> >
> > On 2018-11-02 13:45, Yangtao Li wrote:
> > > Fix multiple instances of a misspelled "Calculates".
> >
> > Yes, it sure is hard to spell "Calcluated," it's almost impossible to
> > get it completely right and not introduce another typo somewhere... :-)
> >
> > Cheers,
> > Peter
> >
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > > Changes in v2:
> > > -add commit message
> > > ---
> > >  drivers/i2c/busses/i2c-rk3x.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> > > index b8a2728dd4b6..fe347e8e2a23 100644
> > > --- a/drivers/i2c/busses/i2c-rk3x.c
> > > +++ b/drivers/i2c/busses/i2c-rk3x.c
> > > @@ -555,7 +555,7 @@ static const struct i2c_spec_values *rk3x_i2c_get_spec(unsigned int speed)
> > >   *
> > >   * @clk_rate: I2C input clock rate
> > >   * @t: Known I2C timing information
> > > - * @t_calc: Caculated rk3x private timings that would be written into regs
> > > + * @t_calc: Calculated rk3x private timings that would be written into regs
> > >   *
> > >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
> > >   * a best-effort divider value is returned in divs. If the target rate is
> > > @@ -716,7 +716,7 @@ static int rk3x_i2c_v0_calc_timings(unsigned long clk_rate,
> > >   *
> > >   * @clk_rate: I2C input clock rate
> > >   * @t: Known I2C timing information
> > > - * @t_calc: Caculated rk3x private timings that would be written into regs
> > > + * @t_calc: Calculated rk3x private timings that would be written into regs
> > >   *
> > >   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
> > >   * a best-effort divider value is returned in divs. If the target rate is
> > >
> >
> 




