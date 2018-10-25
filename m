Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2142DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F602082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F602082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thyrsus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeJZHN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:13:26 -0400
Received: from thyrsus.com ([71.162.243.5]:54056 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbeJZHN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:13:26 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id D49363A42A3; Thu, 25 Oct 2018 18:38:13 -0400 (EDT)
Date:   Thu, 25 Oct 2018 18:38:13 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     NeilBrown <neil@brown.name>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        visionsofalice@redchan.it,
        linux-kernel <linux-kernel@vger.kernel.org>, rms@gnu.org,
        bruce@perens.com, moglen@columbia.edu, bkuhn@sfconservancy.org,
        editor@lwn.net, Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: The linux devs can rescind their license grant.
Message-ID: <20181025223813.GA5137@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com, NeilBrown <neil@brown.name>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        visionsofalice@redchan.it,
        linux-kernel <linux-kernel@vger.kernel.org>, rms@gnu.org,
        bruce@perens.com, moglen@columbia.edu, bkuhn@sfconservancy.org,
        editor@lwn.net, Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>,
        linux-kernel-owner@vger.kernel.org
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
 <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
 <20181025081911.GB11343@kroah.com>
 <20181025193901.GD26403@thyrsus.com>
 <20181025204718.GB25649@thunk.org>
 <20181025214123.GA2448@thyrsus.com>
 <87a7n165h6.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <87a7n165h6.fsf@notabene.neil.brown.name>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

NeilBrown <neil@brown.name>:
> I think you are blurring two groups here.
> Ted describes "anti-CoC dissidents" as people who are advancing an
> argument about rescinding their license.  This is a smaller groups than
> the "ant-CoC camp" who don't really like the CoC.  I suspect is it is a
> much smaller group when restricting to actual copyright holders.

You may be right that these are semi-distinct groups.  I don't think
the distinction makes a lot of difference to my argument, though.
Either way, (a) there's been a process failure by the leadership, and
(b) the threat of a massive legal disruption is real.

> I am against the CoC as it stands, but rescinding any license is such an
> enormous over-reaction, I find the concept laughable.

I'm...not sure I do.  I was going to agree with you that it's a
massive overreaction, but then a simple question occurred to me: what
else could *I* do if I thought I had a significant stake (I don't; my
kernel contributions are minor and old) and felt my interests were
damaged?

All this could have been avoided so easily. A felt need for a new Code
should not have been followed by the immediate imposition of one,
but by a public RFC process and consensus-building - a process in which
even those who lost arguments about the construction of the code could
know they had been heard.
--=20
		<a href=3D"http://www.catb.org/~esr/">Eric S. Raymond</a>

My work is funded by the Internet Civil Engineering Institute: https://icei=
=2Eorg
Please visit their site and donate: the civilization you save might be your=
 own.



--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQYdrL1eUY6SZhD0d7Mggj4xsc40FAlvSRa4ACgkQ7Mggj4xs
c43iFQ/8CDP9fUnEx+GLzWV1OCAzWyDQeasjjdzTmF0fktF6Om3SdXV6OpvAmQ/a
HF1561bPud0VPJyber05dHVrlOp1Y7Mj4bu4hnu0bPsiK4WrPDEhhX4d2vhsgOrk
K85J6adAYx1La6Sl14BBdbxtuWk+rDel2G93Aca+LnDMmibd6RhZOh38dvXsJ1d/
ngpdhB6sDAGGyq6d1fvAF7X2/I5l5bw/CSVH/Fxj0x2fAkSOvVugPXYNPmPwl9ab
Dx8S/CWzqzwIHSJDI/pA5rNP+0Ym2TZi+5ugwrlr2zsyc1mMmiMFtaoLC+6a7Dzd
YZ188kBLGmgJfrXjCvlBRIuGiU8W4+5qUB0y/1QiWYIO0mN6iFVxmDKRanJhUPLs
16tzELN5NN2BmcqcA7q3yhqmke7Q6enB3eZaF7Y7u4442lTzI92LwCi/wg4KuBTZ
x9jDT4HVnOF64qXY2I7NFRZlEl0hJIdHfZ8bj+HuOWH+7neIxqi3UNyhPH/mLbgE
oTE1U3JSZmtsz7u2SyaDwhjeYW2TnnWCGZblZUOHRKTky5x4NfHBq+6DzjdTQO+i
m4xpTIcPxYRqY4PDdMqsM1l1WGUWoJdy1UzbwlXKkFbvFQ2yZh1KRtQrSPhMW4QA
HKs94nSBSawuhfT3ws60bcXXywKrGwxEcmvupK54+lpChBjKhQ8=
=9rIp
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
