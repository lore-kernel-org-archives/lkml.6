Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76623C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125062075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125062075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thyrsus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeJZGQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:16:28 -0400
Received: from thyrsus.com ([71.162.243.5]:51120 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbeJZGQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:16:28 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id AF2BE3A42A3; Thu, 25 Oct 2018 17:41:23 -0400 (EDT)
Date:   Thu, 25 Oct 2018 17:41:23 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
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
Message-ID: <20181025214123.GA2448@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com, "Theodore Y. Ts'o" <tytso@mit.edu>,
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
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
 <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
 <20181025081911.GB11343@kroah.com>
 <20181025193901.GD26403@thyrsus.com>
 <20181025204718.GB25649@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025204718.GB25649@thunk.org>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Y. Ts'o <tytso@mit.edu>:
> On Thu, Oct 25, 2018 at 03:39:01PM -0400, Eric S. Raymond wrote:
> > Under Jacobsen vs. Katzer (535 f 3d 1373 fed cir 2008) authors of
> > GPLed software have a specific right to relief (including injunctive
> > relief) against misappropriation of their software. That ruling (which
> > was the case of first impression on the binding status of the GPL)
> > reputational damage is *specifically* recognized as grounds for relief.
> 
> I've read the legal briefs, and I'm pretty sure they don't say what
> you are claiming they say.  Yes, I'm not a lawyer --- but that's OK
> --- neither are you.

How much are you willing to gamble on not being wrong?

> The *vast* majority of the "anti-CoC dissidents" who have been
> advancing this argument, have, as near as I can tell, little or no
> copyright ownership in the kernel.

I do not have any facts with which to dispute this specific claim.
However, I do notice that a significant number of long-time
contributors have put themselves in the anti-CoC camp. I note Al Viro
as a recent example.

Even supposing you are right about most of the anti-Coc people being
outsiders, a tiny minority of people with a genuine IP stake could do a
lot of damage.  I ask again: how much are you willing to gamble on not
being wrong?

I definitely do not want to see the kind of explosion we could witness.
I think you are making it more likely rather than less by appearing
high-handed and dismissive.   Because, whatever the merits of the
CoC itself, there has been a process failure here.  It doesn't look
good to be defending that failure.

A change like the CoC adoption was not a good thing to do without
proper public notice, discussion, and consensus-building *beforehand*.
This was an unforced error on the part of the leadership group;
please, *please* don't compound it by digging in around the error.  Do
you really think you're going to win hearts and minds among insider
dissidents - people with a genuine stake - by dismissing the
opposition as a troll job?

Instead of declaiming about "trolls", how about we fix the process
failure instead?
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

My work is funded by the Internet Civil Engineering Institute: https://icei.org
Please visit their site and donate: the civilization you save might be your own.


