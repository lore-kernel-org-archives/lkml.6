Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09FBECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 09:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963DB20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 09:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963DB20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thyrsus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeKCSaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 14:30:46 -0400
Received: from thyrsus.com ([71.162.243.5]:50196 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbeKCSaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 14:30:46 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id A46383A42A6; Sat,  3 Nov 2018 05:19:19 -0400 (EDT)
Date:   Sat, 3 Nov 2018 05:19:19 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     NeilBrown <neil@brown.name>, paulmck@linux.ibm.com,
        Josh Triplett <josh@joshtriplett.org>,
        Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
Message-ID: <20181103091919.GA20463@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        NeilBrown <neil@brown.name>, paulmck@linux.ibm.com,
        Josh Triplett <josh@joshtriplett.org>,
        Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <20181021222608.GA24845@localhost>
 <875zxt919d.fsf@notabene.neil.brown.name>
 <20181024121622.GA10942@localhost>
 <87ftwt6850.fsf@notabene.neil.brown.name>
 <20181027011010.GA29769@localhost>
 <20181101164544.GA31540@linux.ibm.com>
 <8736sk31t8.fsf@notabene.neil.brown.name>
 <1541166774.2872.3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <1541166774.2872.3.camel@HansenPartnership.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

James Bottomley <James.Bottomley@HansenPartnership.com>:
> Actually, I think this whole code vs people debate is a straw man and
> inherently inimical to the discussion. In neither code of conduct (old
> or new) is there any statement that allows one to make a value judgment
> of people relative to code, so the very premise you're all arguing on
> doesn't exist.

The author's original version of the new CoC is, however, associated
with (and intended by its author to implement) "The Post-Meritocracy
Manifesto".

https://postmeritocracy.org/

Do you think it's a stretch to see "people > code" in that?
--=20
		<a href=3D"http://www.catb.org/~esr/">Eric S. Raymond</a>

My work is funded by the Internet Civil Engineering Institute: https://icei=
=2Eorg
Please visit their site and donate: the civilization you save might be your=
 own.



--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQYdrL1eUY6SZhD0d7Mggj4xsc40FAlvdZ/gACgkQ7Mggj4xs
c41VDRAAmImnyXKPIoIG9hQyy7Ud04vJXd83Um51hFnCXXURlUfz/j4h4UxC+qj7
+r+ii4514bJP2+W6w3uDKD0oho35jKe7NmV8OAYruC6jLYolCrQkll3glotD/2uI
6fy9PpigvbAzd9ltp1iazyi4KxN6K6QikDDGtD97k26LdixhbUtb+ZGhYgnkRsTD
0vtwMB7le6d2qS74uApdIcfqG7wgPsJ5LD9siVWgW7ZmBT8B2U/sIaYQI0sFCHQu
nMD2p+sGE45VxEaJsqZsQKruaGRV1b46uS45j7MSsmolGHyiflODv+PnymSNRCID
9b2CdzUZ3FgfY7tMjvig83mOk18wgBOtw9x1HpgeZRKxpief7s2U/3bQOv5xoizL
pbygwgy197kwNCiu0g2w0TbapYB6UJXW5VSDpxW5sGzprM1O8r3g24lQAfTwT1uX
p7j7KyMpfFenfrt6Qam8vKmaOCTst+dmvFZDX2IusO9LyanF+1wDIuQq8XRHX59c
EuBKG/1I8PLp4YPrV8rTLURU7Ci+8jSzWJpOwIvL63veq89Y7U32TCROqoIyouqz
yvxEAz8/q8toIPWqq49K5MB+BB9hPTq0M5J9dnyDhkisLtcI3yNU5MnceiSRm+0Z
cNUma+ECpZ89g51whoLauhN3Kz4U9ijBd+3A3SO/yIDNesZf3Gw=
=ut+0
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
