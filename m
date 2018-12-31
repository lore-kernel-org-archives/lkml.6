Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A495C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 01:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB792081B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 01:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="tyrB8N6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeLaBnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 20:43:40 -0500
Received: from cock.li ([185.100.85.212]:57868 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbeLaBnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 20:43:39 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546220614; bh=8G0Qy2DBv2GfoNiXCbIOTGN/1sHL73qWJsQhV8zX/7Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tyrB8N6Jt8rDfxglp0Pvxq8Bw3PXun3u/ikZk903soW5u8zeVpGqfAJ0bbGUblfxb
         5592UFEPmM2YZPWDp9uIUA5CkztJvlVYEUqbyM229kSuDalttEUYf7HunkzhuahZpV
         R3Hqut9mxTKxsUbugKuP8Qyz5YnQG1ab1aYPM6nZAYVeGq0l1tlffmKEuo7f/soJwG
         CCuDccGmjbysVuFFMpssYRGWndkTOlC9YF8cw85MC1zEYE2GJ6cK16L3T74jNRGQhU
         3dggvrCBOkjLbqhnHpb3NOD1EnVVDGr2tjhmo2EROzzs7irCZmVhh/EcLnEX06CeDD
         DBghaUxXkElRA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 31 Dec 2018 01:43:34 +0000
From:   vnsndalce@memeware.net
To:     R0b0t1 <r030t1@gmail.com>
Cc:     gentoo-user@lists.gentoo.org, ubuntu-users@lists.ubuntu.com,
        linux-kernel@vger.kernel.org, debian-user@lists.debian.org
Subject: Re: Thank you for your insight.
In-Reply-To: <CAAD4mYi572rWPcXZqw-5DGFDWKZQzBXVm=kUC4KsMqBBB8fZ1g@mail.gmail.com>
References: <25ffdaef51fc80ac49f3d54d5245cd87@memeware.net>
 <CAAD4mYi572rWPcXZqw-5DGFDWKZQzBXVm=kUC4KsMqBBB8fZ1g@mail.gmail.com>
Message-ID: <25caa529daa3b38efeed32cc7762cefc@memeware.net>
X-Sender: vnsndalce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's good that you got an opinion from an additional party.
The programmers swear they know better than I on this subject.

In a previous debate on the subject, the programmers decided that the
fact that they followed the license was "consideration", even though
without the permission from the grantor they have no right to
modify or redistribute the grantor's program to begin with.
I had to attempt to dispell that notion, informing them that the
permission to redistribute is a gratuity from the grantor,
the permission to modify the work is a gratuity from the grantor,
the permission to make derivative works is a gratuity from the grantor,
and the permission to redistribute derivative works is a gratuity from 
the grantor;
that they have no permission to do these things without the grantor,
They still believe it however and ignore me:

Their take is that if you lent (licensed) them a lawnmower and told them 
not to wreck it,
the fact that they did not wreck it entitles them to keep the lawnmower 
forever
(they followed your instruction regarding the use of your property: 
"thus consideration,
thus irrevocable license")

Previous writing:
--------------------------------

The permission to redistribute was simply given, gratis, by the grantor.

He asked for nothing in return, and, infact received nothing, not even a 
promise of compliance.

At a later date any of countless licensees might decide they wish make 
derivative works based upon the copyright-owner's property.

By law this is barred.

However the copyright holder here has magnanimously granted that the 
licensee is, contrary to the default rule, permitted to create and 
publish derivative works provided that they use the same license as the 
original work.

Here the copyright holder suffers a detriment. He is payed nothing for 
this forbearance (no consideration).

The licensee does not suffer a detriment: he had no right to make nor 
publish a derivative work to begin with.

The extending to him, of permission, is a pure gratuity.
He payed nothing for the change from "You may not create nor distribute 
derivative works" to "You may create and distribute derivative works 
under the same license as the original work".


--------------------------------
Context:
--------------------------------

https://news.slashdot.org/comments.pl?sid=12682608&cid=57401302
     Re: Straw Man (Score:0)
     by Anonymous Coward on Sunday September 30, 2018 @10:51PM 
(#57401302)

     GPL is a bare license.

     Don't agree?
     What consideration was given?
     Can't answer that? Don't know why it would matter?

     Why do you think it is a contract then?

--------------------------------

https://news.slashdot.org/comments.pl?sid=12682608&cid=57403506

	Re: Straw Man (Score:2)
	by drinkypoo ( 153816 ) <martin.espinoza@gmail.com> on Monday October 
01, 2018 @09:21AM (#57403506) Homepage Journal

	>What consideration was given?
	The right to redistribute was given in exchange for use of the license 
for one's own code. Something for something. What was your question 
again?


--------------------------------
https://news.slashdot.org/comments.pl?sid=12682608&cid=57408874


Re: Straw Man (Score:0)
by Anonymous Coward on Tuesday October 02, 2018 @12:58AM (#57408874)

Incorrect.

The permission to redistribute was simply given, gratis, by the grantor.

He asked for nothing in return, and, infact received nothing, not even a 
promise of compliance.

At a later date any of countless licensees might decide they wish make 
derivative works based upon the copyright-owner's property.

By law this is barred.

However the copyright holder here has magnanimously granted that the 
licensee is, contrary to the default rule, permitted to create and 
publish derivative works provided that they use the same license as the 
original work.

Here the copyright holder suffers a detriment. He is payed nothing for 
this forbearance (no consideration).

The licensee does not suffer a detriment: he had no right to make nor 
publish a derivative work to begin with.

The extending to him, of permission, is a pure gratuity.
He payed nothing for the change from "You may not create nor distribute 
derivative works" to "You may create and distribute derivative works 
under the same license as the original work".


On 2018-12-28 21:49, R0b0t1 wrote:
> Thank you for the response, though I feel you don't address my
> question. Happily though, I spoke with an acquaintance and it was
> determined that the subservience to the license (i.e. agreeing to be
> bound by the GPL2) could not be offered as consideration as its
> restrictions were not the licensee's to offer at the time of
> acceptance of the license. The licensee had no rights to offer as part
> of the contract, as the contract had not yet given them any rights to
> give up. The terms put forth by the GPL2 are only restrictions that
> are part of the license.
> 
> Furthermore, as stated above, it should seem quite self referential -
> I can't offer my acceptance of a license as consideration, because it
> is what I am trying to accept.
> 
> As I am sure you are aware, under US law there is no contract if both
> sides have not provided consideration. This leaves us in the strange
> place of gratis licenses being suggestions.
> 
> Cheers,
>     R0b0t1
> 
> On Fri, Dec 28, 2018 at 12:47 PM <vnsndalce@memeware.net> wrote:
>> 
>> Thank you for your insight.
>> 
>> It is a shame that there were no responses. They ignored your post, 
>> then
>> kept baying at me: "no this is wrong" "you're not a lawyer" "I will 
>> not
>> lower myself to refute you with arguments!".
>> 
>> As for non-monetary consideration to support an additional 
>> no-revocation
>> term:
>> Many of the old linux-kernel (programmer)rights-holders have received
>> nothing, and have made no such promise.
>> Many of the contributors (who did not transfer their rights) have
>> received nothing.
>> 
>> There is nothing to uphold the contention that they have forfeited 
>> their
>> default right to rescind license to their property.
>> They never made such a promise, they were never paid for such a 
>> promise,
>> they never contracted for such, etc.
>> 
>> They wrote code, licensed it gratuitously,
>> and now an attempt is being made to both control their speech, their
>> action, and to basically convert their property.
>> 
>> Most of the entities who have been licensed the works have neither 
>> paid
>> anything to the various rights-holders,
>> nor have they ever contacted nor been contacted by the various
>> rights-holders, etc.
>> 
