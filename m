Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5C1C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0125C21850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="zMxNkW6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbeLXP0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 10:26:55 -0500
Received: from cock.li ([185.100.85.212]:35826 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbeLXP0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 10:26:55 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1545665213; bh=LbBXAHl9MbXz5ay5w/q4/wafmsAMRPXdbDmAQaWG4Yo=;
        h=Date:From:To:Subject:From;
        b=zMxNkW6L18Nma21acjEzSo9seF52qNCkCKIQ9jmuMY7ik19Pad66I4uF70EX/21ee
         61SK/cKUfS2MgWa0/2xIhfAKLLW6i9zjY8b7qk/7LxUSHe6PCN8HVszgcSRr4NRn+8
         JEJrCXhFLAjI2mkNThcdlGFTlCvhuROXIlaJ8vm4m1DTxXCjxply8wtZMge+48nkv5
         4/kRHVJECLDWTn//6gdho2cEN8ImcVMBzQb3w5xElu6RIQaHgn4okzN4g4VkYLKGXr
         TIcqbiI9Kym3J396ckEXpATReGEUiYMxXE83FVEBtq1XCeu3psFBLYUkK2fMtg9gCY
         5ZBFWtHABvsuw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Dec 2018 15:26:52 +0000
From:   vsnsdualce@memeware.net
To:     linux-kernel@vger.kernel.org, gentoo-user@lists.gentoo.org,
        ubuntu-users@lists.ubuntu.com, debian-user@lists.debian.org
Subject: 2 months and no response from Eben Moglen - Yes you can rescind your
 grant.
Message-ID: <e7f56d389bc2ccea7db507b4913603ba@memeware.net>
X-Sender: vsnsdualce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been 2 months. Eben Moglen has published no research.

Because there is nothing more to say: The GPLv2, as used by linux, is a 
bare license. It can be rescinded at the will of the grantor.

The regime that the FSF used, vis-a-vis the GPLv2, is essential: 
copyright transfers to a central repository entity that is sure not to 
rescind.

Linus chose not to adopt this regime.
He benefited by greatly increased developer contribution.
The price for that windfall was and is the retention of their 
traditional property rights by the property holders.

They can rescind at will.
They made no promise nor utterance to the contrary that can be relied 
upon.
They were paid no consideration.
There was no meeting of the minds.

Additionally the CoC regime itself is a license terms violation, being 
an additional restrictive term, as explained in the other analysis. 
(Similar to the GRSecurity license violation)

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


