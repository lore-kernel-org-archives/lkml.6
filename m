Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3225AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D144A206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 03:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="pdu8VUFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D144A206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbeITJ1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 05:27:02 -0400
Received: from cock.li ([185.100.85.212]:42964 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbeITJ1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 05:27:02 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1537415146; bh=EDxj1pR3xUGr8N1G4Elyegr09pWZKDHgftaRqQ3bRdo=;
        h=Date:From:To:Subject:From;
        b=pdu8VUFEvzulDri5uaheLgt4tIhuGQOvO8FubZf1FReQfxtWFPeqLPdS8iDv3ZJpX
         2sArdM5HvyZaO8LzGTeA3gYQJeKBJ+U8uMJq5DfBnook2Gecd0GAAbl1vqeZJbAW0n
         NSKuI0MqeGnL+F/r4wIH+ZDs6psQk3EV11TFsYelk3cQQ+FRCeNdkRc4sKuZWph1i2
         TASfSmb79y+Z7jFDrkisOfpHgiuB780jPkY0bcYBDr5GdIPOjBeLBA/OYzbmmYUB7g
         Fgto6bFzu/4QITjWlErZmqTKnUmdstyvhExRX9Pdkqi5j03pzNeDqwEXQk3Y52eOOI
         X+1dot3hnUexw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Sep 2018 03:45:46 +0000
From:   unconditionedwitness@redchan.it
To:     linux-kernel@vger.kernel.org
Subject: Code of Conduct: Those Ejected should rescind their license grant.
Message-ID: <38df74370ee2d5cde5ce80ca021569fc@redchan.it>
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
available to all .

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
