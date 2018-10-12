Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47879C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1750F20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1750F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fatal.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeJLRAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:00:32 -0400
Received: from 82-209-166-85.cust.bredband2.com ([82.209.166.85]:55784 "EHLO
        pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbeJLRAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:00:32 -0400
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Oct 2018 13:00:30 EDT
Received: by pi.fatal.se (Postfix, from userid 1000)
        id B6F8524496; Fri, 12 Oct 2018 11:19:41 +0200 (CEST)
Date:   Fri, 12 Oct 2018 11:19:41 +0200
From:   Andreas Henriksson <andreas@fatal.se>
To:     Jaroslav Skarvada <jskarvad@redhat.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpluskal@suse.com,
        base-system@gentoo.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Bombe <andreas.bombe@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: Future of dosfstools project (FAT)
Message-ID: <20181012091941.o22srnhse4kzqjhf@fatal.se>
References: <20180929084038.an6pfhnsd6tblejl@pali>
 <20181002081654.jxesr3kj62snzez5@pali>
 <510499199.34825028.1538469850257.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <510499199.34825028.1538469850257.JavaMail.zimbra@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

On Tue, Oct 02, 2018 at 04:44:10AM -0400, Jaroslav Skarvada wrote:
> I am downstream maintainer of dosfstools in Fedora/RHEL. My personal opinion
> with such kind of projects is that one or two years without activity doesn't
> mean the project is dead. I don't know what happened with Andreas, but
> in case of no response my +1 for the GitHub fork. I think it's non offensive
> solution which can be easily reverted if needed. Please let me know if you do it

It seems Andreas is a Debian Developer (like myself), so I used the
debian tooling for 'missing in action' (mia-query) and it seems
he is occationally active (but showing obvious signs of busyness).

I even found his irc nick and found him online. I told him about this
mailing list thread and he replied that he has been extremely busy
with things in his personal life lately and said he should really
try to find some time to catch up with things, but since he hasn't
replied here I thought I'd just let you know about the situation.
Hopefully things calms down for him soon to allow him to catch up.

I hope you find a good way to handle things in the mean time. More
people probably need to help out reviewing incoming issues/PRs and other
things that can help Andreas out with the maintenance burden, but with
his current lack of time it might be better if someone motivated and
capable just forks the project on github and starts doing the
maintenance work in the fork. If things works out well, maybe this gives
Andreas confidence he can safely hand over the official maintainer role
to someone with more time for it (and you can 'unfork' again).

Regards,
Andreas Henriksson
