Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF8DECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331222146E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 04:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="MarkZyy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331222146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387563AbeITJof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 05:44:35 -0400
Received: from cock.li ([185.100.85.212]:51730 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbeITJof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 05:44:35 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1537416195; bh=08ubr0l3vRkytX8H0wSPmq6Gwt5phqLVeZJh/x4qAsE=;
        h=Date:From:To:Subject:From;
        b=MarkZyy/6tu08xs2sU86Wbxwnw7sIvf7Z7c8ici8AMAFA7eWO984987q+QPWCluaQ
         GCj8Yj8z1eJa9+VS66Q8AC7Nl8bMqXmePCYdVqrGfQPw7eE5b31+Ay5FRb5qa1PyDg
         GAbkFJduVUxgngVh4q4XzpAtQJQEYBFFlXnIy+l4IXLncwZLL5BtH8cdEjiAblXDGF
         aSx84U9AXFjUuqfBBXECtUyIQ1gBMtJgBFa3YzkS5w35E5G1l5WZgPijG8G6OIowDG
         aKcKbEpqhYVoCKmfVBb4WUtV9SU6CipXYZSW+G+5ssRT0uZ3D+0q9wkmmquRNn5Nuv
         A2RrRewD3dIHg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Sep 2018 04:03:15 +0000
From:   unconditionedwitness@redchan.it
To:     linux-kernel@vger.kernel.org
Subject: Code of Conduct: Those Ejected should rescind their license grant.
 (Yes, bare license grants can be rescinded at the will of the grantor)
Message-ID: <a3dde93fa26a4c67aede3338b0167055@redchan.it>
X-Sender: unconditionedwitness@redchan.it
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

