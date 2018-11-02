Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AD4C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFA52081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="l5AldFW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFA52081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeKBXAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:00:15 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34290 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbeKBXAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:00:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1DA938EE179;
        Fri,  2 Nov 2018 06:53:02 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H-vcvjj-KalF; Fri,  2 Nov 2018 06:53:01 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 593858EE0D4;
        Fri,  2 Nov 2018 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1541166781;
        bh=CQdFbfKMQcWbw4xtdPzbpvN4Q5nNZYWn2W8gMAs51xM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l5AldFW6H7Eb+O0obNvfMeQvmSSzQ/N1ysNW/Po8yq75Vcn+SpMq7tv/MQSUBmtMf
         TvxLMUQ2Dqmp9iGjfw20OPQTzq0Om6SzJbLsfvkG2N6eK5YzndqAzVS+nvo4fcw0gB
         hQXnwFswHNc0yeX1LgVp3ha4+gwtl8XvUw/jqbMU=
Message-ID: <1541166774.2872.3.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     NeilBrown <neil@brown.name>, paulmck@linux.ibm.com,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org
Date:   Fri, 02 Nov 2018 06:52:54 -0700
In-Reply-To: <8736sk31t8.fsf@notabene.neil.brown.name>
References: <20181020134908.GA32218@kroah.com>
         <87y3ar80ac.fsf@notabene.neil.brown.name>
         <20181021222608.GA24845@localhost>
         <875zxt919d.fsf@notabene.neil.brown.name>
         <20181024121622.GA10942@localhost>
         <87ftwt6850.fsf@notabene.neil.brown.name>
         <20181027011010.GA29769@localhost> <20181101164544.GA31540@linux.ibm.com>
         <8736sk31t8.fsf@notabene.neil.brown.name>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-o+fhgU9nAAKE//XmLa2T"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-o+fhgU9nAAKE//XmLa2T
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-11-02 at 08:50 +1100, NeilBrown wrote:
>  Firstly, you gave an analytical response to what was, in my view, an
>  emotional observation.  While I agree with your analysis, it is
> largely  irrelevant.  It is not how people *feel* about kernel
> development.
>=20
>  You say that the code of conflict is gone, but in fact much of it is
>  preserved in the code-of-conduct-interpretation.  If you reflect on
> the  focus of the second para of that document (which I think was
> directly  lifted from the code-of-conflict) you will see that value
> is placed  squarely on the code (kernel code, not code of
> conduct).  The code is  put forward as the thing of primary
> importance.  People (you, me) are  only mentioned in the context of
> being the authors of code that will be  criticised  - because (it
> almost says this) we care about the code, but not about you.
>=20
>  So I think it is beyond argument that the value system presented by
>  this paragraph is
>       code > people

Actually, I think this whole code vs people debate is a straw man and
inherently inimical to the discussion. In neither code of conduct (old
or new) is there any statement that allows one to make a value judgment
of people relative to code, so the very premise you're all arguing on
doesn't exist.

The two separate, but related statements present in both systems are
that the technical quality of the code going into the kernel is
paramount and that we should try to be respectful of others in email or
other interactions including code reviews.  Code and people aren't
opposites: you can give purely technical reviews with a laser like
focus on quality and still do it respectfully.  Or to put it another
way: respecting code doesn't automatically mean you disrespect people,
which seems to be what the '>' was implying.

James


--=-o+fhgU9nAAKE//XmLa2T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCW9xWtgAKCRDnQslM7pis
hZl5AQC54rjxAIANJzDTSEJBn+6ONqPcii7UXCrljm/L+5SULQD9HMYRr4SfzmPm
VvLOoLP+HF9I/3n7AJbqLiXhcJ2GMoo=
=aR4x
-----END PGP SIGNATURE-----

--=-o+fhgU9nAAKE//XmLa2T--

