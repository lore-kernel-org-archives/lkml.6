Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABE0C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311D2206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=8chan.co header.i=@8chan.co header.b="hrIui3WT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311D2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=8chan.co
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeI1Xeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:34:44 -0400
Received: from cock.li ([185.100.85.212]:36958 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeI1Xen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:34:43 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8chan.co; s=mail;
        t=1538154599; bh=2+pV0E912BHmp4CzSkgZNjskHJWk8RcHLLkKZjdzZaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hrIui3WT3n5294XJcS8VmYNto0UizYvVQf75+WCbClubFyGryjXDvsXfI2/cMydj/
         SOrdeYeXXoNWoVD2xULTms/OmW8vZhzXrDSvYzvzKypSAn8ivjtlA6gvHmh+x/0Nba
         Xlt4LVGZZuKii07t4swbTSwH7AnlScVCTLLrF1navMaeCK4G2HVfrAmVVfK792ugWF
         ptPkPN4dwBWVS+ZEk7t7H7BJUU5lH/eTSvYL9oSDB2zVmWQjq6QBRQz3du+rWoFnL7
         34o/dChmlzJJpOUnj5vWGH476FzCrWM1MwVsPq78YjUA/ai2sqngvqx+Vum76A1cjw
         5017hnOg7LTpg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Sep 2018 17:09:58 +0000
From:   vwdfrwd@8chan.co
To:     Bruce Perens <bruce@perens.com>, linux-kernel@vger.kernel.org
Cc:     Taiidan@gmx.com, dng <dng@lists.dyne.org>, rms@gnu.org
Subject: Re: [DNG] Fwd: Re: Fwd: Re: GPL version 2 is a bare license. Recind.
 (Regarding (future) linux Code of Conduct Bannings).
In-Reply-To: <CAK2MWOs1fmd8bLpWLJah+5Ckyke7SMnM46w-iKx9dENpBe7M4g@mail.gmail.com>
References: <6b4a0cf6fa672938b8ab98acd1dea0a1@redchan.it>
 <BBFE2346-72C7-47D3-910A-DD720C7637DC@charter.net>
 <24cf6d6095c740903f16b56e22dd137c@redchan.it>
 <996c99ea4146a247730d87df14dfca1a@redchan.it>
 <E1g2TJn-0006lD-Lm@fencepost.gnu.org>
 <CAK2MWOssGczVO1Cd_SPVVb=ieCs2vkpFUfve9P3sh+gT1VfN7Q@mail.gmail.com>
 <4f926d0e5b96673926f3a4f163fdb590@redchan.it>
 <f3ac1e0424fed0fcbf782a6c9b1209a0@redchan.it>
 <20180919130952.2b2c23cc@mydesk.domain.cxm>
 <EF2143AF-4090-414E-B00B-EBF07361C741@getbackinthe.kitchen>
 <20180919213207.fx5ej6lopcdd7aft@katolaz.homeunix.net>
 <20180920144659.3598e2cb@mydesk.domain.cxm> <5BA3F750.3040908@signal100.com>
 <8bd5d183-6606-2f3d-4f66-fa918c8831f3@gmx.com>
 <CAK2MWOs1fmd8bLpWLJah+5Ckyke7SMnM46w-iKx9dENpBe7M4g@mail.gmail.com>
Message-ID: <515a3104d6089dab10a5cded37d1881f@8chan.co>
X-Sender: vwdfrwd@8chan.co
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would trade it all, to be-able to marry cute young girls (as allowed by 
YHWH (Devarim chapter 22, verse 28 (na'ar)) (also, obviously, in Sunni 
Islam (see 5th book of Bukhari)).

Banning men from having girl children as brides is the first thing you 
"SJW"s (aka "whites") did over 100 years ago.

And yes, Bruce Perens, we blaim you and yours for upholding said ban.

Thankfully Sunni muslims will be overtaking your countries soon.
They will lift the ban that you "whites" installed (in your reverent 
worship of women), God willing.

On 2018-09-27 21:11, Bruce Perens wrote:
> I'm that Social Justice Warrior that you don't like. And if you are
> using Devuan or Debian, if you've gotten a ham radio license since
> 2007, or if you're doing various Open Source things you have already
> benefited from things I've done in the name of social justice. So
> would you please be more careful about who you think is evil.
> 
> On Thu, Sep 27, 2018, 13:21 Taiidan@gmx.com <Taiidan@gmx.com> wrote:
> 
>> "Code of conduct" type policies are absolute bullshit meant to ruin
>> and
>> divide a community with conflict and strife.
>> 
>> I can't understand what has happened - perhaps "they" got to linus
>> somehow?
>> 
>> The people they want out are the ones who reject changes like rdrand
>> etc.
>> 
>> This is a plot to destroy linux and make it a corporate drone
>> project -
>> but hey after all I guess we aren't "ethical" enough like suicide
>> net
>> apple or killer drone software google so the cool kids are out to
>> get us.
>> 
>> The CoC snowflake types contribute nothing real and make absolutely
>> nothing innovative of course but yet somehow they always make the
>> rules?
>> what the hell? I bet they don't even use linux as their daily
>> driver.
>> 
>> We didn't vote to have a CoC it was forced on us like all these
>> changes.
>> 
>> Good things do not have to be forced on a community instead they are
>> voted for not shoved down our throats, a minority making the rules
>> for
>> the majority.
>> 
>> Female and minority coders plus community contributors such as
>> Joanna
>> Rutkowska who created qubes[1] and Leah Rowe who created
>> libreboot[2]
>> are both respectable and respected because they make real
>> contributions
>> to the world unlike the CoC jerks.
>> 
>> [1]Arguably the best security innovation and security operating
>> system
>> since the millennium.
>> 
>> [2]Leah kept the computing freedom movement going by spending 100K+
>> of
>> her own money on libre firmware ports for modern motherboards - I
>> also
>> believe without her bringing to life the kgpe-d16/kcma-d8 libre
>> firmware
>> ports there wouldn't have been a talos 2 either.
>> The end of owner controlled computing hardware was very, very
>> narrowly
>> averted thanks to them and a few others.
>> 
>> Note: I am always nice to people no matter their skin color,
>> political
>> leanings or who they want to date - I treat others as I wish to be
>> treated so I am not one of steve litt's hypothetical examples.
>> 
>> Hell how many of these SJW types have like to offer their seat on
>> the
>> bus/train to a tired non-white person because they too know what it
>> is
>> like to be tired and poor? zero.
>> 
>> They have cushy lives and invent fake problems because they do not
>> have
>> any real ones of their own to deal with.
>> _______________________________________________
>> Dng mailing list
>> Dng@lists.dyne.org
>> https://mailinglists.dyne.org/cgi-bin/mailman/listinfo/dng
> _______________________________________________
> Dng mailing list
> Dng@lists.dyne.org
> https://mailinglists.dyne.org/cgi-bin/mailman/listinfo/dng
