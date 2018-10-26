Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB62ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A582085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A582085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=columbia.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbeJ0DJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:09:37 -0400
Received: from moglen4.apt.columbia.edu ([160.39.60.15]:47738 "EHLO
        moglen4.apt.columbia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbeJ0DJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:09:37 -0400
Received: from localhost (moglen1.apt.columbia.edu [160.39.60.12])
        by moglen4.apt.columbia.edu (Postfix) with ESMTPSA id B8DD32E0158;
        Fri, 26 Oct 2018 18:31:30 +0000 (UTC)
Date:   Fri, 26 Oct 2018 14:31:30 -0400
Message-Id: <3068-Fri26Oct2018143130-0400-eben@harlan.sflc-vpn>
X-Mailer: emacs 23;
        VM 8.1.0 under 23.2.1 (i486-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To:     visionsofalice@redchan.it
Cc:     linux-kernel@vger.kernel.org, esr@thyrsus.com,
        gregkh@linuxfoundation.org, rms@gnu.org, bruce@perens.com,
        bkuhn@sfconservancy.org, editor@lwn.net, neil@brown.name,
        labbott@redhat.com, torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org, tglx@linutronix.de,
        olof@lixom.net, clm@fb.com, mishi@linux.com,
        linux-kernel-owner@vger.kernel.org
Subject: Re: The linux devs can rescind their license grant.
In-Reply-To: visionsofalice@redchan.it's message of Fri, 26 Oct 2018 17:32:58 +0000
      <4c023302875de71cc58007301b180940@redchan.it>
References: <20181020134908.GA32218@kroah.com>
        <87y3ar80ac.fsf@notabene.neil.brown.name>
        <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
        <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
        <20181025081911.GB11343@kroah.com>
        <20181025193901.GD26403@thyrsus.com>
        <849-Fri26Oct2018091533-0400-eben@harlan.sflc-vpn>
        <4c023302875de71cc58007301b180940@redchan.it>
From:   Eben Moglen <moglen@columbia.edu>
Reply-To: Eben Moglen <moglen@columbia.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 26 October 2018, visionsofalice@redchan.it wrote:

  You are conflating case law dealing with commercial software and 
  non-gratuitous licenses with the present situation, which would likely 
  be a case of first-impression in nearly any jurisdiction.

I think the best procedure would be for me to publish my analysis and
for you then to tell me what is wrong with it.  What you say here
sounds like what a lawyer might say, but isn't.  I have been teaching
this stuff for about thirty years, so if I am conflating or confusing
anything I will be grateful for help in seeing my mistake.
  
  The rule for gratuitous licenses is that they are revocable at the will 
  of the grantor.

That's not actually "the rule."  It sounds like it might be the rule,
but it so happens that it's not.  When I have given the explanation as
I have learned, taught and depended on it, you will be able to show me
what I am wrong about.

  Raymond Nimmer (God rest his soul) was in agreement on this point, 
  vis-a-vis the GPL and similar licenses.

You have your Nimmers confused.  The primary author of the treatise
Nimmer on Copyright (a book about the law, not in itself an authority)
was Melville Nimmer.  The treatise is continued by his son, David, a
fine lawyer with whom I do from time to time politely disagree about
something.  Ray Nimmer is quite another person.

Eben

-- 
 Eben Moglen                            v: 212-461-1901 
 Professor of Law, Columbia Law School  f: 212-854-7946       moglen@
 435 West 116th Street, New York City, NY 10027            columbia.edu
 Founding Director, Software Freedom Law Center        softwarefreedom.org
 
