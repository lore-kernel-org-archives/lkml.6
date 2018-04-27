Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757869AbeD0KEJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:04:09 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54739 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757828AbeD0KEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:04:08 -0400
Message-ID: <1524823442.17614.2.camel@pengutronix.de>
Subject: Re: [PATCH] reset: uniphier: fix USB clock line for LD20
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Fri, 27 Apr 2018 12:04:02 +0200
In-Reply-To: <CAK7LNAQKVD3aKTo_z=zkOdoL--RogoFm0bt-dCBsWFN8BEPpSg@mail.gmail.com>
References: <1523499370-17757-1-git-send-email-yamada.masahiro@socionext.com>
         <CAK7LNAQKVD3aKTo_z=zkOdoL--RogoFm0bt-dCBsWFN8BEPpSg@mail.gmail.com>
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

On Fri, 2018-04-27 at 18:42 +0900, Masahiro Yamada wrote:
> Philipp,
> 
> 2018-04-12 11:16 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> > For LD20, the bit 5 of the offset 0x200c turned out to be a USB3
> > reset.  The hardware document says it is the GIO reset despite LD20
> > has no GIO bus, confusingly.
> > 
> > Also, fix confusing comments for PXs3.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> 
> Can you take a look at this, please?

Thank you for the reminder, I've applied it to reset/fixes and rebased
reset/next on top to include it.

regards
Philipp
