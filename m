Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC633C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9338D20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9338D20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeK3HMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:12:22 -0500
Received: from muru.com ([72.249.23.125]:55634 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbeK3HMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 02:12:22 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F0CD68171;
        Thu, 29 Nov 2018 20:05:48 +0000 (UTC)
Date:   Thu, 29 Nov 2018 12:05:43 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] ARN: OMAP1: ams-delta: Post-GPIO-refresh cleanups
Message-ID: <20181129200543.GD53235@atomide.com>
References: <20181107201746.14705-1-jmkrzyszt@gmail.com>
 <CACRpkdb5=2iAaZfLfzuGm9EhHwZxXe4E7-yB28Dn3LAxnyszNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb5=2iAaZfLfzuGm9EhHwZxXe4E7-yB28Dn3LAxnyszNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [181115 10:46]:
> On Wed, Nov 7, 2018 at 9:16 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Janusz Krzysztofik (3):
> >       ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers
> >       ARM: OMAP1: ams-delta: Drop unused symbols from the board header
> >       ARM: OMAP1: ams-delta: Move AMS_DELTA_LATCH2_NGPIO to the board file
> 
> This series:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applying into omap-for-v4.21/omap1 thanks.

Tony
