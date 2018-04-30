Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1992793-1525123848-2-6428565713829142192
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='utf-8', plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525123848; b=N5PeAWkgcNuAYmt1L8JvqVKcr75oEpxhHUK5El2L5fk1YAho/a
    +EmpX+kmmsHO3Y2H6oOll1olyV4pzCuIXnTqrfTEEsEvCCGPoi9hO3BpplEEvGeh
    2Ku8K5SEnjsfl8UI2lyculwi6cOn80lpm/gTLXYvP3li78kgMkziVqB1bjhDPo90
    Xn/QhO648NHp7ZngTmRqT82gWqiOWRvczUmck9N5d2eEAhfpSpi60i1zk1pANCDW
    S2mrmlIVQy+xd9dz1u3i9CTGgORpPTadNd4qovOx3lhO9tVRg09axNA/CQmAZoTJ
    hb/XsQdv5A68dkPxfkkMBuXOWv788uJlngKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525123848; bh=G1aFSIztCD7RPqqB2GcOFRGkgl8c29
    S1CBYLigFPnJs=; b=I5KnPLFP2hVEI6llKOCJpoQsCgV9Nf2J6NUFLtPsQEmA65
    4zBOuFoeDI8n7I6G3DxZaJ/mDpIoDiZvGOXSrsCyazDxZC0Db7Hw0TBT/h5WreU7
    mYRWY9GyGaGaCp9zZe5KNGomdUXBGgqE3QlOmESSQ1OxUUqUD+RY66k2h3Jol9jm
    IGmOC8RxlefB2zeT708QdjNYK+mygHuw85ac2cUxjNWwQZmai+LsvQzyCDz8O0no
    Go5AOFNQRWKYM5xJKjpJqwM8/t3/wwDngt4kfCTcDlLQ4Q3oynUawxu6r8SzFPNb
    MkWkK1oktu3wK+yvHonfldyHwj1H5RFSBz+t0zNw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=CrYROQ41 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=CrYROQ41 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJHG9wDDfCtoWAptO/RYWXKNgAO1SXWII3irgKcEZCEFaLWdyVl5r5AATmiCYhNgKvvB3PEnDEU6GeH03nmjqgHy/oPf2LC5sSVk90J5uY6Ex8QFNXbX
    TTNP+w58Rh/O+w/zlLIr7J2fogFb+wKFDOIPVKgt8qbudGwzLHHWVqxSU2Wyfz4Hab6VlpcJGUyMIs4D/THqIS+uUnO8zKA/M058QK4vRnUi2Wo+A3zjKnIM
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=HHN01XlKihRcnkjSDOgA:9
    a=QEXdDO2ut3YA:10 a=gqk8O8tedwFOFiKxRwwA:9 a=ONNS8QRKHyMA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeD3Vap (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 17:30:45 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41329 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751461AbeD3Vao (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 17:30:44 -0400
X-ME-Sender: <xms:BIvnWpAJphctNAgEI8W4mEhLQgUOt7WT_DGEWAdqR63VkjVJN5ImoA>
Date: Mon, 30 Apr 2018 23:27:19 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
        <marmarek@invisiblethingslab.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: xen-devel@lists.xenproject.org, stable@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] xen: Add RING_COPY_RESPONSE()
Message-ID: <20180430212719.GF1124@mail-itl>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
 <ba8ed01b01a81d79f6d1c59e08a318dc0309a95d.1525122026.git-series.marmarek@invisiblethingslab.com>
 <7bd2ff07-9d29-8dea-6f55-5ff24ddd433c@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
Content-Disposition: inline
In-Reply-To: <7bd2ff07-9d29-8dea-6f55-5ff24ddd433c@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 05:25:52PM -0400, Boris Ostrovsky wrote:
> Also, perhaps the two can be collapsed together, along the lines of
>=20
> #define RING_COPY_(action, _r, _idx, _msg) do {=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Use volatile to force the c=
opy into _msg. */=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *(_msg) =3D *(volatile typeof(=
_msg))RING_GET_##action(_r, _idx);=C2=A0=C2=A0 \
> } while (0)
>=20
> #define RING_COPY_REQUEST(_r, _idx, _req)=C2=A0 RING_COPY_(REQUEST, _r, _=
idx,
> _req)
> #define RING_COPY_RESPONSE(_r, _idx, _rsp)=C2=A0 RING_COPY_(RESPONSE, _r,
> _idx, _rsp)
>=20
>=20
> (I have not tried to compile this so it may well be wrong)

It works, thanks :)
I'll wait with v2 until I get feedback on other patches.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAlrnijYACgkQ24/THMrX
1ywe5wf/ZbvSaUrZdwxhc0FnZ+2VY0DWPXMMvBQIYdQWgdQ9mQGDaSyNcDGhasBc
Rotc1hjHj1BoCwuzCs4K7VsN6nqQ6oiMawL2LQnYUx4EFulZIXWHDYitJzKPvaot
IxnaF+98TvRX1UMLLeSZ/V6iJtp6GxoEi6iAynqUxly/F8vF4WjQjBx81TRBpULJ
tcdFdML8GhndBMU4KP27n7+0JXeaAPOWcXC2YZ9F0cWugTf69ZU7xIItcoq57RD7
nBaBi2BqnhkV3G4lWKJp19alhwWErhqDAMqTU32hf8g2hz1+kzbSc+G5BegQPfWk
UKLpd7zXgf/d5I/Xtx8cDfYUGO6xaw==
=iFoD
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--
