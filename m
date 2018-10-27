Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCD9ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3A820856
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="U48nQj3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3A820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeJ0U2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 16:28:39 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:35140 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbeJ0U2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 16:28:38 -0400
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 5949BA0D15;
        Sat, 27 Oct 2018 13:47:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-type:content-type:in-reply-to:mime-version:date:date
        :message-id:from:from:references:subject:subject:received; s=
        mail20150812; t=1540640872; bh=fcg+MGLgghCST0GdOO/VbII7TkXHMrV/n
        RZjf0HOREg=; b=U48nQj3cGXcfNemWtdGS0Wi7b66IHjqD6v/hJr1PZBNA9ZKpJ
        ZIJ9OPf70cYbRXkZPx/baMufOOMvpmUGv+H302/SlwvsMDRHStLjxEUZOSFzJcpJ
        Is4VCT7notq2tucsPPzcu4ozPYJ/Yk1NBXmaLo79pAi+wIJDqY+00g94yKxQJZsX
        vsMSwm65bgXFrCeoYYGxVuY6h9rWXyGn6kYZDhoIkwcvnlqqiuBdltuXbQlKRLiG
        r0s02GctnqnoGMfu2kaeFLSTTqKGedv1WSyNv4v3Ec9c2EvFUqwF4p11L1qu2Bhp
        PV1UZDBDD7MLINfernfrpu8ZWAxBy3Oh+C8Qw==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 67sKcXR70A6S; Sat, 27 Oct 2018 13:47:52 +0200 (CEST)
Subject: Re: Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording,
 and add an interpretation document
To:     NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name> <2341648.lzjnUGKk1z@siriux>
 <877ei56579.fsf@notabene.neil.brown.name>
 <ffeb597c-9ca2-cf21-ba52-2146ab20c83a@mailbox.org>
 <87o9bg49iq.fsf@notabene.neil.brown.name>
From:   Rainer Fiebig <jrf@mailbox.org>
Openpgp: preference=signencrypt
Autocrypt: addr=jrf@mailbox.org; keydata=
 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
 6/dT7HxuwnVIkER8kg==
Message-ID: <ef5f0e6a-dc42-b203-995e-5b203ea71587@mailbox.org>
Date:   Sat, 27 Oct 2018 13:49:04 +0200
MIME-Version: 1.0
In-Reply-To: <87o9bg49iq.fsf@notabene.neil.brown.name>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qKZk7D2LxwaGCcH8fv3VTr4Wbv9377x4n"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qKZk7D2LxwaGCcH8fv3VTr4Wbv9377x4n
Content-Type: multipart/mixed; boundary="Mk0myVvM6hzoupVsATLwiqXAkD0odKHMl";
 protected-headers="v1"
From: Rainer Fiebig <jrf@mailbox.org>
To: NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ksummit-discuss@lists.linuxfoundation.org,
 Thomas Gleixner <tglx@linutronix.de>, Olof Johansson <olof@lixom.net>,
 Chris Mason <clm@fb.com>, Mishi Choudhary <mishi@linux.com>
Message-ID: <ef5f0e6a-dc42-b203-995e-5b203ea71587@mailbox.org>
Subject: Re: Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording,
 and add an interpretation document
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name> <2341648.lzjnUGKk1z@siriux>
 <877ei56579.fsf@notabene.neil.brown.name>
 <ffeb597c-9ca2-cf21-ba52-2146ab20c83a@mailbox.org>
 <87o9bg49iq.fsf@notabene.neil.brown.name>
In-Reply-To: <87o9bg49iq.fsf@notabene.neil.brown.name>

--Mk0myVvM6hzoupVsATLwiqXAkD0odKHMl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

