Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1016021-1525902336-2-10857436889158361749
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_HELO_PASS -0.001, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.169.12', Host='mail.linuxfoundation.org', Country='US',
  FromHeader='au', MailFrom='org'
X-Spam-charsets: plain='US-ASCII', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: ksummit-discuss-bounces@lists.linuxfoundation.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525902335; b=ClUOSBHsuqig1dQR9dhlxz/mcNz7ADE26tumDgZvxL+Bxtq8ng
    1gDbgt4ahrVf0TPiqAHgv2ZsfKNIX86y61nNvsYBvSn456DoTrnk/oNfJi9jJ1nY
    pgDBXRJQN3I41PXcFchVt+ObOenSevlI/9liNUHdi7tfdd/FaXlUeUZuOFbCtOl2
    HaPBxuCnxoG5Ab9sKDzPxcXCCBRuvDEwnD/Lu8RvSTIJQiLjFBKd6HUhiwHg+4dK
    uzU5eRMf7fPDBgvd1ldR/I6RZJsvRYh7EpjMIb83tgtopi1+dXVdMAO+unmKjtpU
    Nj+kfjZ3CUvb5sOvrbkCUq0E+n+gGi/JLbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:in-reply-to
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :sender; s=fm2; t=1525902335; bh=w7w76tioY65exCvtBCaBPPm75m+qyrw
    OmVIBm2hhW1s=; b=HQ41eE3aWdRe/VbS7Tz7dwgOIXu15J+jH68QChi189VKL7C
    SNclFYALTFiQGF5thwSwSX3yGZzdMSntVPiMAjhP/bY2ptjyJyRGMuVQueEu91ks
    4cHwymU8RrF5dgk5lwKb8wu+duUa3v4nRQ/Ta4jZaWzOFtEi7djdjozRiABvT+qT
    qeLTgjPFq8O1s4e5yCiB0SIGecICQmYHfUG/GoWSMipdVRZvRUvlqT4wxxpey339
    R+ctZPNlaqz+FRiFqctVTQl9Aq3Jf4WcnTv1e3ir9LC8ALCWbkZ61gMiXxT6EBVO
    9NfO/DxCZRa4dbLU6v/cpzzgyY2jMMbCzmkU8nQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BNfGAOcq
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    smime=temperror;
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
    smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
    x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
    smtp_org.domain=linuxfoundation.org smtp_org.result=pass
    smtp_is_org_domain=no header.domain=canb.auug.org.au
    header.result=pass header_org.domain=auug.org.au
    header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BNfGAOcq
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=201702;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=canb.auug.org.au;
    iprev=pass policy.iprev=140.211.169.12 (mail.linuxfoundation.org);
    smime=temperror;
    spf=pass smtp.mailfrom=ksummit-discuss-bounces@lists.linuxfoundation.org
      smtp.helo=mail.linuxfoundation.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=pass x-ptr-helo=mail.linuxfoundation.org
      x-ptr-lookup=mail.linuxfoundation.org;
    x-return-mx=pass smtp.domain=lists.linuxfoundation.org smtp.result=pass
      smtp_org.domain=linuxfoundation.org smtp_org.result=pass
      smtp_is_org_domain=no header.domain=canb.auug.org.au
      header.result=pass header_org.domain=auug.org.au
      header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKc/u3SxzyNfaWwshYtQYIa703ezQuVtFedhcMj02DySyXNiYOEvM5kDFckTWoMNY9sIFh4cOZVB1wwWcrc2UCH+UAuJwHfu6tf90iXGvDDmENgtgkxu
    OdEEqWg/ndpK85v6CtMdwGVP6VZR+AwU5cV3eiGOGxciMjE7+4pe6iYS5la6yIi1X0BNVkrVo3vUYXpGCTzhJUfef4L9gM5qXNfvIN6yWXBfkxejAgL7jq29
    ata39MUt0g8VKc10/Ty4Mw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8 a=rOUgymgbAAAA:8
    a=08Tp_QEC-3M9le-MB3kA:9 a=CjuIK1q_8ugA:10 a=2pvJLF7D7uB8u9MxmQsA:9
    a=ag1SF4gXAAAA:8 a=D-pE8fWRZ4KmsVp6X7MA:9 a=nlm17XC03S6CtCLSeiRr:22
    a=AjGcO6oz07-iQ99wixmX:22 a=MP9ZtiD8KjrkvI0BhSjB:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
	header.from=canb.auug.org.au
Date: Thu, 10 May 2018 07:45:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20180510074507.75423824@canb.auug.org.au>
In-Reply-To: <20180509155733.GA13575@roeck-us.net>
References: <20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
	<CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
	<20180509090346.GY13402@sirena.org.uk>
	<20180509204727.7ff38021@canb.auug.org.au>
	<20180509155733.GA13575@roeck-us.net>
MIME-Version: 1.0
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
X-BeenThere: ksummit-discuss@lists.linuxfoundation.org
X-Mailman-Version: 2.1.12
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/ksummit-discuss/>
List-Post: <mailto:ksummit-discuss@lists.linuxfoundation.org>
List-Help: <mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss>,
	<mailto:ksummit-discuss-request@lists.linuxfoundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5686344733939883723=="
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============5686344733939883723==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lU+hWpCKhqV3z7H0WtOau._"; protocol="application/pgp-signature"

--Sig_/lU+hWpCKhqV3z7H0WtOau._
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Wed, 9 May 2018 08:57:33 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>
> Please add
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hw=
mon
>=20
> as fixes branch.

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/lU+hWpCKhqV3z7H0WtOau._
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrza+MACgkQAVBC80lX
0GzYGAf/fceOXkMiVU0RWyaGOjbP5Uen/SIAB/QZeY9+3DYkEcLAnw3Osx+1tzPt
nBuo+bOYaO4nMSIzXYtUFHYbd02fmcvvFKUdFhqOOBcTRPeNGoKtJCzBMIGwYdKx
yFDGY+KPeLPH/GpK2YLkTzxz+Ezcj4kPjI+7mpIHKa4UgtnX39/aKSi71eQtuP+y
8Gp5ReapawAcLTCWcuBMy9C63/LsynetiDk467lNbM9Z/UiJBpA0LAkkkOe0xGeK
vFP5Et0MXXM1ZmO+cxe2C3seBke+5f7pjmxKsJAPMk4YhJCAb3Vm9hhmLF/2sjDe
3HiWvHj4oABlH/pp+cGEUfxzdfefkQ==
=mrqg
-----END PGP SIGNATURE-----

--Sig_/lU+hWpCKhqV3z7H0WtOau._--

--===============5686344733939883723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

--===============5686344733939883723==--
