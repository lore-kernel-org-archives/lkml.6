Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD194C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE2C24075
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE2C24075
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeGEI5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:57:33 -0400
Received: from muru.com ([72.249.23.125]:50288 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752458AbeGEI5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:57:32 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 68667802B;
        Thu,  5 Jul 2018 09:00:30 +0000 (UTC)
Date:   Thu, 5 Jul 2018 01:57:29 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 0/5] pinctrl fixes for generic functions and groups
Message-ID: <20180705085729.GZ112168@atomide.com>
References: <20180619093126.74060-1-tony@atomide.com>
 <CACRpkdaV84wai+ie1D-t=j+RiYNvKJUvjA8g-zvGhMZS2dBuEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdaV84wai+ie1D-t=j+RiYNvKJUvjA8g-zvGhMZS2dBuEA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [180628 13:57]:
> On Tue, Jun 19, 2018 at 11:31 AM Tony Lindgren <tony@atomide.com> wrote:
> 
> > Here are fixes to the race issues for generic group and functions
> > reported by H. Nikolaus Schaller <hns@goldelico.com>. I have not seen
> > the issue here myself, so please test to see if this is sufficient.
> 
> It looks sane to me, it'd be great to have some Tested-by: from
> H. Nikolaus, can we get that?
> 
> Else I guess I just queue them, but if I should queue them for
> fixes it'd be great if it actually can be verified to fix something :D

Looks like git did not add Reported-by to Cc or I messed up
something as Nikolaus did not see this set. I'll resend
these patches one more time so Nikolaus can test.

Regards,

Tony
