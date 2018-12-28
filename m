Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1E6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA2920879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="yy0O3yL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbeL1Rbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 12:31:36 -0500
Received: from cock.li ([185.100.85.212]:57574 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbeL1Rbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 12:31:36 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546018292; bh=s0zqPFsYY8ec9E1esg0nCucoUNGApeXUsz9yw9aWrkc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yy0O3yL9qKsR0+/nIuJANs6i338amtXkXLxQ2miXwpY1lTe8a/tcWyMFYNyAAxmyw
         /DHihMAA4V+i+8GWJRxn8Dd2MqLuWx5L6QsWiWE02aM5pmas6lU8iSBuBA4veLPjS/
         vQyC4xDSHTFhS3MGMXCpwcoSbLq6BGyA3Tzf/ejJkIxhXZQIUuzOaGYAPKPkCJeu/1
         9vO6taVE2Zl6xUb2qd2mZstlPedYonWacI5v2NlcL2Rk1QkpxV/As7nOXwD8GdZRty
         ViQCuawnLZPMF52G7Y0+I6L893r0VHlt+3Oi8k6HJ7slWkcjQq89PhVOwx3n1akvS0
         8LInE8KLYqRDQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Dec 2018 17:31:31 +0000
From:   vsnsdualce@memeware.net
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Bon Onlines <bononlines@gmail.com>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        Raul Miller <rauldmiller@gmail.com>,
        OpenBSD general usage list <misc@openbsd.org>,
        linux-kernel@vger.kernel.org, freebsd-women@freebsd.org,
        freebsd-chat@freebsd.org, owner-misc@openbsd.org
Cc:     linux-kernel-owner@vger.kernel.org
Subject: Re: Why is no one discussing this anymore? - Attack the messaging
 rely, not the message!
In-Reply-To: <20181228135728.GD5864@mit.edu>
References: <20181228135728.GD5864@mit.edu>
Message-ID: <c9d2e5c760bd722c2363acb440b9f12a@memeware.net>
X-Sender: vsnsdualce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lieutenant Ts'o:
I see that you have adopted the strategy of "Attack the messaging 
service, not the message".

You cannot refute my arguments, you and yours simply claim "it's a lie", 
"it's BS!", "it's a troll".

The fact of the matter is: a license without an interest attached is 
revocable by the grantor.
That is: if you have not been paid to forgo your right to rescind, you 
still retain that right.

In the case of Linux or BSD: if entity X did not pay you, and did not 
reasonably rely on a promise not to rescind
(a promise you never made), you can rescind the license at any time.

This goes for all the 1000s of linux and BSD programmers who have not 
transferred their rights.

Yes I am a licensed attorney.
Yes my analysis is correct.
And yes I'm still waiting on Eben Moglen's promised counter-analysis 
(it's been 2 months)...
take a guess as to why.

On 2018-12-28 13:57, Theodore Y. Ts'o wrote:
> +-------------------+             .:\:\:/:/:.
>          |   PLEASE DO NOT   |            :.:\:\:/:/:.:
>          |  FEED THE TROLLS  |           :=.' -   - '.=:
>          |                   |           '=(\ 9   9 /)='
>          |   Thank you,      |              (  (_)  )
>          |       Management  |              /`-vvv-'\
>          +-------------------+             /         \
>                  |  |        @@@          / /|,,,,,|\ \
>                  |  |        @@@         /_//  /^\  \\_\
>    @x@@x@        |  |         |/         WW(  (   )  )WW
>    \||||/        |  |        \|           __\,,\ /,,/__
>     \||/         |  |         |          (______Y______)
> /\/\/\/\/\/\/\/\//\/\\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
> ==================================================================
> 
> 
> I recommend that people not respond to vsnsdualce@memeware.net,
> visionsofalice@redchan.it, and in general, any e-mail coming from
> domains served by the cock.li service (which comes from the IP address
> 185.100.85.212).  As you can tell if you go to its web page, this
> mailer serves the following domains:
> 
> 	cock.li, airmail.cc, 8chan.co, redchan.it, 420blaze.it,
> 	aaathats3as.com, cumallover.me, dicksinhisan.us,
> 	loves.dicksinhisan.us, wants.dicksinhisan.us, dicksinmyan.us,
> 	loves.dicksinmyan.us, wants.dicksinmyan.us, goat.si, horsefucker.org,
> 	national.shitposting.agency, nigge.rs, tfwno.gf, cock.lu, cock.email,
> 	firemail.cc, getbackinthe.kitchen, memeware.net, cocaine.ninja,
> 	waifu.club, rape.lol, and nuke.africa
> 
> This has been a public service announcement.
> 
> "Never to wrestle with a pig. You get dirty, and besides, the pig
> likes it." - George Bernard Shaw
