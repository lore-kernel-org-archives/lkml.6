Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53EFECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FD92098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="aALDlHQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FD92098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbeISVMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:12:31 -0400
Received: from cock.li ([185.100.85.212]:38062 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732255AbeISVMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:12:30 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1537371238; bh=MSwgXj5vGt82h+lOuaD1ypZ7yIcYG1iNbUIJhmISl8M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aALDlHQZgBjuNi7JIUgaZJqW0uumZnHiHYXCdgZZKQ96xjF2ZYExR1CUDWkzisutC
         0Iamo/QpSWNlGwStwLn6RUaAX620ThUShqQtteXP9cnGk1a1P4Yo1H7EWj3zffcuYx
         +cVsdur8jj6T+7Jlt0aCAB+AFkjjYhPtw/o5OFN/DGSk4PKS3CjRreBwFAD2q+Lgek
         R2TbNgS0o8YLKe0Qvrxms0OVkq+oQY5YZp4kWStawBqu/i98FEOA3HCPQuHj2eBW1j
         inmNiwLQx7ON4fAItTO1VRLkB93lH8LFc0TzHmE/fAoYCg1b8+H2Z8WLMmqDOPxw7I
         iOsCs9bup56kg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Sep 2018 15:33:58 +0000
From:   observerofaffairs@redchan.it
To:     linux-kernel@vger.kernel.org
Cc:     dng@lists.dyne.org, debian-user@lists.debian.org
Subject: Fwd: Re: Fwd: Re: [DNG] GPL version 2 is a bare license. Recind.
 (Regarding (future) linux Code of Conduct Bannings).
In-Reply-To: <4f926d0e5b96673926f3a4f163fdb590@redchan.it>
References: <6b4a0cf6fa672938b8ab98acd1dea0a1@redchan.it>
 <BBFE2346-72C7-47D3-910A-DD720C7637DC@charter.net>
 <24cf6d6095c740903f16b56e22dd137c@redchan.it>
 <996c99ea4146a247730d87df14dfca1a@redchan.it>
 <E1g2TJn-0006lD-Lm@fencepost.gnu.org>
 <CAK2MWOssGczVO1Cd_SPVVb=ieCs2vkpFUfve9P3sh+gT1VfN7Q@mail.gmail.com>
 <4f926d0e5b96673926f3a4f163fdb590@redchan.it>
Message-ID: <f3ac1e0424fed0fcbf782a6c9b1209a0@redchan.it>
X-Sender: observerofaffairs@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CoC will lead only to infighting amongst the contributors, with this 
new weapon wielded firmly in all participants hands.

It is another example of "looking the gift horse in the mouth"
(Linus telling everyone to [fsck] off is the previous example]
and will only be tolerated by the hirelings. The community contributors 
will fade away and the complete corporate takeover of the kernel will be 
complete.

Linux will suffer the same fate as the FreeBSD team (who have lost half 
their contributors), additionally morally-questionable code (ie: code 
that befits content owners over the user, code that benefits the 
security interests of the states over the user, etc) will be folded into 
the kernel with a smile.

While you are correct regarding most free-software and open-culture 
licenses, which often include a no-rescission clause, or are stylized as 
a contract (giving rise to a possible interest defense), it does not 
apply to version 2 of the GPL specifically (remeber: Linus rejected the 
any-later-version codicil, thus any license improvements are out of 
reach regarding the kernel, and v3 has very important improvements). 
Version 2 of the GPL creates no contractual interests, nor does it 
contain language that would give clear indication to the grantee that 
his license will never be revoked by the property owner (who has an 
absolute right to revoke grants at will, where there is no interest 
attached to the grant etc).

The Free Software movement is, and will continue to be decimated by this 
industry-wide advance for the next 5 years at-least, as project after 
project falls to classic divide and conquer techniques that date to 
before the Roman empire. Programmers, though brilliant in their specific 
field, tend to be ignorant of even basic human management practice - and 
resistant to learn.


On 2018-09-19 08:43, Bruce Perens wrote:
> I concur with Richard. Everything I know about the license tells me it
> can not be rescinded or withdrawn. It can only be terminated for
> infringement.
> 
> I understand that codes of conduct added to the group long after your
> first participation are frustrating for some, and may even seem
> draconian. I see the need for them, and suggest you consider the views
> of others.
> 
> If you have no alternative, the license allows you to fork the project
> and make your own conduct rules.
> 
> Thanks
> 
> Bruce
> 
> On Wed, Sep 19, 2018, 5:38 AM Richard Stallman <rms@gnu.org> wrote:
> 
>> [[[ To any NSA and FBI agents reading my email: please consider
>> ]]]
>> [[[ whether defending the US Constitution against all enemies,
>> ]]]
>> [[[ foreign or domestic, requires you to follow Snowden's example.
>> ]]]
>> 
>>> One is rescission of the license they granted regarding their
>> code, and
>>> then a lawsuit under copyright if/when the rescission is
>> ignored.
>>> The others are breach of contract, libel, false light, etc.
>> 
>> If "rescission" is really a possibility, it would cause greast
>> trouble
>> for the free software community.  We would need to take steps to
>> make
>> sure it cannot happen.
>> 
>> However, that goes against everything I have been told by others.
>> 
>> --
>> Dr Richard Stallman
>> President, Free Software Foundation (https://gnu.org,
>> https://fsf.org)
>> Internet Hall-of-Famer (https://internethalloffame.org)
