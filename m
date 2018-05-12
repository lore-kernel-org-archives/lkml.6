Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-810118-1526097861-2-11926649689666513269
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
    1526097860; b=FA219S/ItxwjxnelD9Hz8JnzPScTCjrejzam95Hm7LBEzZq8tS
    L28gdhubEDVoPel4m3W5zPtObcwY4QQzd2ZzyMKBK5jrC/+hgKQlI/BFIhXdJUBk
    dtghTOCbVV+/tQJDL0saSj3xlykJYQgLCUMOCy7VtqR9soXxhcsJtJINNi9o2LPm
    7crXOLtZ35pSy6PwVcOzhQs/HdAqAQ7G9LN+xkhdnJFSL388hHWA11pA2AeoA3VV
    YbnPH/NdecSVMu16tMLroPwg+xn5983DvJZbanfsZDRr/hUrqnrePJWq0W7vnr/E
    VP01n5u47AmiZi9ipkaKH6lsxE23ftYygFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:in-reply-to
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :sender; s=fm2; t=1526097860; bh=EICXM0LWpS0Ing2fpCw/cVRZR95AHRf
    V6EPXn+ZkxXM=; b=e0APfX32DjLpJHhjMKb9s+kkTUs3OnTWCTPu8h/1m2hDGnC
    rgREsvZzpMRjkLYZBvcQsZCqP/IZSg5k+fw8bPbJYQa0VYOccPXPC5/wW05O7fki
    tY6nbq5pxvfjHwHdVpLdmBVVgrPwDaW7//CNLl0eEedVSBMByBJMAXZsKI8thmJO
    UEX7ffG9xg7nqobsSBEH8ryoryYl07oy5s9A4i+97NdLZn2WFl3YJ3+GV9cPjoq3
    sBnYtU+PmV66p3nGk7qi/QKaryRx9a3CorwvnYB/aVG8Tw7syGmQUh9nlvF/kCok
    8LnJrPAW7R0Z4Woin5HHdhJhLLx4DMEx/qD5vTA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=GMlJgnuF
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=GMlJgnuF
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
X-CM-Envelope: MS4wfGUzQcorYyWuhk9vw5jjYa/BwtMifzw2L4mhNW8eDcSFr1STPENlqCHojbriTGOxRKFT7lGcVhrqYX+LXwXICzoipte0KhkQAkz6DsZwQFdz5fviO2Ko
    2RGRVeh6VHq1ETow6ECO5IfNnp+yfHgIkaN07MasnP58CbN1Ummiire1dUcFxWVN5rBeHU7wJ5vAt/ZeZEH3G1r6d1z0YW7a15JQGex41zMnBgwTxmfx1bQu
    eM/HwJQ4rKO9doBa7ob96Q==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=rOUgymgbAAAA:8 a=08Tp_QEC-3M9le-MB3kA:9
    a=CjuIK1q_8ugA:10 a=Bnjd-mqrdNVJ1ZXbUDAA:9 a=ag1SF4gXAAAA:8
    a=D-pE8fWRZ4KmsVp6X7MA:9 a=AjGcO6oz07-iQ99wixmX:22 a=MP9ZtiD8KjrkvI0BhSjB:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
	header.from=canb.auug.org.au
Date: Sat, 12 May 2018 14:03:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Sterba <dsterba@suse.cz>
Message-ID: <20180512140358.7f9fb8cc@canb.auug.org.au>
In-Reply-To: <20180511084701.tosopl7oso5j7wfq@twin.jikos.cz>
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
	<20180511084701.tosopl7oso5j7wfq@twin.jikos.cz>
MIME-Version: 1.0
X-Remote-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU autolearn=ham version=3.3.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	smtp1.linux-foundation.org
Cc: "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>
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
Content-Type: multipart/mixed; boundary="===============4766813183500148739=="
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============4766813183500148739==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//oFAaz9Pzc5V+u55NtwwjGi"; protocol="application/pgp-signature"

--Sig_//oFAaz9Pzc5V+u55NtwwjGi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, 11 May 2018 10:47:01 +0200 David Sterba <dsterba@suse.cz> wrote:
>
> Please add
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git next-fixes

Added from Monday (as btrfs-fixes).

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

--Sig_//oFAaz9Pzc5V+u55NtwwjGi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr2Z64ACgkQAVBC80lX
0GwELwgAoLyNQil6o/x3wggZy1TaBRWzoYiZtT+LnyIgeruC5qjsk6Qz2VhKdnbj
n3/rFt+piaLdf3HD29aiMcoZJCoaFhkOnBi8eXn41kJI49S+1koGLfUgbuLP2Nnf
6WGuNRlESpkXiizfoM+7wEsRzUJjF3kIkzCw6Hk7NL+g88ymsKsAUf7HKghjoVuM
BYqhZ8lwtw5xwMBiUzGWDAJ4NdYBFG0j17zG94K2+jMJ8fMngcQcWDS5tT8K/WRn
CWhR+GB+2PHZTzilFAN2QzGS/5sQPxHpcPRDrheh8lQKUHXdqTOBF1ersTh9MoXA
memkEVLRLUqc4VdoyarIAjBBfhHA9w==
=AdGq
-----END PGP SIGNATURE-----

--Sig_//oFAaz9Pzc5V+u55NtwwjGi--

--===============4766813183500148739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

--===============4766813183500148739==--
