Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754151AbeCWK0L (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 06:26:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40989 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753214AbeCWK0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 06:26:07 -0400
Message-ID: <1521800762.3406.2.camel@pengutronix.de>
Subject: Re: [PATCH] reset: uniphier: add ethernet reset control support for
 PXs3
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Fri, 23 Mar 2018 11:26:02 +0100
In-Reply-To: <CAK7LNARk3-_DdMcOd4=Tjr0hLO8h=FieQLqye27w8BAbZW-qJA@mail.gmail.com>
References: <1521781954-20526-1-git-send-email-hayashi.kunihiko@socionext.com>
         <CAK7LNARk3-_DdMcOd4=Tjr0hLO8h=FieQLqye27w8BAbZW-qJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-23 at 19:16 +0900, Masahiro Yamada wrote:
> 2018-03-23 14:12 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> > Add reset lines for ethernet controller on PXs3 SoC.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  drivers/reset/reset-uniphier.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
> > index e8bb023..fd3afbd 100644
> > --- a/drivers/reset/reset-uniphier.c
> > +++ b/drivers/reset/reset-uniphier.c
> > @@ -121,6 +121,8 @@ static const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
> >  static const struct uniphier_reset_data uniphier_pxs3_sys_reset_data[] = {
> >         UNIPHIER_RESETX(2, 0x200c, 0),          /* NAND */
> >         UNIPHIER_RESETX(4, 0x200c, 2),          /* eMMC */
> > +       UNIPHIER_RESETX(6, 0x200c, 9),          /* Ether0 */
> > +       UNIPHIER_RESETX(7, 0x200c, 10),         /* Ether1 */
> >         UNIPHIER_RESETX(8, 0x200c, 12),         /* STDMAC */
> >         UNIPHIER_RESETX(12, 0x200c, 4),         /* USB30 link (GIO0) */
> >         UNIPHIER_RESETX(13, 0x200c, 5),         /* USB31 link (GIO1) */
> > --
> > 2.7.4
> > 
> 
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thank you, applied to reset/next.

regards
Philipp
