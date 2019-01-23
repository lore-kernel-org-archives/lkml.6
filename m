Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3560CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E8120861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="lVVzG/nR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfAWMOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:14:15 -0500
Received: from cock.li ([185.100.85.212]:42396 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbfAWMON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:14:13 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1548245649; bh=2CPwDSLiHsSyM85CxyBE20VtmTX7w+a+6tk6ZNjuOts=;
        h=Date:From:To:Subject:From;
        b=lVVzG/nRRA7/K7vxZvS6CY9DMQDE5/qsg2rBMsZo/CBRV8GSTSI6k2XKSWC/yFcdM
         O0S7L3d8JP4JPoOQH3CEnvq77HSX6zwpMkiH31OYDiLtKOqQXM+InSPHycuKiTSniJ
         yxzJUF8vh232i0h7tcv9KAOje7u0VpBk1othZadOv49vSkhcxjfz9ZxzTrrKWM/Vwk
         3t1WufhNI/Ua8QL2znVbciTE0EITsHZnZZ/5TgddGy/c61KLn8+ypFmWiJDegEid39
         NYa4+XbOWYNPIgYs3ETmrXVin+N++1i62esbfMcE7ietwtr+cIRMszBvgYXiP0nBsE
         YvOlNiAJ8qwfA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Jan 2019 12:14:09 +0000
From:   linuxgpletc@redchan.it
To:     linux-kernel@vger.kernel.org
Subject: Various links (GPL revocation etc)
Message-ID: <f653890b55781395f69e18c6962bf0c0@redchan.it>
X-Sender: linuxgpletc@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Main:
https://lkml.org/lkml/2019/1/17/52 (GPL Rescission announcement)
https://lkml.org/lkml/2018/10/26/420 (Debunking of SFConservancy's 
statement)

Anti-Rescind:
ZDNet "Debunking" lulz.com article (by quoting PJ the paralegal, who got 
it wrong): 
https://www.zdnet.com/article/what-happens-if-you-try-to-take-your-code-out-of-linux/
This is constantly cited by "no recind"ers.
SFConservancy's "Debunking" of lulz.com article: 
http://sfconservancy.org/news/2018/sep/26/GPLv2-irrevocability/
(The new section: 
https://copyleft.org/guide/comprehensive-gpl-guidech8.html#x11-540007.4 
)
---
Pro-Rescind:
Refutation of SFConservancy's "debunking" of lulz.com article: 
https://lkml.org/lkml/2018/10/26/420
(Published 5 hours after the "debunking")

Public announcement of GPL Recission of GPC-Slots 2 game vs "Geek 
Feminists": https://lkml.org/lkml/2019/1/17/52
(This was also posted elsewhere, so as to be visible to the recindees, 
and sent to the mail of the named individuals, where it could be 
determined)

Submission to slashdot (wasn't posted): 
https://slashdot.org/submission/9087542/author-recinds-gpl
---
Eben Moglen vows to write a paper about how the GPL is irrevokable:
https://lkml.org/lkml/2018/10/26/718
2 months later still no paper to be found: 
https://lkml.org/lkml/2018/12/18/812
---
Other useful links:
8chan discussions with author, and expositions on the law:
http://8ch.net/tech/res/1013409.html
http://8ch.net/tech/res/1017824.html
http://8ch.net/tech/res/1018729.html

4chan /g/ discussion, expositions on the law:
https://warosu.org/g/thread/S69460068
http://archive.fo/OhIR4
http://boards.4channel.org/g/thread/69460068
---

Here's one user who did as suggested and consulted with an attorney 
friend, the attorney friend refuted the "following the GPL is 
consideration" argument nicely:
https://archives.gentoo.org/gentoo-user/message/f00ab8e848f886695425406179cbe67d

Thank you for the response, though I feel you don't address my
question. Happily though, I spoke with an acquaintance and it was
determined that the subservience to the license (i.e. agreeing to be
bound by the GPL2) could not be offered as consideration as its
restrictions were not the licensee's to offer at the time of
acceptance of the license. The licensee had no rights to offer as part
of the contract, as the contract had not yet given them any rights to
give up. The terms put forth by the GPL2 are only restrictions that
are part of the license.

Furthermore, as stated above, it should seem quite self referential -
I can't offer my acceptance of a license as consideration, because it
is what I am trying to accept.

As I am sure you are aware, under US law there is no contract if both
sides have not provided consideration. This leaves us in the strange
place of gratis licenses being suggestions.

Cheers,
     R0b0t1


---
Various other threads:
https://archives.gentoo.org/gentoo-user/message/52ee225d3f33445c49948cc0300bcf44
https://archives.gentoo.org/gentoo-user/message/cbcb2fbdd71f40ce8eae31d09a75432d
https://archives.gentoo.org/gentoo-user/message/0dfb4cf8b2c953a3e26e03f7d0faeeea
https://archives.gentoo.org/gentoo-user/message/f9e44b6e06b981b570fce68f3e70b889
https://archives.gentoo.org/gentoo-user/message/2c24e8c221bb1612957dabd730d08b09
https://archives.gentoo.org/gentoo-user/message/5325f76c1f90a6da813e8736e284e0ea
