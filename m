Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5C6C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17AA20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17AA20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJZHlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:41:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52684 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbeJZHlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:41:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFoiO-0003dk-Bw; Thu, 25 Oct 2018 23:06:56 +0000
Date:   Fri, 26 Oct 2018 00:06:56 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     esr@thyrsus.com, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        visionsofalice@redchan.it,
        linux-kernel <linux-kernel@vger.kernel.org>, rms@gnu.org,
        bruce@perens.com, moglen@columbia.edu, bkuhn@sfconservancy.org,
        editor@lwn.net, NeilBrown <neil@brown.name>,
        Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: The linux devs can rescind their license grant.
Message-ID: <20181025230656.GJ32577@ZenIV.linux.org.uk>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
 <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
 <20181025081911.GB11343@kroah.com>
 <20181025193901.GD26403@thyrsus.com>
 <20181025204718.GB25649@thunk.org>
 <20181025214123.GA2448@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025214123.GA2448@thyrsus.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 05:41:23PM -0400, Eric S. Raymond wrote:

> I do not have any facts with which to dispute this specific claim.
> However, I do notice that a significant number of long-time
> contributors have put themselves in the anti-CoC camp. I note Al Viro
> as a recent example.

*snort*

For the record:
	* CoC is a piss-poor match for the structure of community
	* Linus had essentially tossed a live grenade into an outhouse on
his way to vacation, with quite predictable results - all kinds of
interesting coprophagous fauna dropping by to feed, including cartooneys
of the sort I hadn't seen since NANAE days.
	* As idiotic gambits go, "try and revoke the license on my
contributions, so that they'll have to revoke CoC" is... impressive.
Sadly, my command of English has turned out to be woefully inadequate,
and I can't even blame that on not being a native speaker; I'm just as
incapable of producing a coherent (let alone printable) description of
that cunning plan in any language, Russian included.  I've tried.  Really.
	* in case it needs to be spelled out: I am not at all interested
in that kind of stunts.  One of the reasons I thoroughly despise RMS
and his bunch is the leverage game they tried to play with GPLv3;
damned if I'm going to lower myself to their level.
