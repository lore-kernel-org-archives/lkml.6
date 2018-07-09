Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246EAC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30C42087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30C42087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbeGINLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:11:41 -0400
Received: from muru.com ([72.249.23.125]:50816 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750996AbeGINLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:11:39 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2CB338022;
        Mon,  9 Jul 2018 13:14:41 +0000 (UTC)
Date:   Mon, 9 Jul 2018 06:11:35 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        cvwillegen@gmail.com,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCHv3 0/5] pinctrl fixes for generic functions and groups
Message-ID: <20180709131135.GD99251@atomide.com>
References: <20180705091018.60524-1-tony@atomide.com>
 <CACRpkdYKTKe7c79XDtGf79sOjzDuqEWSJN1KrG2POuemP+TL+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYKTKe7c79XDtGf79sOjzDuqEWSJN1KrG2POuemP+TL+g@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [180709 13:02]:
> On Thu, Jul 5, 2018 at 11:10 AM Tony Lindgren <tony@atomide.com> wrote:
> 
> > Here is a resend of fixes for a race issues for generic group and
> > functions reported by H. Nikolaus Schaller <hns@goldelico.com>.
> 
> I applied these 5 for fixes (no choice I guess) will push them to the
> zeroday build for testing and then to next. Added the tags from H.
> Nikolaus and Andy on this.

OK thanks.

> Should this stuff even be tagged for stable? Else I target it
> for v4.18.

Probably should. The fixes tags should do the trick already
hopefully though.

Regards,

Tony
