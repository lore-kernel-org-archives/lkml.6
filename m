Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935850AbeCHLkM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:40:12 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46073 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935072AbeCHLkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:40:10 -0500
Message-ID: <1520509204.2514.7.camel@pengutronix.de>
Subject: Re: [PATCH] reset: uniphier: add Pro4/Pro5/PXs2 audio systems reset
 control
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 08 Mar 2018 12:40:04 +0100
In-Reply-To: <CAK7LNAQkq6t7zhaNRGUM7nU4NGBAT3FEQTg0xKXHPZOmBcc-OA@mail.gmail.com>
References: <20180308080929.30982-1-suzuki.katsuhiro@socionext.com>
         <CAK7LNAQkq6t7zhaNRGUM7nU4NGBAT3FEQTg0xKXHPZOmBcc-OA@mail.gmail.com>
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

On Thu, 2018-03-08 at 17:12 +0900, Masahiro Yamada wrote:
> 2018-03-08 17:09 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> > Add reset lines for audio subsystem (AIO) on UniPhier
> > Pro4/Pro5/PXs2 SoCs.
> > 
> > Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> > ---
> 
> 
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thank you, applied to reset/next.

regards
Philipp
