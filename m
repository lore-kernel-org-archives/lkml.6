Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9D2C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5E620868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5E620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=columbia.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeJZV7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:59:43 -0400
Received: from moglen4.apt.columbia.edu ([160.39.60.15]:47413 "EHLO
        moglen4.apt.columbia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZV7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 17:59:43 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Oct 2018 17:59:43 EDT
Received: from localhost (moglen1.apt.columbia.edu [160.39.60.12])
        by moglen4.apt.columbia.edu (Postfix) with ESMTPSA id 368512E01F2;
        Fri, 26 Oct 2018 13:15:34 +0000 (UTC)
Date:   Fri, 26 Oct 2018 09:15:33 -0400
Message-Id: <849-Fri26Oct2018091533-0400-eben@harlan.sflc-vpn>
X-Mailer: emacs 23;
        VM 8.1.0 under 23.2.1 (i486-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To:     esr@thyrsus.com
Cc:     gregkh@linuxfoundation.org, visionsofalice@redchan.it,
        linux-kernel@vger.kernel.org, rms@gnu.org, bruce@perens.com,
        bkuhn@sfconservancy.org, editor@lwn.net, neil@brown.name,
        labbott@redhat.com, torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org, tglx@linutronix.de,
        olof@lixom.net, clm@fb.com, mishi@linux.com,
        linux-kernel-owner@vger.kernel.org
Subject: Re: The linux devs can rescind their license grant.
In-Reply-To: Eric S. Raymond's message of Thu, 25 Oct 2018 15:39:01 -0400
      <20181025193901.GD26403@thyrsus.com>
References: <20181020134908.GA32218@kroah.com>
        <87y3ar80ac.fsf@notabene.neil.brown.name>
        <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
        <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
        <20181025081911.GB11343@kroah.com>
        <20181025193901.GD26403@thyrsus.com>
From:   Eben Moglen <moglen@columbia.edu>
Reply-To: Eben Moglen <moglen@columbia.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 25 October 2018, Eric S. Raymond wrote:

  Under Jacobsen vs. Katzer (535 f 3d 1373 fed cir 2008) authors of
  GPLed software have a specific right to relief (including injunctive
  relief) against misappropriation of their software. That ruling (which
  was the case of first impression on the binding status of the GPL)
 
No, Eric, _Jacobsen_ v. _Katzer_ has nothing to do with GPL.  The
license terms on the software at issue were Artistic 1.0.  The GPL is
mentioned in an informational footnote only.  The case has little
legal weight, for procedural reasons, and is most certainly not "the
case of first impression on the binding status of the GPL."

 reputational damage is *specifically* recognized as grounds for relief.
  
No.  Reputational damage is not mentioned at all, let alone
specifically recognized.  The District Court opinion that was
overturned in the Court of Appeals had held that licenses that don't
require payment of royalties are unenforceable, which was not
copyright law of any kind.  The CAFC, guessing about the content of
Ninth Circuit law under the jurisdictional rules of the appeal (a
state of affairs which leaves no real precedential weight at all
behind the opinion) rightly discovered that there are "economic
interests" furthered by free licensing.  Reputational interests are
not among those mentioned.  This is a <a
href="https://caselaw.findlaw.com/us-federal-circuit/1189790.html">public
document</a> anyone can read.  I'm a little surprised you didn't check
before asserting.

  The anti-CoC dissidents don't have to rescind their license grant to
  cause a great deal of trouble. Instead they can invoke the doctrine
  established in Jacobsen vs. Katzer, seeking restraining orders.

They can do neither.  There is no "doctrine established in Jacobsen."
The license terms of the GPLv2, GPLv3, and all related licenses
provide a mode of termination---for imposition of additional
restrictions or violation of other terms.  This termination provision,
being explicit, is therefore the sole form of termination recognized
under the terms of the Copyright Act.

  The line of argument is so simple that I could probably brief it
  myself, and I'm not a lawyer

Law school exists to give people who are not yet lawyers a healthy
respect for what they cannot do.  This discussion has been a riot of
amateur opining, but practicing law without a license is always a bad
idea.

  For that matter, I don't think the question of whether the GPL can be
  rescinded is settled - nor does my wife Cathy Raymond, Esq., a practicing
  attorney who has also studied the relevant law.

It is settled.  Indeed, it was never in doubt.  When Jerry Cohen made
GPLv2 he was of course asked by Richard to make an irrevocable
license.  He did so.  The US law provides that this license cannot be
terminated except on its stated terms.  But the basis of that rule,
which is statutory, was not reliable under non-US law, so in GPLv3 I
"codified" the US result in the license terms, as we did with various
other features in which GPLv2 assumed the US law background.

What the discussion set off by the present CoC controversy showed me
was that there was no accessible, legally-accurate description of US
copyright license termination law as it affects the various FOSS
licenses in particular.  I wrote such an article and began preparing
it for publication, but was interrupted in that work by my mother's
last illness and death.

In the meantime everything said on all sides, for and against, has
been wrong.  The correct legal analysis has been offered nowhere.  As
I am beginning to return to work, I will publish the article soon.
For now, the headline is that Greg is correct.  There is nothing in
the repeated assertions that some form of withdrawal of licensed rights
or attacks on the copyright status of the kernel are a possible
response to disagreement over changes in internal project governance.

It's a small point---and like all the other supposed points raised so
far, irrelevant---but I should say in passing, after years of teaching
the basic Property course at Columbia and Harvard law schools, that
Bruce Perens gave as succinct a description of the "rule against
perpetuities" as I ever hear from a beginner in the classroom.  In the
English legal history course that I also teach (almost the only place
in a modern law school in which the law of future interests is
seriously considered), more is said.  But the key point is that the
"rule against perpetuities" is not a rule against perpetuities.  The
confusion on this point is one of the clearest signs that the writer
or writers using various pseudonyms is/are not, whatever s/he claims,
a US or UK lawyer at all.

Eben

-- 
 Eben Moglen                            v: 212-461-1901 
 Professor of Law, Columbia Law School  f: 212-854-7946       moglen@
 435 West 116th Street, New York City, NY 10027            columbia.edu
 Founding Director, Software Freedom Law Center        softwarefreedom.org
 
