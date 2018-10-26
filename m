Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E059C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD1B20856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD1B20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thyrsus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJ0A2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:28:18 -0400
Received: from thyrsus.com ([71.162.243.5]:41942 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbeJ0A2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:28:17 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id DCF033A42A6; Fri, 26 Oct 2018 11:50:01 -0400 (EDT)
Date:   Fri, 26 Oct 2018 11:50:01 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Eben Moglen <moglen@columbia.edu>
Cc:     gregkh@linuxfoundation.org, visionsofalice@redchan.it,
        linux-kernel@vger.kernel.org, rms@gnu.org, bruce@perens.com,
        bkuhn@sfconservancy.org, editor@lwn.net, neil@brown.name,
        labbott@redhat.com, torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org, tglx@linutronix.de,
        olof@lixom.net, clm@fb.com, mishi@linux.com,
        linux-kernel-owner@vger.kernel.org
Subject: Re: The linux devs can rescind their license grant.
Message-ID: <20181026155001.GA6327@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com, Eben Moglen <moglen@columbia.edu>,
        gregkh@linuxfoundation.org, visionsofalice@redchan.it,
        linux-kernel@vger.kernel.org, rms@gnu.org, bruce@perens.com,
        bkuhn@sfconservancy.org, editor@lwn.net, neil@brown.name,
        labbott@redhat.com, torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org, tglx@linutronix.de,
        olof@lixom.net, clm@fb.com, mishi@linux.com,
        linux-kernel-owner@vger.kernel.org
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
 <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
 <20181025081911.GB11343@kroah.com>
 <20181025193901.GD26403@thyrsus.com>
 <849-Fri26Oct2018091533-0400-eben@harlan.sflc-vpn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <849-Fri26Oct2018091533-0400-eben@harlan.sflc-vpn>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eben Moglen <moglen@columbia.edu>:
>  reputational damage is *specifically* recognized as grounds for relief.
>   
> No.  Reputational damage is not mentioned at all, let alone
> specifically recognized.

I have no difficulty in finding the word "reputation" in the brief in
in proximity with the phrase "increasing [the programmer's] recognition in
his profession". In fact the brief notes " The Eleventh Circuit has
recognized the economic motives inherent in public licenses, *even
where profit is not immediate*" (Emphasis mine.)

And "The attribution and modification transparency requirements
directly serve to drive traffic to the open source incubation page and
to inform downstream users of the project, which is a significant
economic goal of the copyright holder *that the law will enforce.*"
(Emphasis mine.)

You seem to be denying that the brief says what it actually says.  It
not only qualifies reputational gain as a kind of economic
gain - and thus losses as damage - but cites the Eleventh Circuit as a
previous authority for the proposition, and affirms that these gains
and losses can be a matter for the law.

This disinclines me to trust the rest of your analysis or assertions.
I think you are advocating for your interest in the perceived
irrevocability of the GPL, and where this implies being less than fully
forthcoming about the actual risks in *this* situation you are committing
something perilously close to suppressio veri.  This is not helpful.

I've lived with a practising attorney since about the time she was one
of the first-line legal reviewers for the original GPL back in the
1980s - we probably still have the draft printout with her scribbled
annotations on it somewhere.  "Only lawyers can interpret this voodoo"
is not a good line to pull on me when it comes to open-source
licensing; I don't buy it and she wouldn't either.


Here's another sentence from the brief that I had forgotten:
"Copyright holders who engage in open source licensing have the right
to control the modification and distribution of copyrighted material."
- a particularly telling sentence in regard to the current
controversy, and one I had forgotten.

That there could be enough to win the day for the license
revokers - they don't actually have to revoke, just assert that
control.  Pretty much equivalent to what the the Berne Convention's
moral-rights provision does in Europe - they could claim that the
CoC is a defacement of their work to which they refuse assent
and have a case.

I am not at all doubtful that the dissidents know these things; some
of the language in the broadsides to lkml so indicates.  Which is why
I'm trying to get the kernel leadership to repair its unnecessarily
high-handed behavior before somebody gets pissed off enough to
actually drop a bomb.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

My work is funded by the Internet Civil Engineering Institute: https://icei.org
Please visit their site and donate: the civilization you save might be your own.


