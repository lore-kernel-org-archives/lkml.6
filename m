Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C8CECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690D421547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xEeE9mzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690D421547
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbeIUIMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:12:48 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:42630 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388834AbeIUIMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:12:48 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Sep 2018 04:12:46 EDT
Date:   Fri, 21 Sep 2018 02:16:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1537496195;
        bh=7kzkp8KEJHM6rTGjyQ2xjXCScOVGWUaX6YWPkEjGFJM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=xEeE9mznbrvD4lE7tVqsZmrx8zL9JX8Ziq6ZY0hygnumh8cV1hPtid3zkz0rN9w0F
         SS85UvX5XMCVmp1xg1RSNnTiIo0mIFa3psJWDrAfkJStYM7o+jWe49DLfX7vF5bM/c
         ioLTULgPmxxW0VnPIoMjj2g3OZCWG4Fe0lDiw12M=
To:     Rik van Riel <riel@surriel.com>
From:   unixing <unixing@protonmail.com>
Cc:     Edward Cree <ec429@cantab.net>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: unixing <unixing@protonmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <DnnwxXkM3V-CPhN11s-t3iwjDgZk30XHfaU7PmR7ZBCDsnmVDMtdIcKwVP7Zx420ZA1ai_RPw7Po-tw7ol2HkzfvXY_-6LA2L6QJ3hYIOyQ=@protonmail.com>
In-Reply-To: <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
 <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
Feedback-ID: wTGFgwcoIsrIh1iwo1bD9totX91T5sRcrLKtqn6c4s8nw7_WdI5LIfPdMxl3IVd7NLaC-vEFVC2YcJoCv_744g==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 21, 2018 1:48 AM, Rik van Riel <riel@surriel.com> wrot=
e:

> On Thu, 2018-09-20 at 03:14 +0100, Edward Cree wrote:
>
> > I think there are important differences between code to be run by
> > CPUs
> > and a Code to be run by humans. And when the author goes on a
> > victory
> > lap on Twitter and declares the Code to be "a political document",
> > is
> > it any surprise I'm worried?
>
> Speaking for myself, I expect there will be occasional
> impedance mismatches in communication between people
> from different cultures, and people with different
> neurotypes.
>
> That is not only expected, it is also perfectly fine.
>
> If people end up feeling like they are in conflict
> with each other, and they would like help resolving
> it, the first task of the TAB will be to mediate,
> and help people figure out how communication could
> be improved.
>
> The goal of the code of conduct is to make the community
> welcoming, and to help people with being a part of the
> Linux community.
>
> Mediation is not about telling people what to do,
> but about asking the people involved what they would
> like to see, and helping to breach the gap between
> their styles of communication.
>
> As an aside, the TAB has no power to remove anyone
> from the community. Patches are applied by maintainers,
> mailing lists are run by their administrators.
>
> The only things the TAB can do is mediate and advise.

That couldn't be more wrong. The existence of a TAB itself
is the problem. The community will be pushed to behave
according to what TAB expects to, otherwise the person will
be shamed and could even have their job jeopardized.
The world currently is walking towards a culture where everyone claimed to =
be oppressed becomes a mini dictator that can force,
shame, offend. I borrow the words of a wise man who's no longer
alive: =E2=80=9CAll of it began the first time some of you who know
bettet... let young people think that they had the right to
choose the laws they would obey as long as they were doing it in
the name of social protest.=E2=80=9D
I'm using a phony e-mail because I don't feel "job-wise" safe to
criticize this culture, as the punishment is to lose job, end
career, end social life, etc.

I ask our fellows linuxers to not allow this culture to take over
our community. If the current code of conflict isn't working, let's
create a new one, politically NEUTRAL, and without any set of people
with power to dictate the behavior of thousands of engineers. Linux
is NOT a hostile place to work. According to this culture, I am a
minority, coming from third world country who found on Linux
community (since kernel 2.4) a very good source of knowledge and
freedom.

Kind regards,

Unixing
