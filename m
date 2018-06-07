Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IeTJF7BdGVvBLAAAmS7hNA
	; Thu, 07 Jun 2018 16:32:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 811FA607E7; Thu,  7 Jun 2018 16:32:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A964260590;
	Thu,  7 Jun 2018 16:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A964260590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753909AbeFGQcR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:32:17 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:34410 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753703AbeFGQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:32:15 -0400
Received: from ravnborg.org (unknown [158.248.196.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id D0D7B80397;
        Thu,  7 Jun 2018 18:32:09 +0200 (CEST)
Date: Thu, 7 Jun 2018 18:32:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dirk Gouders <dirk@gouders.net>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC 0/1] mconf: Emacs-like isearch
Message-ID: <20180607163208.GA26914@ravnborg.org>
References: <20180606215616.12817-1-dirk@gouders.net>
 <a594b5a7-d5c8-e938-df4e-dbba93ff3837@infradead.org>
 <ghzi07v944.fsf@lena.gouders.net>
 <f833ff8b-75ed-3ca4-ec24-a129a05902d1@infradead.org>
 <ghr2ljv5c9.fsf@lena.gouders.net>
 <CAK7LNARWC3J4V=Nx9rypwaWK8Lsv9A6J3LDW7s6E1xjc0JDE4A@mail.gmail.com>
 <ghmuw7uoku.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ghmuw7uoku.fsf@lena.gouders.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=UBp3I0v3E8sCzZyGyBAA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I'd say it's not important to start isearch with CTRL-s, I am just so
> used to it.  So, I am open for suggestions.

Today we have first or one of the first letters as shortcut to menus.
How about considering everything typed as search inputs.
Search is then stopped by ESC, arrow keys and maybe more.

Search is only possible when a menu is selected, not with focus on the buttons.

This will break the habits of people used to the shortcut variant,
but then we have the more flexible i-search variant.

Idea?

	Sam
