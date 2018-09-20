Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7086EECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551A021525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="YMlhMCDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551A021525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbeITPJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:09:41 -0400
Received: from cock.li ([185.100.85.212]:38914 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731552AbeITPJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:09:40 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1537435625; bh=0iSxDrCVx/Anvu41qmDOExT446OglWmLxhDeREUwqvs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YMlhMCDWpHsp8/me8HOmVmXuYcURZQshBxRdTENgzZNj2BTI1pEPQxkaz6zyVghck
         gwBRNg5/DDZqZzpwP3oGhnsYlsR86wsehO9jd/fu3CYPpxSsUBmrtyx0xSDv3O0PbW
         Eun3tnh074T26OGk5srK/UNMVjkVpGwQa1fbz5wVSxcZhkn2+0ZtRrOfkEMo4I25SM
         tQKorhm3Gyw1HwRUMuJDNOSd5XM5jPRdTdZN5Ckmh/IkOgmpkwxvSjh7ilDpuB3Ovj
         0bXNcfejtb7Rk8XehCQ8+5NmhFeCRrUEGAWNEVVgXqWBz4qiA7RZuEzOneXiUpYWuU
         73Usxjl6W+eFA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Sep 2018 09:27:04 +0000
From:   unconditionedwitness@redchan.it
To:     Willy Tarreau <w@1wt.eu>
Cc:     Olof Johansson <olof@lixom.net>, Edward Cree <ec429@cantab.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: Code of Conduct: Let's revamp it.
In-Reply-To: <20180920041846.GA4418@1wt.eu>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <20180920041846.GA4418@1wt.eu>
Message-ID: <206423b0a199c1f12e61364d6e687e09@redchan.it>
X-Sender: unconditionedwitness@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding those who are ejected from the Linux Kernel Community after 
this CoC:

Contributors can, at any time, rescind the license grant regarding their 
property via written notice to those whom they are rescinding the grant 
from (regarding their property (code)).

The GPL version 2 lacks a no-rescission clause (the GPL version 3 has 
such a clause: to attempt furnish defendants with an estoppel defense, 
the Linux Kernel is licensed under version 2, however, as are the past 
contributions).

When the defendants ignore the rescission and continue using the 
plaintiff's code, the plaintiff can sue under the copyright statute.

Banned contributors _should_ do this (note: plaintiff is to register 
their copyright prior to filing suit, the copyright does not have to be 
registered at the time of the violation however)

Additionally when said banned contributors joined the Linux team, they 
were under the impression that it was a meritocracy: in-fact this belief 
was stated or ratified by those within the governing body regarding 
Linux when the contributors began their work (whatever that body was at 
that time, it could have been simply Linus, or Linus and a few 
associates).

The remuneration for the work was implied to be, or perhaps stated, to 
be fame as-well as a potential increase in the contributors stature, in 
addition to membership in the Linux Kernel club or association, or 
whatever it is that the Linux Kernel Community actually is (which a 
court may determine... it is something, suffice to say).

Thusly for work, consideration was promised by (Linus? Others? There are 
years of mailing list archives with which to determine).

And now that consideration has been clawed-back and the contributors 
image has been tarnished.

Thus the worker did work, however the other side of the implied, or 
perhaps written (email memorandums), understanding has been violated 
(once the contributor has been banned under the new non-meritocratic 
"CoC").

Damages could be recovered under: breach of contract, quazi-contract, 
libel, false-light. (services rendered for the contractual claims, 
future lost income for the libel claims)

In addition to copyright claims. (statutory damages, profits)

For greatest effect, all rescission should be done at once in a bloc. 
(With other banned contributors).

Contributors: You were promised something, you laboured for that 
promise, and now the promise has become a lie. You have remedies 
available to you now, as-well as in the close future.

Additionally, regarding those who promoted the Code of Conduct to be 
used against the linux kernel contributors, knowing full well the effect 
it would have and desiring those effects; recovery for the ejected 
contributors via a tortious interference claim may be possible.