NeilBrown schrieb:
> On Fri, Oct 26 2018, Rainer Fiebig wrote:
>=20
>> NeilBrown schrieb:
>>> On Thu, Oct 25 2018, Rainer Fiebig wrote:
>>>
>>>> Am Montag, 22. Oktober 2018, 08:20:11 schrieb NeilBrown:
>>>>> On Sat, Oct 20 2018, Greg Kroah-Hartman wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> As everyone knows by now, we added a new Code of Conduct to the ke=
rnel
>>>>>> tree a few weeks ago.
>>>>>
>>>>> I wanted to stay detached from all this, but as remaining (publicly=
)
>>>>> silent might be seen (publicly) as acquiescing, I hereby declare th=
at:
>>>>>    I reject, as illegitimate, this Code and the process by
>>>>>    which it is being "developed".
>>>>>
>>>>> It is clear from the surrounding discussions that this is well outs=
ide our
>>>>> core competencies.  It will be flawed, it isn't what we need.
>>>>>
>>>>> I call on any other community members who reject this process to sa=
y so,
>>>>> not to remain silent.
>>>>> #Iobject
>>>>>
>>>>> We don't need a "Code of Conduct" nearly as much as we need "Leader=
ship
>>>>> in conduct".  Without the leadership, any code looks like a joke.
>>>>>
>>>> [...]
>>>> =20
>>>>> I call on you, Greg:
>>>>>  - to abandon this divisive attempt to impose a "Code of Conduct"
>>>>>  - to revert 8a104f8b5867c68
>>>>
>>>> Yes but this seems increasingly unlikely now. However, there may be =
an=20
>>>> alternative.
>>>>
>>>> Jugding by the release-message for 4.19, some people here are fans o=
f=20
>>>> Monty Python's. No wonder - as those guys are famous for being unrel=
enting=20
>>>> supporters of Political Correctness.
>>>>
>>>> So one would be on the safe side if one just supplemented "Our Pledg=
e"=20
>>>> with this:
>>>>
>>>> 	"Everybody has the right to be offended."
>>>>
>>>> I think, John Cleese would also welcome this.[1]
>>>>
>>>> What do you think?
>>>
>>> I do think that giving certain rights to the community is a good thin=
g:
>>> - the right to tell anyone that their speech is hurtful
>>> - the right to (patch) review by a third party.
>>>
>>> I don't think the right to be offended really needs to be given.
>>> Yes, I know it is a joke and I do like Monty Python.  I just don't th=
ink
>>> it is particular helpful in this context. Maybe I missed something.
>>
>> Of course it's a joke and iirc it was indeed John Cleese who made it. =
But he
>> made it for a reason, out of concern. It has a serious core.
>>
>> The question is: what *is* helpful in this matter?
>>
>> Just saying "this is not helpful" isn't helpful either. It's a well-kn=
own
>> killer-phrase that has been used ad nauseam in this discussion. But an=

>> alternative is never given. And thus it's just an other way of saying
>> "Eat it. And shut tf up!"
>=20
> You asked me what I thought, and I told you what I thought.
> If you think differently, you are quite welcome tell us - to explain th=
e
> way in which you think the addition would be helpful.
>=20

Neil, this is probably a misunderstanding. I really value your initiative=
 and
dedication in this matter.

My suggestion of adding the "right to be offended" was of course just a
sarcastic joke. I thought this was obvious, especially since I provided t=
he
link to the interview with John Cleese. But it wasn't obvious to you
and I'm sorry for that.

BTW - it just strikes me: perhaps this endless enumeration of
protected/privileged classes was also just a joke and *I* didn't see it? =
;)

OK. "Not helpful":
This is indeed a killer-phrase used to suppress critique and to silence
people. I just wanted to expose this.

It was not directed at *you*. That's why I began my critique with
>> "The question is: what *is* helpful in this matter?"

>>
>> Not even *constructive* criticism is helpful. AFAIK I'm the only one h=
ere who
>> came up with a *complete* alternative - ignored. Others provided patch=
es for
>> certain sections - ignored. Data that indicate that this may be detrim=
ental to
>> Linux - ignored. Almost anything that was provided by me or others - i=
gnored.
>=20
> From my perspective, providing a complete alternative is no better than=

> what Greg did - provided a "complete" "code of conduct".
>=20

I think in your message of 10/21/18 you asked for it:
"What is the document that you would have liked to have read as you were
starting out? [...]"

In my reply I also made it clear that my suggestion was just intended as =
an
example that *of course* would have to be discussed:
"On the day the patch came out, I started working on a modified version,
a CoC that I could have lived with. [...].

So please find below what I would have submitted for discussion."

And if that's not *constructive* criticism, I don't know what is.

