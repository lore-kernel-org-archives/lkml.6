Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDFCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623302184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (768-bit key) header.d=jasper.es header.i=@jasper.es header.b="B6/SneqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeLRVyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:54:02 -0500
Received: from do-db2.lkml.org ([188.166.10.231]:47065 "EHLO squeeze.vs19.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeLRVyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:54:01 -0500
X-Greylist: delayed 2051 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Dec 2018 16:54:00 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jasper.es;
         s=x; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        To:From:Date:Resent-To:Resent-Message-ID:Resent-Date:Resent-From:Sender:
        Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Sender:Resent-Cc:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=d206OrxF+u8874eg90nHBcAujJmermbVvFP2cYeWMKA=; b=B6/SneqJpA3uXMhLwCL80S1jSg
        dPQPV395rbENJ0fel8hTXuTpxHKPy0mttAsJQ+vpl+vRSs1/3Xn7IebtaA79PonjYtxW86P7FCa8m
        NzrFJOMNinu7KviAaJKyiPVq/;
Received: from [::ffff:83.85.49.179] (helo=jasper.es)
        by squeeze.vs19.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <spaans@jasper.es>)
        id 1gZMlh-0003mE-0w; Tue, 18 Dec 2018 22:19:16 +0100
Received: from [::ffff:83.85.49.179] (helo=gpg)
        by squeeze.vs19.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <j@jasper.es>)
        id 1gZMXa-0003je-Kd
        for j@jasper.es; Tue, 18 Dec 2018 22:04:35 +0100
Received: from spaans by gpg with local (Exim 4.89)
        (envelope-from <j@jasper.es>)
        id 1gZLwh-0000O2-TQ; Tue, 18 Dec 2018 21:26:32 +0100
Date:   Tue, 18 Dec 2018 21:26:27 +0100
From:   Jasper Spaans <j@jasper.es>
To:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] LKML Archive in Maildir Format
Message-ID: <20181218202627.j6d2jgxercylclpc@jasper.es>
References: <20181216190639.6safwjqwdphkce67@gmail.com>
 <c7865616af2eab80f5e5a4cf756ba430f2293499.camel@perches.com>
 <20181216192135.hc7gykmwkfgil2j5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nugofhd7rie23n2q"
Content-Disposition: inline
In-Reply-To: <20181216192135.hc7gykmwkfgil2j5@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Received-SPF: softfail client-ip=::ffff:83.85.49.179; envelope-from=j@jasper.es; helo=gpg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nugofhd7rie23n2q
Content-Type: multipart/mixed; boundary="54hek7jfnt45m4o4"
Content-Disposition: inline


--54hek7jfnt45m4o4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joey,

On Sun, Dec 16, 2018 at 09:21:35AM -1000, Joey Pabalinas wrote:
> > > I spent a lot of time trying to find an LKML archive in Maildir format
> > > that I could use for local searches with nutmuch or something, but all
> > > the links I was able to find were all dead.
> >=20
> > You might instead use
> >=20
> > https://www.kernel.org/lore.html
> > https://git.kernel.org/pub/scm/public-inbox/vger.kernel.org/git.git/
>=20
> That was my first attempt, but the ducumentation for the public-inbox
> format is sort of terrible, and after a few hours trying to convert it
> to Maildir I just gave up.
>=20
> I ended up just slowly scraping lkml.org for a couple weeks so I
> wouldn't disrupt anything and it worked fairly well. Just looking for
> advice on where to host this now so others might be able to use it.

Now you've caught my attention; first of all, there are more than 3M
messages stored in the lkml.org datase, so I guess you've missed some
messages or something is really broken.

Besides, unless you figured out how to get to the raw data, you've just
scraped a rendering which discards stuff like pgp signatures etc and has
very incomplete headers. Unless you don't care for those of course :)

Note that I've also been toying with the lore dataset, and wrote a tiny tool
to get Maildir-like data out of it; this code is a bit of a single-use-jig
so you'll need to do some coding if you really want to use it.  Attached
anyway.

All the best and enjoy,
Jasper

--54hek7jfnt45m4o4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=Pipfile

[[source]]
url = "https://pypi.org/simple"
verify_ssl = true
name = "pypi"

[packages]
gitpython = "*"
ipython = "*"

[dev-packages]

[requires]
python_version = "3.7"

--54hek7jfnt45m4o4
Content-Type: text/x-python; charset=us-ascii
Content-Disposition: attachment; filename="test.py"
Content-Transfer-Encoding: quoted-printable

=66rom email.parser import BytesParser
=66rom email.message import EmailMessage
=66rom email.policy import default

=66rom git import Repo

our_last_id =3D '<dc4d502c-bc3c-46e3-a984-41271951a5f7@mellanox.com>'
#'<20180711142744.GN3593@linux.vnet.ibm.com>'


