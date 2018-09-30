Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AC3C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 14:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381A120833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 14:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381A120833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeI3UlB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 16:41:01 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:57099 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbeI3UlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 16:41:01 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 3D1D93BD915;
        Sun, 30 Sep 2018 16:07:49 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     lkcl@lkcl.net
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
Date:   Sun, 30 Sep 2018 16:07:48 +0200
Message-ID: <8998740.bsg6g2nRDU@merkaba>
In-Reply-To: <20180930120909.30469-1-lkcl@lkcl.net>
References: <2936237.GcMzexieOU@merkaba> <20180930120909.30469-1-lkcl@lkcl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lkcl@lkcl.net - 30.09.18, 14:09:
> > That written: Quite some of the rude mails that contained swearwords
> > I read from you have been about code, not persons. I think this is
> > an important distinction. I do not have much of an issue with
> > swearing at code :), especially when it is in some humorous way.
> 
>  absolutely, and this is one thing that a lot of people are, sadly,
>  trained pretty much from birth to be incapable of understanding:
>  namely the difference between criticism of the PERSON and criticism
>  of the ACTION.
> 
>  (1) "YOU are bad! GO STAND IN THE NAUGHTY CORNER!"
>  (2) "That was a BAD thing to do!"
>  (3) "That hurt my feelings that you did that"
> 
>  the first is the way that poorly-trained parents and kindergarten
>  teachers talk to children.
> 
>  the second is... only marginally better, but it's a start
> 
>  the third is how UNICEF trains teachers to treat children as human
> beings.

During releasing a lot of limiting "stuff" I found that probably nothing 
written or said can hurt my feelings unless I let it do so or even… 
unless I choose (!) to feel hurt about it. So at times I am clear about 
this, I´d say: "I have chosen to feel hurt about what you did."

However in this human experience a lot of people, including myself, 
still hold on to a lot of limiting "stuff" which invites feeling hurt. 
We, as humankind, have a history of hurting each other.

During this releasing work I also learned about two key ingredients of 
successful relationships: Harmlessness and mutuality. I opted out of the 
hurting cycle as best I can. And so I choose to write in a way that 
moves around what from my own experience of feeling hurt I know could 
hurt others. I choose to write in a harmless way so to say. While still 
aiming to bring my point across. A very important ingredient for this is 
to write from my own experience. 

Of course others can feel hurt about something I would not feel hurt 
about and I may not be aware that the other might feel hurt about. That 
is why in such a case it is important to give and receive feedback. 
Still when writing from my own experience without saying that anything 
is wrong with the other, it appears to be unlikely to trigger hurt. That 
is at least my experience so far.

Thanks,
-- 
Martin


