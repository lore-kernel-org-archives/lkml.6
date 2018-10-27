Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C69C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 07:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D2E2085B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 07:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="OBB/93yR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D2E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeJ0Pwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 11:52:44 -0400
Received: from cock.li ([185.100.85.212]:36898 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbeJ0Pwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 11:52:44 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1540624359; bh=HH/59LlMrC3J4c+stT8qLvBfiQOQOiDw511Rw2KCnxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OBB/93yRH7L8dJcb5foyKVAEZ22fUKgKINHjzCXUt4HC5m963Yi5FrVIMIJTjgOGq
         0D0NWi+yLU4eZRuplPnYWK+6eJjI0ZppuPrLonsyljOiwnD5+0ymG+xlaHpwHgvoAm
         N/ihNrc8+uC0XH7xXLLefHRcUf17biO7Gew39MHoyxnay9WC46LdKSMOTAVX2gzvbT
         NFi6p4HdVJdsEfiLme5SiIT5f7DvtkFGAg0g0Cztw7PEWmVJ5N5bb14092kRYq1sM6
         WEOnzsItNlI0Q4n/gvUdUkc/BQuzW2PlwRupspyVRWutR/ArNtBpX8ibVSrfTwb545
         Ktj9NKLA44IKA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 27 Oct 2018 07:12:39 +0000
From:   visionsofalice@redchan.it
To:     linux-kernel@vger.kernel.org
Cc:     Eben Moglen <moglen@columbia.edu>, esr@thyrsus.com,
        gregkh@linuxfoundation.org, rms@gnu.org, bruce@perens.com
Subject: Re: The linux devs can rescind their license grant.
In-Reply-To: <3068-Fri26Oct2018143130-0400-eben@harlan.sflc-vpn>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
 <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
 <20181025081911.GB11343@kroah.com> <20181025193901.GD26403@thyrsus.com>
 <849-Fri26Oct2018091533-0400-eben@harlan.sflc-vpn>
 <4c023302875de71cc58007301b180940@redchan.it>
 <3068-Fri26Oct2018143130-0400-eben@harlan.sflc-vpn>
Message-ID: <f10ae195193dcf695b6623508ffd4cc7@redchan.it>
X-Sender: visionsofalice@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lawrence Rosen is also in agreement on this point (regarding the GPL v2 
specifically).
It is revocable at the will of the grantor, at any time.
(He writes that if a licensee-contributor was to sue a grantor, then 
would be a good time to unilaterally rescind: disposing of the matter 
entirely)

The contention that a copyright license is only terminable is 
traditionally usually true in practice; but not because such is declared 
by the Copyright Statute (such is not). It is because, in practice, 
those terms are supported by consideration. Thus the licensee has payed 
the grantor for those very terms to be in effect.

In the case of most users and most developers of the linux-kernel this 
is not the case.

In-fact The very principal that, in the real world, precipitated the 
widespread adoption of linux:
that no consideration is paid for receipt of the program.

The GPL v2 is not supported by consideration.
This is its strength.
And it is not something that can be disclaimed after the fact.

The drafter of version 2 of the GPL did, indeed, make an error in 
drafting. He was, perhaps, familiar mostly with commercial copyright 
licenses.
The foundation of the GPL does not rest on any contemplation of 
quid-pro-quo or contract theories however;
it is on the simple declaration in the Copyright Statute that copyright 
is alienable in all ways property is.
The GPL v2 is similar to a property license, and not a traditional 
commercial copyright license.

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
