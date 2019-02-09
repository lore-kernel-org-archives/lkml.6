Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B562FC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7806220844
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfBITmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 14:42:15 -0500
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:35049 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727175AbfBITmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 14:42:15 -0500
Received: from xps13 ([83.160.161.190])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id sYVsg7zFoBDyIsYVvgPNmp; Sat, 09 Feb 2019 20:42:12 +0100
Message-ID: <3578229a062d10331dd0b8cfabe4b59a10e4ad2a.camel@tiscali.nl>
Subject: Re: Linux 5.0-rc1
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>,
        Karsten Keil <isdn@linux-pingi.de>
Date:   Sat, 09 Feb 2019 20:42:08 +0100
In-Reply-To: <CAHk-=wgKYnrL3LjhVkH2Fp+ecmWhLqezT9zmR6CzfcpwcJX0qA@mail.gmail.com>
References: <CAHk-=wgKYnrL3LjhVkH2Fp+ecmWhLqezT9zmR6CzfcpwcJX0qA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCw9o/sJGt+im4F9ywSPu51SjGNt5zuXRx4BytcReKrUWN0dnbe1CelmrSLdZ7Mq6KJMGXzUBRa2DDyDveyur9EsURQEfxCXA9ZrGlAo2qzJoz0tX32S
 QIgteb1R0OYOdB7mEYUege0BsTdEB8gEHAf4w7Tc0xmC+Pu9btTnqJtqil+TUHtqYh02eV6btICBzvLYevw/bmONcMtYD66CC+JdSSqoU+QhwwjSkB3sd6Sf
 vcnhhTYOyAIYdMQCmH+AaYN7I5tdj8lLi0cRyd980go=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds schreef op zo 06-01-2019 om 18:14 [-0800]:
> Nothing particular stands out, although I do like
> seeing how some ancient drivers are getting put out to pasture
> (*cought*isdn*cough*).

Just to let people know: the gigaset drivers will get my palliative care until
a few weeks before September 1, 2019. Because at that date the Dutch consumer
grade ISDN network (the "BRI" part of ISDN) will be shut down. So expect a
patch to remove me from MAINTAINERS sometime during the v5.2 cycle.

That leaves just Karsten Keil to look after all the ISDN drivers. Karsten's
last activity was in 2016. See commit 1e1589ad8b5c ("mISDN: Support DR6
indication in mISDNipac driver"). Which is also the last commit apparently
resolving an issue noticed by an actual _user_ of one of the ISDN drivers.

Perhaps Karsten could tell us whether there's any point in keeping the ISDN
subsystem in the tree after September 1, 2019, and if so, in what form. I'm in
no position to properly answer that question.


Paul Bolle

