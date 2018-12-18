Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38614C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED7C2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="MXga1/QJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeLRSxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:53:05 -0500
Received: from cock.li ([185.100.85.212]:46576 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbeLRSxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:53:05 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1545159181; bh=wKjWMkWYpJJOvxB+NnVrwA5kb/0iy36b1XIn2YRD2Zs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MXga1/QJt0NytvfkDyWvsgn6xF19Y0Ncs9o308327JDX2sIDGXQZq+kIGT6KnRCiC
         Smtntq6FRCZ8p7EhMpWbm9lVTEJyYVZvtf2qSUd4+R6mzuw/iozVB3P25DKtn4aG10
         qFuchk8daRDjX4nyA9nvrjQCHtUuARuG+hCqeBSo5RWro0kzX9c7LlYbbAp287aUNn
         BbGvwI4dxbqAYFmiaJSjivmoBOwjvK3s4L+/S8hPuF364k7q8TKqMguXsLDVq95KPI
         j3V2HBsDhWhg9RXdEehe2QF6cqmAWIIGBs+ppElJWRt1W+Bdt0b2ZfNIN1tdIKsmYp
         PIkXJx5pLp39g==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Dec 2018 18:53:00 +0000
From:   visionsofalice@redchan.it
To:     Eben Moglen <moglen@columbia.edu>
Cc:     linux-kernel@vger.kernel.org, esr@thyrsus.com,
        gregkh@linuxfoundation.org, rms@gnu.org, bruce@perens.com,
        bkuhn@sfconservancy.org, editor@lwn.net, neil@brown.name,
        labbott@redhat.com, torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org, tglx@linutronix.de,
        olof@lixom.net, clm@fb.com, mishi@linux.com,
        linux-kernel-owner@vger.kernel.org
Subject: Re: The linux devs can rescind their license grant. -  Analysis
 published?
In-Reply-To: <3068-Fri26Oct2018143130-0400-eben@harlan.sflc-vpn>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
 <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
 <20181025081911.GB11343@kroah.com> <20181025193901.GD26403@thyrsus.com>
 <849-Fri26Oct2018091533-0400-eben@harlan.sflc-vpn>
 <4c023302875de71cc58007301b180940@redchan.it>
 <3068-Fri26Oct2018143130-0400-eben@harlan.sflc-vpn>
Message-ID: <12836077374501b01a0c74a4e3f6276f@redchan.it>
X-Sender: visionsofalice@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Has the analysis been published yet?

I have been away on an artistic sabbatical, but I don't see it in the 
inbox using searches, this was the last mail I received on the subject.

On 2018-10-26 18:31, Eben Moglen wrote:
> On Friday, 26 October 2018, visionsofalice@redchan.it wrote:
> 
>   You are conflating case law dealing with commercial software and
>   non-gratuitous licenses with the present situation, which would 
> likely
>   be a case of first-impression in nearly any jurisdiction.
> 
> I think the best procedure would be for me to publish my analysis and
> for you then to tell me what is wrong with it.  What you say here
> sounds like what a lawyer might say, but isn't.  I have been teaching
> this stuff for about thirty years, so if I am conflating or confusing
> anything I will be grateful for help in seeing my mistake.
> 
>   The rule for gratuitous licenses is that they are revocable at the 
> will
>   of the grantor.
> 
> That's not actually "the rule."  It sounds like it might be the rule,
> but it so happens that it's not.  When I have given the explanation as
> I have learned, taught and depended on it, you will be able to show me
> what I am wrong about.
> 
>   Raymond Nimmer (God rest his soul) was in agreement on this point,
>   vis-a-vis the GPL and similar licenses.
> 
> You have your Nimmers confused.  The primary author of the treatise
> Nimmer on Copyright (a book about the law, not in itself an authority)
> was Melville Nimmer.  The treatise is continued by his son, David, a
> fine lawyer with whom I do from time to time politely disagree about
> something.  Ray Nimmer is quite another person.
> 
> Eben