> Engage in discussion, present your case, make me *want* to read your
> document because you've shown me how it relates to me.
>=20

I think, I engaged in this discussion earlier than you did. My first post=
 was
on 10/09/18.

And I have already presented my case several times, including examples fo=
r why
I'm opposed to this CoC, concrete proposals for modification and some dat=
a
that show that it may be detrimental to Linux. I also suggested to revert=
 the
patch, set up a task-force to come up with an alternate CoC, discuss it e=
tc.
And all of this early enough.

There's no point in repeating it. So - what else could I do?

And why should you *want* to read my document? I don't know. Perhaps beca=
use
you asked for it? Or to get some ideas how the same can be achieved witho=
ut a
political sting? Up to you.

But I will definitely no longer participate in this discussion unless the=
re
are clear indications by those who introduced this stuff that a discussio=
n
is appreciated and its outcome may lead to changes in the CoC.

Because else I know of better ways to waste my time. ;)


Kind regards - and have a good weekend!


Rainer Fiebig


>>
>> What kind of community or attitude is this? This feels more like "The =
Wall" or
>> North Korea than an Open-Source-project.
>>
>> And what beat everything was to misuse famously politically *in*correc=
t Monty
>> Python to malign criticism of this Political-Correctness-monster. The
>> "People's Front" - message will forever be a prominent exhibit in "Mon=
ty
>> Python's Hall of Shame". And the author should be banned from laughing=
 about
>> MP-sketches until he recants. Perhaps one should also report this inci=
dent to
>> the "Ministry of Silly CoCs". ;)
>>
>>> For myself, I relinquish my right to be offended.  I just don't do it=
=2E
>>> It doesn't seem to be worth the effort.
>>
>> I don't. John Cleese is a smart guy. And he has a point.
>>
>>
>> OK, thanks for your reply! But I think it's time for me to move on. "C=
ut your
>> losses", as they say.
>>
>=20
> Thanks for participating!
>=20
> NeilBrown
>=20
>>
>> Good luck and regards!
>>
>> Rainer Fiebig



--Mk0myVvM6hzoupVsATLwiqXAkD0odKHMl--

--qKZk7D2LxwaGCcH8fv3VTr4Wbv9377x4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6yx5PjBNuGB2qJXG8OH3JiWK+PUFAlvUULEACgkQ8OH3JiWK
+PXGXxAAznChUeYf9wZAjvvaOHYhDPf/pu5gXU93HJRbZnb4IwL2kuOjBNnHWYca
F9Ng30cFaKOUZ4rq0auTyMIc8oD5cD85pwzakrw8cffiBrP0nmdZaFbCA005z4+Q
oT/LKbXHfDy33ikPBAUJACRrkDcz0TU1KyLKRpQa3QoiP2FlNp9NOGNJE1IGhQpA
4olq4KbwPlmhl3FSBYdno/+wqe5B2iDBm3lntBBKNHK4L0UNTSIDZKx4P85RGR0W
q0eAknyqDXJwCPF+Dwdsn5qE4CDsQFmU1I/yuBOYjMaZKUk17RH5h6iWPBYRuBng
xQZAjH3nVBU2Q090f50nfJvtYNedLtCVWEc8bC60EaCk0Naksh8afS+QkzVnrPug
GY517sfFcV+RdPKFRINAfCvfE5qTD2ZZOvfYQt1r7RvFUlusAlKsiZCRJhhrXFyq
jIzOfUcjmIvz5Hw/RXj9wp4/870yr8VqcKdTzQoaGIViSDtuy65Q4OPCE4NPkVgA
6cYOx367ONyOUqW7Kt6HsvTME9QdSJ8yOQGBOiW5PB75ikvyk/pv0e3A8xdr8VLm
M+peug6MN3WefgK1uuCd+DDFuwA8DMM8w178TVzmv2bP/BvlIOUIHWfqbowCXTp3
roeCY4fGHaD4tFwcPdvft2oG9z/y3QgzU088L7EJ2/+S3vNHJLU=
=Lsep
-----END PGP SIGNATURE-----

--qKZk7D2LxwaGCcH8fv3VTr4Wbv9377x4n--
