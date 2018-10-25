Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFECECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191642082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191642082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thyrsus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeJZENu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:13:50 -0400
Received: from thyrsus.com ([71.162.243.5]:42052 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbeJZENu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:13:50 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id E6C733A42A3; Thu, 25 Oct 2018 15:39:01 -0400 (EDT)
Date:   Thu, 25 Oct 2018 15:39:01 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     visionsofalice@redchan.it,
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
Message-ID: <20181025193901.GD26403@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025081911.GB11343@kroah.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Thu, Oct 25, 2018 at 07:56:26AM +0000, visionsofalice@redchan.it wrote:
> > The linux devs can rescind their license grant.
> 
> No they can not, please do not keep spreading false information.

I think the confusion about whether applying GPL can be rescinded has
obscured the most serious actual threat vector.

Under Jacobsen vs. Katzer (535 f 3d 1373 fed cir 2008) authors of
GPLed software have a specific right to relief (including injunctive
relief) against misappropriation of their software. That ruling (which
was the case of first impression on the binding status of the GPL)
reputational damage is *specifically* recognized as grounds for relief.

The anti-CoC dissidents don't have to rescind their license grant to
cause a great deal of trouble. Instead they can invoke the doctrine
established in Jacobsen vs. Katzer, seeking restraining orders.  The
line of argument is so simple that I could probably brief it myself,
and I'm not a lawyer - just somebody who had to become a topic
expert in this area to do my job as the founding president of OSI.

For that matter, I don't think the question of whether the GPL can be
rescinded is settled - nor does my wife Cathy Raymond, Esq., a practicing
attorney who has also studied the relevant law.

Be very skeptical about what the FSF or SFC tells you about this; they
have a very strong institutional/ideological incentive to affirm
irrevocability regardless of what the law actually says.  I, on the
other hand, don't have an ideological stake to defend in that
argument; I'm telling you that the doctrine forbidding perpetual
grants may very well have teeth here. There is, at any rate,
significant risk that a court will see it that way.

Between Jacobsen vs. Katzer and the prohibition against perpetual grants
I think you are incurring a grave risk by assuming the dissidents have
no ammunition.

Better for both sides to climb down from a confrontational position
before real damage gets done.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

My work is funded by the Internet Civil Engineering Institute: https://icei.org
Please visit their site and donate: the civilization you save might be your own.


