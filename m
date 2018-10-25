Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9D3C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DD9207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DD9207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeJZGwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:52:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:34492 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbeJZGwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:52:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C1A6B0A0;
        Thu, 25 Oct 2018 22:18:26 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Rainer Fiebig <jrf@mailbox.org>, linux-kernel@vger.kernel.org
Date:   Fri, 26 Oct 2018 09:18:18 +1100
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
Subject: Re: Call to Action Re: [PATCH 0/7] Code of Conduct: Fix some wording, and add an interpretation document
In-Reply-To: <2341648.lzjnUGKk1z@siriux>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <2341648.lzjnUGKk1z@siriux>
Message-ID: <877ei56579.fsf@notabene.neil.brown.name>
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

On Thu, Oct 25 2018, Rainer Fiebig wrote:

> Am Montag, 22. Oktober 2018, 08:20:11 schrieb NeilBrown:
>> On Sat, Oct 20 2018, Greg Kroah-Hartman wrote:
>> > Hi all,
>> >=20
>> > As everyone knows by now, we added a new Code of Conduct to the kernel
>> > tree a few weeks ago.
>>=20
>> I wanted to stay detached from all this, but as remaining (publicly)
>> silent might be seen (publicly) as acquiescing, I hereby declare that:
>>    I reject, as illegitimate, this Code and the process by
>>    which it is being "developed".
>>=20
>> It is clear from the surrounding discussions that this is well outside o=
ur
>> core competencies.  It will be flawed, it isn't what we need.
>>=20
>> I call on any other community members who reject this process to say so,
>> not to remain silent.
>> #Iobject
>>=20
>> We don't need a "Code of Conduct" nearly as much as we need "Leadership
>> in conduct".  Without the leadership, any code looks like a joke.
>>=20
> [...]
>=20=20
>> I call on you, Greg:
>>  - to abandon this divisive attempt to impose a "Code of Conduct"
>>  - to revert 8a104f8b5867c68
>
> Yes but this seems increasingly unlikely now. However, there may be an=20
> alternative.
>
> Jugding by the release-message for 4.19, some people here are fans of=20
> Monty Python's. No wonder - as those guys are famous for being unrelentin=
g=20
> supporters of Political Correctness.
>
> So one would be on the safe side if one just supplemented "Our Pledge"=20
> with this:
>
> 	"Everybody has the right to be offended."
>
> I think, John Cleese would also welcome this.[1]
>
> What do you think?

I do think that giving certain rights to the community is a good thing:
=2D the right to tell anyone that their speech is hurtful
=2D the right to (patch) review by a third party.

I don't think the right to be offended really needs to be given.
Yes, I know it is a joke and I do like Monty Python.  I just don't think
it is particular helpful in this context. Maybe I missed something.
For myself, I relinquish my right to be offended.  I just don't do it.
It doesn't seem to be worth the effort.

Thanks,
NeilBrown


>
> Regards!
>
>
> Rainer Fiebig
>
>
>
> [1] https://www.dailymail.co.uk/news/article-3427218/Political-correctnes=
s-killing-comedy-says-John-Cleese-Monty-Python-star-believes-fear-offending=
-certain-groups-lead-1984-style-society-free-expression-not-allowed.html
>
>
> --=20
> The truth always turns out to be simpler than you thought.
> Richard Feynman

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvSQSsACgkQOeye3VZi
gbkGZw/+Kb+EyDzG/rh08Umewq+93IV7ewkPFBvgyZBER+YtHB4q3JreNPYM/R68
nbKd0QjJlVPZvQY9x7Wqh3mfWYNqeu+QH5s9IYXtg8NVilcUqZfFknsoO+opRZMW
7jeD4GkMFGpudXMkxujqKweB/d1m4ZjyTH0FSRfrssDs6WZpu5oRlRFaujU/8fwM
rqMbi97Vbw9tbQyh27JWh31obfcrh6Ma7kXZ3jaj54g7pJcALeS5r09ZW4EqZHJs
1weVtysv/fu8GthnmH9/aOWA3kkSUCy/RDcN4xC2MIi4anY4U0WBtPsb1iXzOdLV
+IRMY0It3gUS8Ak/rPDYgjJvyxP9tjmelWAEFk6NcQ6LfzCLMHYQU6xyf5aO+zid
VbX+LFrffmnVv7PdUOHujStmyGMWKSXE22c/1GNfk+yFOVOe+CQLpQaNFEQOB79Y
qZC9wt/mVBmsicRiloOCrBUlGInavvSk4gjimO2JXI2nCnIrEYmXAJrg85G6j1vF
70KlEa4FnTEEcHVnRR3lTAESWwpzOh9+L3kU1fqWpwf6+dNsp+A6iucB/+byQMQr
ioSNQolgL6bG61b3AlnXOhFhXhEbuftQig7OBS7LchkURHS7/HcivO7KTm9gN2JT
CY9/BQ/nhHL5uJnY7pl6zM/1HSHw6YEwyhFIQRrZ3QabcWRF9oE=
=NK6q
-----END PGP SIGNATURE-----
--=-=-=--
