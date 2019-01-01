Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D078FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 23:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DA42073F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 23:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="VwjckNme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfAAXHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 18:07:46 -0500
Received: from cock.li ([185.100.85.212]:44588 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfAAXHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 18:07:45 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546384062; bh=ziCrLxESBf7kwEdnRKdsrZUPz2kwqXGWln8gA4gdcvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VwjckNmeH7wqdbkeZUpWHZtr97yobNCRd4cXA3Nx4etmR0BqCkMkTeqDBejlD4GYl
         mYFPWaZB0qu3CxTSF0WCI2sq1brgKzkrZwEt4CK0seWWQhbbUSRK3ioeT0QuUyioMG
         6Am8r98pnj9T7DXzR8mudZjJr8dTJ98IJAhTD7vlCV0s1pMAiFoG7odzCbkrj6DXbV
         Z7vSkEDQtKPOZTpgddVGvE0msckqN6SjwjxcdSlZsk5i1hDcEdd7JVM24FSKfTfTQJ
         6N8gymcORAFaGble7nXufnTgAIr7NjqyhPlB/FF2ieBM6tu5WehRD5YooXhOpWYWSu
         Z0CfuzPJli1ig==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Jan 2019 23:07:41 +0000
From:   vsnsdualce@memeware.net
To:     gentoo-user@lists.gentoo.org
Cc:     Rich Freeman <rich0@gentoo.org>, linux-kernel@vger.kernel.org,
        debian-user@lists.debian.org, misc@openbsd.org
Subject: Re: [gentoo-user] Re: CoC loving Linux programmers... is completely
 on topic.
In-Reply-To: <CAGfcS_mbwDEr6BdQ=BBCKA+UPhQOBoTHPheM6eXvdrgHf7s2bg@mail.gmail.com>
References: <a6f3c4d6d8c85f1db2e84682b8305339@memeware.net>
 <q0fn2v$q4j$1@blaine.gmane.org>
 <604e57a471c4ce5ecca308125e9bb25b@memeware.net>
 <8cbdc777-07c9-fe50-7708-22ffcbfb5669@gmail.com>
 <CAGfcS_mbwDEr6BdQ=BBCKA+UPhQOBoTHPheM6eXvdrgHf7s2bg@mail.gmail.com>
Message-ID: <014598109c6272575635449ed6d6df3d@memeware.net>
X-Sender: vsnsdualce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Funny, the pro-CoC developers claim any discussion is off-topic on the 
linux developer lists.

The licensing of linux-kernel is completely on topic, since there may
be linux-copyright-holders reading this list.

They have been told they have no rights, that they transferred them 
away.

This is a complete lie.
They have only magnanimously granted a license to use their code.

They have received nothing for it.
It is a gratuitous license given by them.

They can rescind this license from whomever they want at any time.
Including the linux kernel project.


> This
> is being resolved off-list shortly.

Some veiled threat?

Because you do not like my way of speaking, or the topic?
You want the property-owners to be dispossessed?


On 2019-01-01 20:49, Rich Freeman wrote:
> On Tue, Jan 1, 2019 at 3:44 PM Dale <rdalek1967@gmail.com> wrote:
>> 
>> Question.  Why are these license discussions being done on a USER list
>> instead of a DEVELOPER list?  Gentoo has mailing lists that are to be
>> used for this sort of topic.  How about taking them there?  Here is a
>> link with them listed.
>> 
> 
> This is indeed off-topic for this list (and other Gentoo lists).  This
> is being resolved off-list shortly.
> 
> I appreciate everybody's ongoing patience with not replying.
