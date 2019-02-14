Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F3AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAC121872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfBNXV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:21:27 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:34505 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfBNXV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:21:26 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D1FA020002;
        Thu, 14 Feb 2019 23:21:22 +0000 (UTC)
Date:   Fri, 15 Feb 2019 00:21:22 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Nicolas.Ferre@microchip.com, wg@grandegger.com, mkl@pengutronix.de,
        davem@davemloft.net, Ludovic.Desroches@microchip.com,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] can: mark expected switch fall-throughs
Message-ID: <20190214232122.GS10129@piout.net>
References: <20190129180612.GA28650@embeddedor>
 <432a9399-95f4-e988-5cd2-93340f155fa1@microchip.com>
 <daae008e-35fd-7553-fcb2-7932fe53b959@embeddedor.com>
 <20190214221703.GQ10129@piout.net>
 <a8e53868-2b13-b050-7714-e3e24d18cf00@embeddedor.com>
 <20190214230756.GR10129@piout.net>
 <c597ac66-e79d-50e4-6906-923bd18834e9@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c597ac66-e79d-50e4-6906-923bd18834e9@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2019 17:14:05-0600, Gustavo A. R. Silva wrote:
> >>> Also, the gcc documentation says that -Wimplicit-fallthrough=3
> >>> recognizes /* fallthrough */ as a proper fall through comment (and I
> >>> tested with gcc 8.2).
> >>>
> >>
> >> Yeah. But that's not the relevant change in this case.  Notice that the
> >> comment was moved to the very bottom of the previous case.
> >>
> > 
> > Yes and it doesn't matter for gcc, I tested with gcc 8.2.
> > 
> 
> Yeah. But, again, you are missing the relevant part of the patch.
> 

Right, I misread the patch and though you were moving the comment after
the case statement.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
