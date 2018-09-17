Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7977ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E035220867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="KpfzyLV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E035220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeIRDoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 23:44:07 -0400
Received: from cock.li ([185.100.85.212]:52364 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbeIRDoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 23:44:06 -0400
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2018 23:44:05 EDT
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1537222487; bh=nvO4Mh8YSenpdAsCY8//cKkhvujHthOVQlmxI+pozQQ=;
        h=Date:From:To:Cc:Subject:From;
        b=KpfzyLV4b1p4hwdnzz/sdNG3odiKrqq4XQqLbzHdAvb6XxV1mYY2zqITTlEPm7rnp
         Kf6TPriq/Qcl3iLlPSlqJv/gAfWmXQSl8jITYsOmTTs0iAPczM9NcGid22oZeKzC2i
         LGtDD3n69fmd9ls0TcWs/6Di1PaNXnojGZp2v+T9H9Dk/qyTJCt9xANGv1WFr6N05Y
         Ogf4QsmqLFhMDHkG+85aNSOrtzHcuSEu4g4V6aLZR1mqvdDo0TvsgIWNda+LU34b8I
         +Y1R5UJlGAQqiPn30/pW+FH9v3aUMNjtLQWarQjyYK0z/yXtYCli9zOZw9bHjT5qaP
         woipNc1cQDmKw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Sep 2018 22:14:46 +0000
From:   observerofaffairs@redchan.it
To:     moglen@columbia.edu, tcallawa@redhat.com,
        blukashev@sempervictus.com, bkuhn@sfconservancy.org,
        dng@lists.dyne.org, debian-vote@lists.debian.org, bruce@perens.com,
        esr@thyrsus.com, editor@lwn.net, torvalds@osdl.org
Cc:     debian-user@lists.debian.org, oss-security@lists.openwall.com,
        linux-kernel@vger.kernel.org
Subject: GPL version 2 is a bare license. Recind. (Regarding (future) linux
 Code of Conduct Bannings).
Message-ID: <f02bb27c83835d2b95c279e887fb3bfc@redchan.it>
X-Sender: observerofaffairs@redchan.it
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
their copyright prior to filing suit, the copyright doe not have to be 
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

