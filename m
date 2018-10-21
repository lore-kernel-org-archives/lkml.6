Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E317ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 23:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E52204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 23:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E52204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thyrsus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeJVHxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 03:53:01 -0400
Received: from thyrsus.com ([71.162.243.5]:55378 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbeJVHxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 03:53:00 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id CEF453A42A3; Sun, 21 Oct 2018 19:36:14 -0400 (EDT)
Date:   Sun, 21 Oct 2018 19:36:14 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an
 interpretation document
Message-ID: <20181021233614.GA17140@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
References: <20181020134908.GA32218@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020134908.GA32218@kroah.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> This patch series adds this new document to the kernel tree, as well as
> removes a paragraph from the existing Code of Conduct that was
> bothersome to many maintainers.

I think the changes have improved it.

There is still a process issue with how this code was promulgated that
is clearly bothering a lot of people, but I hope that problem is well
enough understood that we don't need to rehash it.  More transparency,
more consultation, and more notice of intent to revise would help
head off future problems.

I do have one content recommendation.  In the version at

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/code-of-conduct.rst

which I presume is current, I see a paragraph that reads as follows:

>In the interest of fostering an open and welcoming environment, we as
>contributors and maintainers pledge to making participation in our project and
>our community a harassment-free experience for everyone, regardless of age, body
>size, disability, ethnicity, sex characteristics, gender identity and
>expression, level of experience, education, socio-economic status, nationality,
>personal appearance, race, religion, or sexual identity and orientation.

I recommend that all the text from "everyone" on be struck as (a) unnecessary,
and (b) tending to embroil the project in politico-cultural wars that can do
it no good - and replaced by "every individual".

That is, the result would read:

>In the interest of fostering an open and welcoming environment, we as
>contributors and maintainers pledge to making participation in our project and
>our community a harassment-free experience for every individual.

That is all that needs to be said. Listing all those specific
categories of "regardless of" implicitly privileges certain kinds of
identity (those listed) and disfavors others (those not listed).
Further, some of the phrases used fo categories are political
shibboleths that unavoidably drag in American presumptions not
appropriate for an international project.

Best to leave the whole mess out and just pledge to treat individuals well.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

My work is funded by the Internet Civil Engineering Institute: https://icei.org
Please visit their site and donate: the civilization you save might be your own.


