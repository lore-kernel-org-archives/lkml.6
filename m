Return-Path: <neilb@suse.com>
X-Cyrus-Session-Id: sloti22d1t05-1270871-1519339423-2-8304396601009308557
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='195.135.220.15', Host='mx2.suse.de', Country='DE', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: neilb@suse.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519339422; b=jf0g+BupaqhtvZJcY4+usjwJYc0LVzZPln0aYJKcO42LEtf
    5LaoG6Z5VlPDsDe3GU7N6Z2b8dipVK42xRSwy1KaqWwITqt4jG0HQSvmGa8EcRhb
    V2kQqky9HTbQcpebYfpyLWCQhc5jSU8GHVmfLO1aCMuK6dOiuFXQ9hQGB92VBS2z
    a1eW2pgTGUIcApLEzGB25lBboD/jSPI2Qoi/95HpxvMRIUymsD4XiJOOtjpNCGWi
    xyrM5+GnWGmYWYZlBmCbHkddMHM65qoMmkyS+zoHgpC0i0z0d0+8gA1RHqqVxFuq
    TAjzWwyQEqoF1IOODKsKMaYEwzx9l04vaPsQlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:cc:subject:in-reply-to
    :references:message-id:mime-version:content-type; s=arctest; t=
    1519339422; bh=ayyPSFgD9mXTdTHniUAumnY+Qb+29DYwMtjUa9Zp8uI=; b=H
    CoxRJ8OYAJmP3GjY/Yc/72sBGJW7iltlnumGHpAA8MYTqkv5PMPBKSaYj/MdsS9N
    hBXHWf2IW7xLkIpU9AaSEW6vkdDgeCb16on5HSp4T2sQdqK63Woxn6PAkAUultNd
    +wAB8x0B0F2EmO2h5d9kdWPN092oQtoPHfzSVFLt5gMcQj5dg0rMkKD04l37cmCO
    /2dIDujGpwIuRQbqjUXPZoUORiD9kqmbYWSR7LLkv19/I7F7x7m/adXJsLL2t2Yg
    4R8NDPYpHyTb2Ckt9+HSq+DSn0eGYm8gGbQ0rEqaZogGaAm8u0Y8aI/46+D4waOq
    Rd7LIyiU3E8uxrPTmaHvA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=suse.com;
    iprev=pass policy.iprev=195.135.220.15 (mx2.suse.de);
    smime=temperror;
    spf=pass smtp.mailfrom=neilb@suse.com smtp.helo=mx2.suse.de;
    x-aligned-from=pass;
    x-ptr=pass x-ptr-helo=mx2.suse.de x-ptr-lookup=mx2.suse.de;
    x-return-mx=pass smtp.domain=suse.com smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=suse.com;
    iprev=pass policy.iprev=195.135.220.15 (mx2.suse.de);
    smime=temperror;
    spf=pass smtp.mailfrom=neilb@suse.com smtp.helo=mx2.suse.de;
    x-aligned-from=pass;
    x-ptr=pass x-ptr-helo=mx2.suse.de x-ptr-lookup=mx2.suse.de;
    x-return-mx=pass smtp.domain=suse.com smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128
From: NeilBrown <neilb@suse.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>
Date: Fri, 23 Feb 2018 09:43:29 +1100
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, "Linux Kernel
 Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the staging tree
In-Reply-To: <20180223085137.625574c2@canb.auug.org.au>
References: <20180223085137.625574c2@canb.auug.org.au>
Message-ID: <87vaeoir1q.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain

On Fri, Feb 23 2018, Stephen Rothwell wrote:

> Hi Greg,
>
> Commit
>
>   cc738c1a69da ("staging: lustre: opencode cfs_cap_{raise, lower, raised}")
>
> is missing a Signed-off-by from its author.
>

Eek - sorry 'bout that.

Please add
  Signed-off-by: NeilBrown <neilb@suse.com>

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqPR5IACgkQOeye3VZi
gbndpw//d1/9L4aub7ex/zH5E9+Yx3X1yPvmGXR5tGl61ofcbCX5L7qCrkPXRjHM
gxcD6fdK5ldO3FdCLezM+T+v1f1AbvsegGibPvWJymZGrYANl8oldwvyWLgkn4TN
AFL0eCvhbzV3LwoqerE7tC34v8ZqLxXhr9w6v3gwOgIyUdcCg4sEvxZkeejTUkCx
xAjLMUK4e/SMAkz+ZexLuyP6MUm6chBCN57btlwKGjP4JmA+dtRUWWaDkXxU/Pd5
s9DKxrdM2x5XhYKez/Pws3Y4VXLe16oT4LwTFHXXEUc6pZy7W/KgTuUP8g5CUOFv
PGBCyrHQUGIdcsi834i25fA5Zm0soe4AqsDcfWV2jwBD75Zz2U2c0E8Wl6b5/WZX
wCjAlw/AweCtv1Ix1eiKkVm03Q1XeDttTTBhLsk0sEciSNSiZ9ATzuWRR/aOr5ky
v+WD42V8SpS5GrwQLU9A2vzGIpQzTqIKbI8XrPf08DlDqILIi3fRFPvOhtriOmpW
JUUTHLVeV0c7kZWqCfm3iwrG6l8N+sUccM1o0sgjk3SrCgjY+9z0ymHXobyJao/p
mTWR9M3RK82TyuXzbl54JM55wGmAMtxZcvlxbYe1t5LZOAd95pQrOqOqHBnCU7yy
6Zt5z6tntikeUEQa2NR8uO1Ti8sMuLRj9UAQoBYu+0xfArkQsps=
=jhtX
-----END PGP SIGNATURE-----
--=-=-=--
