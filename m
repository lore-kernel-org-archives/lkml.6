Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C369ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B18120867
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="DyjtuXOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B18120867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbeITIhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:37:22 -0400
Received: from cock.li ([185.100.85.212]:41772 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732415AbeITIhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:37:21 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1537412175; bh=WUN87q+jR9eyal0KWUKnMRba5GFYUEq1N52GdCUGtw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DyjtuXOYPN38HX48Ba57HtWzn13A2KUV9dP8Pzln9yd1AcYyef0PFd28Xjcdn+pu9
         zaZFCZuCH2Kyw65w0UVpQgkGgyuW54UsVCiYZZfJQ7eXU3JjaR1bda7jeI0audkIzc
         fVbTMONdvSXRsAGcydrumwIMzq/SpbGygsNPOuG3Cfy4m3mvBIXN0u7JVz4UP7D8k/
         AwTo40K76ZI5qlEl30sBjKd7AAsQR4U0RMS/pvcn4k+fOcfJ2bNnI49olzOHm7imZ3
         t6g6hnk8IixlDbSoHM4YmWoEKM/1wsqTlf+3vPgGl2/8vQ7TOjlxm84tNFnGO7qBFY
         ltbx6ZeLzeD9w==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Sep 2018 02:56:14 +0000
From:   observerofaffairs@redchan.it
To:     Steve Litt <slitt@troubleshooters.com>
Cc:     dng@lists.dyne.org, linux-kernel@vger.kernel.org,
        debian-user@lists.debian.org
Subject: Code of Conduct: Those Ejected should rescind their license grant.
In-Reply-To: <20180919130952.2b2c23cc@mydesk.domain.cxm>
References: <6b4a0cf6fa672938b8ab98acd1dea0a1@redchan.it>
 <BBFE2346-72C7-47D3-910A-DD720C7637DC@charter.net>
 <24cf6d6095c740903f16b56e22dd137c@redchan.it>
 <996c99ea4146a247730d87df14dfca1a@redchan.it>
 <E1g2TJn-0006lD-Lm@fencepost.gnu.org>
 <CAK2MWOssGczVO1Cd_SPVVb=ieCs2vkpFUfve9P3sh+gT1VfN7Q@mail.gmail.com>
 <4f926d0e5b96673926f3a4f163fdb590@redchan.it>
 <f3ac1e0424fed0fcbf782a6c9b1209a0@redchan.it>
 <20180919130952.2b2c23cc@mydesk.domain.cxm>
Message-ID: <39f9be93ddae0da9898df646f960740d@redchan.it>
X-Sender: observerofaffairs@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The grant is not supported by consideration.
It dispenses only largess, and asks for no recompense.
It is a bare license.
Thus it can be revoked by the grantor at any time.
His act of grace bestowed, and his act of propriety can rescind.

The free software world is held up muchly by a gentleman's agreement.
The agreement is that we shall take mutually beneficial actions, vis a 
vis the field of software engineering, to increase the net freedom 
available to all.

It is not so much held up by law, regardless of what the lay programmers 
and users of programmers would imagine to believe.

To turn one's contributions around as a weapon against the contributor:
to tell him he must not say this or that, he must not act this or that 
way,
lest he be barred from his hobby; let he be barred from freely giving
dispensation, is an abhorrent abuse of his magnanimity

Now this gentleman's agreement is being, or has been shattered.
You will find that the law has no supports to bind him;
but many to fell the ungrateful who saw themselves the inviolate 
annuitants of his altruism.

Bare licenses are revocable at will. They always have been.
Those who are thrown out of the "Linux Kernel Community" in punishment 
for not obeying this CoC, who's past contributions count for nothing in 
the face of those who will throughout the ages to control men in all 
things; for not "behaving properly" here or there, within their public 
or private life; for not bending the knee to the Anglo-American 
religion, should absolutely recind the grant they have dispensed.
They are well within their rights to do so, and hostile action must be 
met with the same and worse in response.



On 2018-09-19 17:09, Steve Litt wrote:
> On Wed, 19 Sep 2018 15:33:58 +0000
> observerofaffairs@redchan.it wrote:
> 
>> The CoC will lead only to infighting amongst the contributors, with
>> this new weapon wielded firmly in all participants hands.
> 
> You've made your point. Now stop it. The remedies you suggest, if they
> could even be legally done, would hobble the Linux Kernel project, to
> the great delight of Google, Microsoft and Apple. Long observation of
> people resenting CoCs  is they want the right to speak cruelly to
> individuals and speak cruelly about groups of people, those groups
> having nothing to do with the list's core foundation (Linux sans
> systemd, in our case). The person continuing to use terminology, having
> nothing to do with the core foundation of the mailing list, that others
> ask them not to use, has a real problem, and it's not the list's duty
> to help with that problem. The project is probably better off without
> the person --- his or her priorities are just plain wrong.
> 
> Your posts are offtopic. You've made your point. Please stop now.
> 
> SteveT
> 
> Steve Litt
> September 2018 featured book: Quit Joblessness: Start Your Own Business
> http://www.troubleshooters.com/startbiz
> _______________________________________________
> Dng mailing list
> Dng@lists.dyne.org
> https://mailinglists.dyne.org/cgi-bin/mailman/listinfo/dng