repo =3D Repo('/Users/spaans/xsrc/lkml/lkml/git/6.git')


commit =3D repo.commit("master")
counter =3D 5000
=66roms =3D set()
while True:
    tree =3D commit.tree
    blob =3D tree['m']
    data =3D blob.data_stream.read()

    msg =3D BytesParser(policy=3Ddefault).parsebytes(data)

    msgid =3D msg['Message-ID']
    from_ =3D msg['From']
    froms.add(from_)
    print(msgid)

    #import pdb; pdb.set_trace()
    if len(froms) > 1000:
        print("HAVE LOTS OF FRIENDS NOW")
        break
    if msgid =3D=3D our_last_id:
        print("LADIES & GENTLEMEN, WE'VE GOT HIM")
        break
    parents =3D commit.parents
    if len(parents) !=3D 1:
        print("WUH")
        break
    else:
        commit =3D commit.parents[0]

    #with open("output/%04d.eml" % counter, "bw") as f:
    #    f.write(data)
    counter -=3D 1

import pprint
pprint.pprint(froms)

--54hek7jfnt45m4o4--

--nugofhd7rie23n2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQzBAABCAAdFiEEN3eQQUH8qSq/vGsT2E735yq+rWEFAlwZV+gACgkQ2E735yq+
rWGdaCAAlRfh0L67CH87GXQq03SH8lNuqVaJqLdjXXHlqG7nQrQL2V25d0Xkhg/B
9sJRSXauzcq4B0CTLkl1o5wISDP8iPC9UZLWZ9FitTnPNHXT47OgaajInM6Bpd/h
bbtO0Le1MiwNxR5WtKmU4hfQ7n7LfYSAL7M5DoBd2YqGeozLD7sH3Wmzl8MKx8QJ
YTvtFH9+7VSXAalDYkVC+djzAtVcG+TBYxj9dQjeipHdtIN4BHIZwY+rnxXk/M6t
XmoALkexcItJ2+ZbkrcRtfeES9rICVEf+Jo8aJudshiPdRGyfshy6t0EGWUsURzl
2VslX3M+gU4fGoqohRzYfyXLCJz7jIw0QQYGzf36f3xx6g0P8PDT1bESFfMOEq8/
SKsXj5bnebegT/Pl/qfSKNgrjxPiKJI4lwBrLPKuL3JlMgEM8aTQN4O8MyBDDmJE
ly9PfXB/ZuumndxJbBj0LjKAtyFE2sJXJEMAD2o07ci314/2y8R5jBYOnZFp9TBr
KgS+vovId0zGan+m7mCBDL0s2K8JTUpnPb57YsDerD40V+ggifkv8sFNz/jNM0Gz
TWylGQb3f60H0bhPrTwE+ZbttA/qg2s4S8o+nSLKPPlxKCXANl1Jope/LTpW+Vw6
19YeoNPlccJvFjtKOwzg+CStGLwFsPObmH3H07w568NAmshkUF79wWUT7MFcceD2
Zgh63ivrJkYel8Fcyj4iWFvNOlq4tgWUb2IHtI6gN4VafvTSK1L4Tvc1RPLzSA/i
XhgHS4k9zii9/r9LEiI/gt3jsJZFYIavk9r14rxR0c8lKNtu9bHSL8rQYs+cwLni
MvvuJO1HHgOjhVgh27Cz9SL+yrGx0mIJr1S8jkvLKocIL3V1QZBfSvv5EZF1gPiI
STdXOq2fkJOf1f1p+4n2lUeIDUM7imTBYo61CZQQp6LuToeRh8nMP4CSnG39sZDM
7EH/Og178G9V/8BVDKAI6f/7lD8LGKJP1mKjfJDGtGXOr+VBdUKFbWn5uJFtpM4S
j7iuY1Kvm+GpHS5ojwZSwzxE5SnHqXG56ECUvTOb69MHG+Bval0m+qmUuuCDEJ0j
a36p8lXZRC4O6Bu6A+sQanQJwcvK2V5K9eJPgE501tqVySstVrwjCjxrlsJI8n5i
hPuz4Py2vOTlURnjhB8kP8QA3m8QkGgVdCh2jBuDcLagE4vLweiNSMnhW5/nm42j
OqCe4m0hNvUG50mXWYT5K1oCcAyE8qnqKKvPvyamvO3D20fZkYNVrw74kJjfTzcs
RZFR/f4F4sovvR8CsPDZBoGNisLaMwIGm2fRKbLgA0Q6w5uJLBQ66szS4uJtVI7z
M08tgj6F30dxKAr5xaRRthdj7Ed9ow==
=Nm+V
-----END PGP SIGNATURE-----

--nugofhd7rie23n2q--

