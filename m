Return-Path: <ksummit-discuss-bounces@lists.linuxfoundation.org>
X-Cyrus-Session-Id: sloti22d1t05-1050770-1525903129-2-7161079557472080319
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
    1525903129; b=fy/hzBggyAL1uoU31G7L2UG+Nc8Bozx6M/pjHS42AU+zcaokng
    M447CcFJ2I+50k9K174lrrE4MhOnfpzOxC34St5e5g3pGjQz7U6DDUBi9OAzbk//
    X/sxqSb0IYSQwrvA47hHoxMJxFieT4wNdGKmNb2AdkW1thEc7vcX0wLz40BhwmAk
    R08Pu1GMK5FMGlTTY7967B+kYKtWjMkljlQxJel5kZPm6uw/hD/9lEYKfZXgoL9J
    QBgq4b2ny+C3pDksu/isYpX0AgKpTsxiSlNH/vjGRB7z8vAyAzOQHPUn/7SfVV+/
    l9oQNNij3YHVY2gFbL5d/wfIzrNQDST5Y2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:in-reply-to
    :references:mime-version:cc:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :sender; s=fm2; t=1525903129; bh=MNU530S4uq2isftNA/qrKiV5NmjeFlS
    k0/lptvYKisk=; b=YObnEOi67O7IDe6nQrAylG8cbrcL3inNRWNUFc8fF9gjcbu
    k4frtxy35Kq825Zmszj3ZNNYFkdnSaDoScS7/omvbqYwte9ZKYGoc2Kn0RtLHfiW
    cxGKTjRhTQIjSYavsbFrrOP3emIE+kxH/vl/tGoKttGQeBF/dFSlSAEVRcCir65H
    owotsQodA9SHT3fxpecqlVzVowLsjqcc38yRKsR6QIttyfCrwHKv1X1bPaknBjc1
    ffPa2hP+RhX0LhXFupsGLb/3mXC8p2wo9o89bkffxz4NvYQ74UVU9sdi62R2NRGD
    rKX7bWEVU2EAl4BSzx9f4VKS/i/sxgrya0cFlZA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=WoWBMwDZ
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=WoWBMwDZ
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
X-CM-Envelope: MS4wfCIalGWnFszcqAZRxIP5sBh6AxgOmhZh6PvLEILIvuF4zz1Cu6Ds0ZJtBVReCW4yErFEzBReVnQYMxfK+QQfN4lQHjmYUoodbxRexNrhAfppQ6VSIboT
    yl745hcG4kcrKWuV3+oeCNQxqdnHY+4JfYcYuTezUFP1XaQQs/nQX3PrOiEV/0i9PbSHDiPfFq0ToDbvrs7POTbQ0pcsLYz5cMbU+LK7T+vaVBPhxcgrCyTW
    B5M2AD7yKhGhMJnksbVVog==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=5MPDoNpceV4HFXFrvkM3CQ==:117
    a=5MPDoNpceV4HFXFrvkM3CQ==:17 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=P-IC7800AAAA:8 a=JfrnYn6hAAAA:8 a=rOUgymgbAAAA:8
    a=08Tp_QEC-3M9le-MB3kA:9 a=CjuIK1q_8ugA:10 a=ofnHW-yZoq13XXcR4F4A:9
    a=ag1SF4gXAAAA:8 a=D-pE8fWRZ4KmsVp6X7MA:9 a=d3PnA9EDa4IxuAV0gXij:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=MP9ZtiD8KjrkvI0BhSjB:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: ksummit-discuss@mail.linuxfoundation.org
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
	header.from=canb.auug.org.au
Date: Thu, 10 May 2018 07:58:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Message-ID: <20180510075828.32167ead@canb.auug.org.au>
In-Reply-To: <20180509213528.54bad29b@bbrezillon>
References: <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
	<20180502194632.GB18390@sasha-vm>
	<20180503020550.GP2714@sirena.org.uk>
	<20180503031000.GC29205@thunk.org>
	<0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
	<20180503224217.GR2714@sirena.org.uk>
	<20180503230905.GA98604@atomide.com>
	<CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
	<20180509084440.GW13402@sirena.org.uk>
	<CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
	<20180509090346.GY13402@sirena.org.uk>
	<20180509204727.7ff38021@canb.auug.org.au>
	<20180509213528.54bad29b@bbrezillon>
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
Content-Type: multipart/mixed; boundary="===============4151274910366977561=="
Sender: ksummit-discuss-bounces@lists.linuxfoundation.org
Errors-To: ksummit-discuss-bounces@lists.linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============4151274910366977561==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wJg1F16Hn9qJQJcUeJNMO7u"; protocol="application/pgp-signature"

--Sig_/wJg1F16Hn9qJQJcUeJNMO7u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Boris,

On Wed, 9 May 2018 21:35:28 +0200 Boris Brezillon <boris.brezillon@bootlin.=
com> wrote:
>
> I see that the nand/fixes and spi-nor/fixes branch are already there [1].
> You can add:
>=20
> mtd-fixes	git	git://git.infradead.org/linux-mtd.git#master

Added from today.

> You can also remove the mtd entry [2], since mtd-2.6.git is just a sym
> link to linux-mtd.git, so it will just be a duplicate of the mtd-fixes
> entry. You can also rename the l2-mtd entry [3] into mtd.

All done.

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

--Sig_/wJg1F16Hn9qJQJcUeJNMO7u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrzbwQACgkQAVBC80lX
0Gwdxwf9HWzPcwbaddsDWl4yjDDlRsL4RERn+NPFO1jVWtO8bxEjZsayREmUYgIB
hSvemPip3eSkZ+zPoPUWdGjN7nAa50YzsEwcr591lPX/QEkJGDRy4s46OUmvutCU
kEd3Pv4tWtFZQx+8fP9/LvjtYzToOm/EtmXGZ0handM8mclIgIh/oLoDWFFMV/2q
GROxYCVCckcjRHJs/8vckn9dJT4ReaJDVgvY3vmF4hcDAPdbvcH8GJJBuM2WOuw/
avGxi1hmLvI08b1zd9REbMjA4Dklr4SIRfqkT01/cxdEcxRbNxDuY+rvh1GRSefr
eNtfRrvYShn44eFQKCE0hu2i2yLw8Q==
=XT7Z
-----END PGP SIGNATURE-----

--Sig_/wJg1F16Hn9qJQJcUeJNMO7u--

--===============4151274910366977561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ksummit-discuss mailing list
Ksummit-discuss@lists.linuxfoundation.org
https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

--===============4151274910366977561==--
