Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE49CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1341F21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="jaJiztQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfAWW2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:28:49 -0500
Received: from cock.li ([185.100.85.212]:38808 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfAWW2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:28:49 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1548282525; bh=yf/+IV/vn7/J86Ya2sqUAAyKoDrcBK4L9VNRaNJVFJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jaJiztQ/YPoH/VbDXLgOXuSF20eDTjNzQQ71V18eTq373gOBLQlWxJ/1zPYCgwBH4
         TeQA5zFUCdgO3fUop5RVJ5oN4563t1oHebCdWv55O7DNZZdX753Py6bexpvT/DJQxO
         3cqJsqMq6U9Bii8u6IpisfcqL8J9278mG/EpwENiWzaoBE4HO07v5fgbyQdAt1HYSN
         9CgaaGxxcOKUyAUpUSRWWvdd6rzWt1EH6gDJhpXPnaSzphkUiraA99OIjhwPmJJ/gR
         PV0eSYnCPx4hw6rcPtieo37ZPaNQ9sOJGjWp11eGrk4smT13ehhe4ETt9yZoBEZXPk
         uxAXXi9Ru0W4w==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Jan 2019 22:28:45 +0000
From:   linuxgpletc@redchan.it
To:     Ivan Ivanov <qmastery16@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freebsd-chat@freebsd.org, misc@openbsd.org,
        gentoo-user@lists.gentoo.org, rms@gnu.org, esr@thyrsus.com
Subject: Re: GRSec is vital to Linux security
In-Reply-To: <CAAaskFDMjUzonLeHPmiy_VcB=jvQfF9giEaWcmNLKHDTqQt4BA@mail.gmail.com>
References: <fe8a4e103943d671ff0ce2c4f09609f9@redchan.it>
 <CAAaskFDMjUzonLeHPmiy_VcB=jvQfF9giEaWcmNLKHDTqQt4BA@mail.gmail.com>
Message-ID: <28315c204184b212a3a60cdd393c3fd3@redchan.it>
X-Sender: linuxgpletc@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-23 20:46, Ivan Ivanov wrote:
> Interesting point of view. Well, to be honest it seems to me that
> Linux kernel sacrifices the security for the sake of progress, so it
> is quite bloated at the moment and I am not sure that even GRSecurity
> could fix it. Linux really needs to stop adding new features and
> refactor itself to a smaller and more secure codebase before going
> forward. Maybe 1 year break would be nice.

This man speaks the truth. The constant flux reintroduces long-fixed 
bugs, like a constant inflowing tide. The code can never be stabilized 
due to the endless needless work of the worker-bee wage-slaves. Thus the 
code always has new hidden security errors.

GRSecurity can barely keep up.

A "feature" of the wage-slave era of Linux, that we did not have in the 
Hacker era of Linux (the people targeted by the CoC, who actually 
created the land where the wage-slave code churners now graze)

"Free" workers from for-profit and government connected enterprises do 
not come with no-strings-attached, and the enterprises are not stupid: 
they refactor to get their way if an initial strategy isn't working.

The only real flux of any significant magnitude that should occur is 
with the addition of new drivers. Instead code is ripped out and 
replaced everywhere for little to no real gain.

That being said... GRSecurity's GPL violation is the most blatant 
upfront violation of the GPL I've ever seen (they put it in writing and 
don't try to hide it (you redistribute, we punish you)).

They also do not deal with small businesses or people who would like to 
purchase a "license" from them. Only large businesses and government 
contracts.

They're afraid that a small company would pay for 1 server "license" and 
then release the code, I think.

Some people wonder why hasn't anyone penetrated their Download server 
and stolen the code back and released it?

Maybe because GRSecurity knows what they're doing. If it were hosted on 
a vanilla linux server, it would be out by now.

Remember: it's been well over a year. Not one leak of the code, not one 
penetration, nothing. They know how to secure a linux machine. Linus 
does not. He just allows endless useless flux, barely manages the 
project, places it all in the hands of the wage-slaves (who simply do 
their job for their company, not for the betterment of the thing (no 
passion)) and ousts the old Hackers who built the thing with Linus from 
the ground up originally.

Legal action could be taken to stop GrSecurity's blatant violation; one 
could atleast sue for the profits. It is a non-seperable work, they are 
violating the "no additional restrictions" rule, in writing. They 
violated the copyright - it's as simple as that in the end.

No one does a thing. Ofcourse the wage-slaves do not: they don't own 
their own code and don't have agency even over their own lives anyway. 
Their bosses could do something though, the companies that own the 
wage-slave's code. The Hackers, who's code still resides in the linux 
kernel AND/OR who's code was a predecessor of current code (even if it 
is not the same as their original code) also have standing.

Nothing is done. It's as if the GPL is just worthless trash. It has not 
stopped GRSecurity from closing their derivative work of the kernel and 
threatening anyone who would redistribute the non-separable derivative 
work. They just laugh at Linus, the Hackers, and especially the 
wage-slaves.

Didn't someone once say "Linux will be free forever" (hint: Lawrence 
Rosen). A piece of Linux isn't now... It hasn't panned out in reality.


