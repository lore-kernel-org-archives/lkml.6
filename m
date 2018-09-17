Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F649ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B06214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B06214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wowana.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeIQMaN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:30:13 -0400
Received: from mx1.volatile.bz ([185.163.46.138]:33824 "EHLO mx1.volatile.bz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbeIQMaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:30:13 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2018 08:30:12 EDT
Received: from clamav.local (unknown [172.22.1.2])
        by mx1.volatile.bz (Postfix) with ESMTPSA id 06C914CD;
        Mon, 17 Sep 2018 06:57:23 +0000 (UTC)
Date:   Mon, 17 Sep 2018 06:57:12 +0000
From:   opal hart <opal@wowana.me>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
Message-ID: <20180917065712.45d321f9@clamav.local>
Organization: Volatile
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-alpine-linux-musl)
In-Reply-To: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new kernel rc release is good news as always. The rest of this? not
so much.

"I can’t wait for the mass exodus from Linux now that it’s been
infiltrated by SJWs. Hahahah" -- @CoralineAda on Twitter [1][2]

You really want people like this attempting to sabotage FOSS projects?
I for one am not discontinuing usage of Linux over any political BS,
and I believe it is foolish for anyone to leave any software project
over politics, but that does not mean I welcome political agendas in
software development.

Your old Code of Conflict was perfect and succinct. If someone cannot
use their head to figure out what is right or wrong to say in a mailing
list or a commit message, that person is unfit for contributing to
software in general. This doesn't need to be spelled out for anyone. We
didn't need to explicitly bar discriminatory speech from software
discussion, because software discussion was never the place to have
discrimination against people -- it only allows for discrimination
against shitty code. You, Linus, have never attacked anyone from what I
have seen; you have only attacked poorly-decided actions, which is
perfectly justified. People who really want to contribute to Linux dust
their shoulders off, take your criticism, and figure out how to
re-approach you depending on what they did that was not to your taste.
Anyone who shies away from criticism is IMO unfit to contribute in the
first place. I mean, yes, there are ways to get your criticisms across
in a more "constructive" tone, but this does not call for any code of
conduct. Maybe you do need to take time to figure out how you want to
approach the community, but don't take it that you *have* to do
anything. You don't have to do a thing. People will still use Linux
regardless. People who care about Linux will continue to contribute to
it, because they do not take your words personally (nor should they).

This Code of Conduct trend is nothing but a concern-trolling campaign
that people carry out in order to gain control over projects,
organisations, and communities. Everyone is best off if we do not give
these people the control they desire. Take their demands with a grain
of salt: they suggest a boilerplate Code of Conduct, you decide which
parts from which Linux can benefit, if any.

[1] https://twitter.com/CoralineAda/status/1041441155874009093
[2] http://archive.is/1iGmk

This is just another two cents from a fellow faceless transgender woman
on the Internet, yours truly,
-- 
wowaname <https://wowana.me/pgp>
Please use detailed subject lines and reply below quoted text
whenever possible.
