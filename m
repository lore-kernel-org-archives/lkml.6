Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757815AbeD0JXK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:23:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36367 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757241AbeD0JXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:23:08 -0400
Message-ID: <1524820982.17614.0.camel@pengutronix.de>
Subject: Re: [PATCH] reset: uniphier: add LD11/LD20 stream demux system
 reset control
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Fri, 27 Apr 2018 11:23:02 +0200
In-Reply-To: <CAK7LNATuxGb9Yp6sQBySR75fAcVV5fcZn7GBQ1dAXsW3Xd8hAA@mail.gmail.com>
References: <20180427004121.4143-1-suzuki.katsuhiro@socionext.com>
         <CAK7LNATuxGb9Yp6sQBySR75fAcVV5fcZn7GBQ1dAXsW3Xd8hAA@mail.gmail.com>
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

On Fri, 2018-04-27 at 12:13 +0900, Masahiro Yamada wrote:
> 2018-04-27 9:41 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> > Add reset lines for MPEG2 transport stream I/O and demux system (HSC)
> > on UniPhier LD11/LD20 SoCs.
> > 
> > Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thank you, applied to reset/next.

regards
Philipp
