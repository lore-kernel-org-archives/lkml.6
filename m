Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74310C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1671D2082B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1671D2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeJ2F7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 01:59:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:40498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727631AbeJ2F7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 01:59:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE152ACC1;
        Sun, 28 Oct 2018 21:13:49 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Jiri Kosina <jikos@kernel.org>, Tim.Bird@sony.com
Date:   Mon, 29 Oct 2018 08:13:36 +1100
Cc:     viro@ZenIV.linux.org.uk, visionsofalice@redchan.it,
        linux-kernel-owner@vger.kernel.org, rms@gnu.org,
        ksummit-discuss@lists.linuxfoundation.org, mishi@linux.com,
        gregkh@linuxfoundation.org, bruce@perens.com,
        linux-kernel@vger.kernel.org, esr@thyrsus.com, moglen@columbia.edu,
        bkuhn@sfconservancy.org, editor@lwn.net
Subject: Re: [Ksummit-discuss] The linux devs can rescind their license grant.
In-Reply-To: <nycvar.YFH.7.76.1810280000440.23511@cbobk.fhfr.pm>
References: <20181020134908.GA32218@kroah.com> <87y3ar80ac.fsf@notabene.neil.brown.name> <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com> <185b786a2bd6e8d527dca161dc42e4f1@redchan.it> <20181025081911.GB11343@kroah.com> <20181025193901.GD26403@thyrsus.com> <20181025204718.GB25649@thunk.org> <20181025214123.GA2448@thyrsus.com> <20181025230656.GJ32577@ZenIV.linux.org.uk> <75eb4a46c8a2c1d4a927760fd1f2009d@redchan.it> <20181027073241.GM32577@ZenIV.linux.org.uk> <ECADFF3FD767C149AD96A924E7EA6EAF88A2A727@USCULXMSG01.am.sony.com> <nycvar.YFH.7.76.1810280000440.23511@cbobk.fhfr.pm>
Message-ID: <875zxl4vwf.fsf@notabene.neil.brown.name>
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

On Sun, Oct 28 2018, Jiri Kosina wrote:

> On Sat, 27 Oct 2018, Tim.Bird@sony.com wrote:
>
>> Al,
>>
>> Can you please, even in the face of comments you find irritating, keep=20
>> your responses more civil?  Calling someone a "wankstain" is=20
>> unprofessional
>
> Tim,
>
> to be completely honest, communicating anonymously doesn't really match m=
y=20
> "this is highly professional" standards either, so I don't think we shoul=
d=20
> be losing too much sleep over this particular e-mail exchange.

I agree with Tim here.  It doesn't really matter who (or what) you are
talking to, what matters is the context in which you are talking.

We seem to be trying to raise the standard of communication within the
kernel community.  That means all communication.

>
> CoC explicitly requires us to be reasonably nice to the human being on th=
e=20
> other end of the wire, which I whole-heartedly believe is a very noble an=
d=20
> nice goal. But you really have to know at least a little bit who's there=
=20
> on the other end. Otherwise failure to communicate might be sort of=20
> inevitable.

As you know, I think the CoC is a mistake and should be removed.
But seeing you to play that game:
1/ code-of-conduct.rst doesn't contain the word "human" at all
2/ code-of-conduect-interpretation.rst explicitly says
    We know everyone is human
  which could be read as implying that you need to treat the other
  person as human, even if they don't act that way.

Do you *really* want to use the CoC to support your position?

Thanks,
NeilBrown


>
> --=20
> Jiri Kosina
> SUSE Labs

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvWJoAACgkQOeye3VZi
gbnOlw/+Jnt1F2qwTPMOymyGTFA3OvodaGar0e7GlOk1rdKj3GElMzNvy8w1c0WJ
gblwf39Xzaczrhv6fFtd+I7F6SvvCJxC9HgcN2x45wWnqL3dC3jtpJxUDjH7i15f
PoV9OprAK5l5YY8EHw3chjgvLZxGrn0Iklqz+CF9WIm52L47ZRDPRlspoHfQDrT8
jIEF5KVwgc85kIuL8/Jp4lXAJ9ESUWUOBVUmRYQPSbWG8rZnUSvkqVy3mXd4ar1c
lMsD8+naIjWtxsMRHFu4PhF2ium2YiIonq0q4Hurx0oGS0eEYIeIa0YLXig5Eh1Z
BhYgy2tkF84kmcBFGawnHdn0QW+nvD45rKWWIWRu3KsTgmxXTtpm+7+MJoSbqCRe
di6c+Siejh5ZDF6zNCZUI8XE6dUWobxa1rMX96d4S0bliMplnwRdRqav5g9V0HS1
PEQTZP/wnI6mBOKNRXuZiVn6K3O+mJb/ieb4yIUTLXJlWr0lqI77n40zMD0B4HLW
0LC7W2TC/d7H8EzU4lfNOAn/punwJstnYuevKx3Sq/6tvZnJurjdFvugyt/FVKGS
whazqEDBljSkm0NqQ5EfwJr3P0xDkLbM3Su8idrObiZvE73nfiVrRB2qVcZSfUoo
5tBIIWum+UzbyyU4dzuetm1GRbylyMfImRdGtYkU65kSSrAj+r0=
=KWZW
-----END PGP SIGNATURE-----
--=-=-=--
