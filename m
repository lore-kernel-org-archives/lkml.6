Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40B4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC242054F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="nGycEEmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390545AbeLVRuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:50:05 -0500
Received: from cock.li ([185.100.85.212]:45112 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbeLVRuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:50:04 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1545487920; bh=LbBXAHl9MbXz5ay5w/q4/wafmsAMRPXdbDmAQaWG4Yo=;
        h=Date:From:To:Subject:From;
        b=nGycEEmKJxnYunJmJO/LaSlZQWJYJWxsBNeGimz5SagaSz4tMXVqNuOFeasEYb7NJ
         PRfgkbEfF0HBblfJuoHfV3B8EE/0ik01FuhaERO7bNMVVuzJGf8aKfvonfUZy8wjhx
         3rhjudGQ9OkA1/sA3duQUg0d2tod9MCf/PdUu5+uKzpNnCBarokt4aCXkumw2iNBkx
         7skRM35l3yowWCzDXu8dSF+18Cv2h6j5K6zmceJGxvNv577ji9VGIDesCcmnuSb5v+
         /kaAca4BdaGy0LfBGMHcJNkrDXMFD5qce4aYK3L6t6gOb9IVJEX3yWy3nmXe5Njpub
         UJ0tfDQPysYkA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 22 Dec 2018 14:11:59 +0000
From:   visionsofalice@redchan.it
To:     linux-kernel@vger.kernel.org, esr@thyrsus.com,
        gregkh@linuxfoundation.org, rms@gnu.org, bruce@perens.com,
        bkuhn@sfconservancy.org, editor@lwn.net, neil@brown.name,
        labbott@redhat.com, torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org, tglx@linutronix.de,
        olof@lixom.net, clm@fb.com, mishi@linux.com,
        linux-kernel-owner@vger.kernel.org
Subject: 2 months and no response from Eben Moglen - Yes you can rescind your
 grant.
Message-ID: <ba0a084f86b57d447fb77cde3805ac92@redchan.it>
X-Sender: visionsofalice@redchan.it
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
