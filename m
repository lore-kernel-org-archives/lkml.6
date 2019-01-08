Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61434C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1272920663
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="w4e2jwAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfAHBWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 20:22:25 -0500
Received: from cock.li ([185.100.85.212]:46754 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfAHBWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 20:22:24 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546910540; bh=AQRJT6YdqpKfRiZ1D7LC1Xd+mRG2qrRJhSOf8ZG6NLI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w4e2jwAe4Q6xGs02APMfehfIgKD0MGSYMC8rUladM6aHstYG9xwKLh/IO1K3SeDAd
         m8Y7iUauFpYOuShjMaZOujo1iNVxksPampgJtBn4h377SjUii51CR1P16zMbNZUcSW
         T04+GQ6l6+BAx7i0KBXNbyg7Aw8vXj6HKlNXvsjl+Tzvzcr2++9rCQPLHLozVL4hRh
         VDHXrSctPfku2ha/k4Vo+6JAUcMmI1sxXzjOnQprqYpuvRy4edZmcKd0EHG04js8If
         Rr/aKysPvKEKjRLEwLPN5rHBhNyvkEc/GBQpA7O+//1HWqbjVaA0tBDKZE3BPbuQ60
         /fLvWx2wUAVFw==
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 08 Jan 2019 01:22:19 +0000
From:   vsnsdualce@memeware.net
To:     Ivan Ivanov <qmastery16@gmail.com>
Cc:     gary@extremeground.com, alessandro.baggi@gmail.com,
        joe@jretrading.com, deloptes@gmail.com, dpchrist@holgerdanske.com,
        mfidelman@meetinghouse.net, raju.mailinglists@gmail.com,
        debian-user@lists.debian.org, debian-devel@lists.debian.org,
        linux-kernel@vger.kernel.org, gentoo-user@lists.gentoo.org,
        misc@openbsd.org, freebsd-chat@freebsd.org
Subject: Re: Why choose Debian on server
In-Reply-To: <CAAaskFAocqH3PywY1b6AZ5TqZeydc6MjfS_TNCsxEgd9Gm8OtA@mail.gmail.com>
References: <496e512d-4733-fb85-2bc8-84584070781d@gmail.com>
 <b56ed858-fed3-e7fc-dfbf-00f7f9e5b6b2@torfree.net>
 <CAAaskFAocqH3PywY1b6AZ5TqZeydc6MjfS_TNCsxEgd9Gm8OtA@mail.gmail.com>
Message-ID: <1f6e7c030fba1c86f5cc74e61ef22b64@memeware.net>
X-Sender: vsnsdualce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed.
Anything _with_ systemd is insecure.
Any linux distro _without_ the GRSecurity patch is insecure.

There is nothing secure about Debian.

Linux kernel is swiss cheese without the GRSecurity/PaX etc patch.
(BTW: GRSecurity is currently (Blatantly) violating the licensing terms 
of the kernel by adding additional restrictive terms so as to prevent 
redistribution -- which has succeeded*)

*Infact the pro-CoC part of the kernel team itself seems to have been 
inspired by GRSecurity in some manners here, adding their own additional 
writing inorder to pressure, libel, and threaten civil torts against 
those who don't obey their speech codes. Threatening the various other 
copyright holders themselves.

(There is a remedy: Rescind)

Those are the facts.

On 2019-01-03 09:00, Ivan Ivanov wrote:
>> Debian is very secure
> 
> But it uses systemD as its' init system which has a really bad
> security: over 1 million lines of poorly written code and authors are
> deliberately ignoring the security issues - to a point where systemD
> has been awarded a Pwnie anti-award because of arrogant devs refusing
> to fix a critical vulnerability. If you need a true security, choose
> Devuan: it has all the benefits of Debian + much simpler init system
> with in order of magnitude better security, thanks to "Keep It Simple,
> Stupid" principle
> 
>> Because Debian doesn't come from a company,
>> it can't go out of business or be taken over.
> 
> As a technical project, Debian can ruin itself by choosing the
> political decisions over technical, like it recently did by removing a
> Weboob package after the herassment of some SSJiWs from Debian
> antiher.assment team. Luckily Devuan is not affected by this madness.
> 
> чт, 3 янв. 2019 г. в 07:40, Gary Dale <garyndp@gmail.com>:
> 
>> 
>> On 2019-01-02 5:51 a.m., Alessandro Baggi wrote:
>> > Hi list,
>> > I'm new to this list and I'm choosing the right distribution for
>> > server needs. I hope that I'm not OT and don't want start a flame. I'm
>> > evaluating the possibility to switch on debian so I hope you will give
>> > your experiences about this topic.
>> >
>> > At the moment I'm using CentOS 7 on server and workstation but very
>> > old software, add third repos for get some software, use unmaintained
>> > software where patchs are released by dev distro team, big changes
>> > between a current release and next release, big corporation piloted
>> > distro, waiting that rh release a security patches and then recompiled
>> > on centos, problem on new hardware, unable to install new software
>> > from source due to old libs get me bored, and frustated in the last
>> > year. I like flexibility and I noticed that centos chains my knowledge.
>> >
>> > Today seems that RH Family is the standard and rh is more supported by
>> > software vendors. Considering 10 years of support, Selinux working out
>> > of the box, stability, enteprise class and free distro..user choose
>> > Centos with the perception that things work better because all is
>> > "followed" by a corporation. With this assumption users feel more
>> > secure and unfailing.
>> >
>> > This is not necessarely true. I think that is the sysadmin that make
>> > things safer, secure and unfailing. Sure that a stable and reliable OS
>> > take his part but when big blue take this game I'm not so sure about
>> > centos future. What if someone will choose to drop centos project?
>> > Maybe this is premature but from this "Why not choose a stable and
>> > community piloted distro where user needs are first purpose?"
>> >
>> > I used Debian in the past on several server for a big company without
>> > any problems but now are several years that I use centos on server and
>> > workstation and today I lost my debian knowledge about stability on
>> > server usage.
>> >
>> > Why you choose debian on server? Where for you it is better than
>> > centos and other server distro?
>> >
>> > Thanks in advance.
>> > Alessandro.
>> >
>> Because Debian doesn't come from a company, it can't go out of 
>> business
>> or be taken over. And because Debian has lots of spinoffs, including
>> distros that are in the commercial server market (e.g. Ubuntu), you 
>> can
>> bet that everything runs on it and it runs on everything.
>> 
>> Debian is also very stable and very secure. While Red Hat may have a
>> segment of the corporate market, I'll bet that there are more Debian
>> servers than Red Hat. If you think Red Hat has the market cornered, 
>> you
>> aren't looking at the full market.
>> 
>> Then there are things like the Raspberry Pi, which are used in a lot 
>> of
>> specialized server-type tasks, that mainly use Debian. They can do a 
>> lot
>> of things that are useful in a corporate environment that you wouldn't
>> want to put on a real server.
>> 
>> I also use Debian on my desktop (I have for decades) so there is a 
>> good
>> knowledge crossover. I don't need to learn and use two different kinds
>> of systems.
>> 
>> 
