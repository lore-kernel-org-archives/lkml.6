Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C568ECDE47
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECBF20883
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECBF20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeJ0HTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:19:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:46096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbeJ0HTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:19:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0DEBAFC8;
        Fri, 26 Oct 2018 22:40:24 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Rainer Fiebig <jrf@mailbox.org>, linux-kernel@vger.kernel.org
Date:   Sat, 27 Oct 2018 09:40:13 +1100
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
In-Reply-To: <ffeb597c-9ca2-cf21-ba52-2146ab20c83a@mailbox.org>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <2341648.lzjnUGKk1z@siriux> <877ei56579.fsf@notabene.neil.brown.name> <ffeb597c-9ca2-cf21-ba52-2146ab20c83a@mailbox.org>
Message-ID: <87o9bg49iq.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26 2018, Rainer Fiebig wrote:

> NeilBrown schrieb:
>> On Thu, Oct 25 2018, Rainer Fiebig wrote:
>>=20
>>> Am Montag, 22. Oktober 2018, 08:20:11 schrieb NeilBrown:
>>>> On Sat, Oct 20 2018, Greg Kroah-Hartman wrote:
>>>>> Hi all,
>>>>>
>>>>> As everyone knows by now, we added a new Code of Conduct to the kernel
>>>>> tree a few weeks ago.
>>>>
>>>> I wanted to stay detached from all this, but as remaining (publicly)
>>>> silent might be seen (publicly) as acquiescing, I hereby declare that:
>>>>    I reject, as illegitimate, this Code and the process by
>>>>    which it is being "developed".
>>>>
>>>> It is clear from the surrounding discussions that this is well outside=
 our
>>>> core competencies.  It will be flawed, it isn't what we need.
>>>>
>>>> I call on any other community members who reject this process to say s=
o,
>>>> not to remain silent.
>>>> #Iobject
>>>>
>>>> We don't need a "Code of Conduct" nearly as much as we need "Leadership
>>>> in conduct".  Without the leadership, any code looks like a joke.
>>>>
>>> [...]
>>>=20=20
>>>> I call on you, Greg:
>>>>  - to abandon this divisive attempt to impose a "Code of Conduct"
>>>>  - to revert 8a104f8b5867c68
>>>
>>> Yes but this seems increasingly unlikely now. However, there may be an=
=20
>>> alternative.
>>>
>>> Jugding by the release-message for 4.19, some people here are fans of=20
>>> Monty Python's. No wonder - as those guys are famous for being unrelent=
ing=20
>>> supporters of Political Correctness.
>>>
>>> So one would be on the safe side if one just supplemented "Our Pledge"=
=20
>>> with this:
>>>
>>> 	"Everybody has the right to be offended."
>>>
>>> I think, John Cleese would also welcome this.[1]
>>>
>>> What do you think?
>>=20
>> I do think that giving certain rights to the community is a good thing:
>> - the right to tell anyone that their speech is hurtful
>> - the right to (patch) review by a third party.
>>=20
>> I don't think the right to be offended really needs to be given.
>> Yes, I know it is a joke and I do like Monty Python.  I just don't think
>> it is particular helpful in this context. Maybe I missed something.
>
> Of course it's a joke and iirc it was indeed John Cleese who made it. But=
 he
> made it for a reason, out of concern. It has a serious core.
>
> The question is: what *is* helpful in this matter?
>
> Just saying "this is not helpful" isn't helpful either. It's a well-known
> killer-phrase that has been used ad nauseam in this discussion. But an
> alternative is never given. And thus it's just an other way of saying
> "Eat it. And shut tf up!"

You asked me what I thought, and I told you what I thought.
If you think differently, you are quite welcome tell us - to explain the
way in which you think the addition would be helpful.

>
> Not even *constructive* criticism is helpful. AFAIK I'm the only one here=
 who
> came up with a *complete* alternative - ignored. Others provided patches =
for
> certain sections - ignored. Data that indicate that this may be detriment=
al to
> Linux - ignored. Almost anything that was provided by me or others - igno=
red.

From=20my perspective, providing a complete alternative is no better than
what Greg did - provided a "complete" "code of conduct".

Engage in discussion, present your case, make me *want* to read your
document because you've shown me how it relates to me.

>
> What kind of community or attitude is this? This feels more like "The Wal=
l" or
> North Korea than an Open-Source-project.
>
> And what beat everything was to misuse famously politically *in*correct M=
onty
> Python to malign criticism of this Political-Correctness-monster. The
> "People's Front" - message will forever be a prominent exhibit in "Monty
> Python's Hall of Shame". And the author should be banned from laughing ab=
out
> MP-sketches until he recants. Perhaps one should also report this inciden=
t to
> the "Ministry of Silly CoCs". ;)
>
>> For myself, I relinquish my right to be offended.  I just don't do it.
>> It doesn't seem to be worth the effort.
>
> I don't. John Cleese is a smart guy. And he has a point.
>
>
> OK, thanks for your reply! But I think it's time for me to move on. "Cut =
your
> losses", as they say.
>

Thanks for participating!

NeilBrown

>
> Good luck and regards!
>
> Rainer Fiebig

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvTl84ACgkQOeye3VZi
gblcag/9Go4SFL4hRCnJsYG2C9mJEaobtSUGXVznw4rL3SoZc6DJpI5zv6PnOPpC
kTZCuOSMOV9/G7OmeX/8hhzwlWIDcuJh1OJHFBVq+bEXY8DENzibWJ3gbS/uF5jK
M/Jd49aANEw4GfWC7uSqGIjGPjcfeJP3NjR76CEf8KMOb3F883FG/XlUYDJkpKn2
TpOrub77OlqA859Zowb7e+3wrto3bTocXEvpDgBhYtBkJIMxi3dN+Dc8EFlwxl0K
Pvl4sGhB1QiO9XwfYQmOZhob0Nw/06d7AheOFBeN2F/HwsD6WozuGyCf136596Dz
G337HVe0OePYLuHgsW9pIRVR/HtpI2oieFuJE4QePALvw68tefcVBqyf2CZBdpbk
4vtWMHH1yqGsV0o3UfFIBX0h9Ko4obN43kz3e1ETqe+ljcAs0cCUSUdUEITUX8Es
TwW7DBWOPm2wdMcTKzTUu+VHcrbY85bMwxV3XTUrEsFIfng26Thyo7OZhjqiCPNP
PBGPo31c4oFmWMnBj9vjVqzp3rlqhZMyDrvARWcluVfGFBX9ZAAViWdzwmfqeD6N
CmdvsEDHwHbP0WGjm32LPmNpD169gtu+nkcGA+/Q7eypTRmDGMAy8Gubz0/uFXE7
oO/4DIFjLP7Cpx4kk2BMVET5xwDZQHyB9V/+1VrFO0aGDbGdhe8=
=fGFO
-----END PGP SIGNATURE-----
--=-=-=--
