Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-685316-1527109299-2-7031175568044868308
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527109298; b=KVRuG86eBeQB7yXdZOL1yiwGyPrRvJjk1HO/icmiV2kHaY5/cD
    TuJ1nEkvshPlMEPUeZKB/svqgkISZz9XhBfoPd+SMtjTCPnz02iD3u8UpJJkGDiG
    EapD6Gj3lmhwIXtk5KX4tKSlnAE5S7zr49kpqE/iQJQvan3CeRyPIntLmujuC2gv
    LEZ/4rb2sqjx70JZU3I3wDTGrQp66s6FPMKQy+6uxiCGLR1B0a30C/bSTqXuxhi9
    rhXW9xOWLnrreNe0U2MrdYD9GkhQNsGDFet770d1zi9BxnQHpDskyNfBN91J7MZd
    K4a71mZr440ZO1XX4q3tTLdpxYcj0MKnVTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527109298; bh=dzp52WmjFn2t45BX2WYm6afKRuEPuy
    i2V2ZfJlys1hE=; b=N+hvptJXrd2ttb5aw/i5X5pC2TTm5pL2uhfD3cSzHc7PYn
    PesyZ7Uj01YjIMMuYbx5z3cyh0b7cYM3F3c7uR86cfWPv8PNaFMsP9Acs5b76X7+
    9n7bSdAy3GuBCouw6ysE7wUp6Et0fc5e40J3hqPGEXa8vtdd8/jj/8Z/XCJBrqMt
    WevV8AWsD2Sr7P7VlgfY3CGeuq1Z38RhYrMEckVNfFx5cr+zSQUjSkRC2gf1hfX4
    HpcLGOExteoyH9QFt3V7e3vmgLezKo1XWIYlvzgG65oB2lYns/Thn+U5CQUnVwEa
    eSdMKtnehHNeS5VD4HplFCpU7qayg7IBYad9nMug==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=pengutronix.de header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=pengutronix.de header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDLJfxFwLn3q4lJf9rf3qfperiHY3hzbOLBKkVmu6jH/7xJsv7KZiatyDo9qslaXyIbu6d8/AodeEBo84BQa+L+fxuouZD803gG+haZg9CaoBjqNQgGa
    wrVxGFI+j0SJ2jko/syE4MpKKyNAC05euR6L/9tT9T9IgjaSfwzEtwpj7/Welj+wMXHM861Q6eBi5dimIwSmXBrg73erf/j45TiLw3gND8kJkR4r16TOL7zG
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=bGNZPXyTAAAA:8 a=dwvcf_ZtjtByuscllMIA:9 a=9TEUPZE_rhGZ42o0:21
    a=w04fNwVnWSSc_NQr:21 a=CjuIK1q_8ugA:10 a=iQPxyi8uxzBYsQqwZZsA:9
    a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10
    a=yL4RfsBhuEsimFDS2qtJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934399AbeEWVBf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 17:01:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48559 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933737AbeEWVBe (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 23 May 2018 17:01:34 -0400
Date: Wed, 23 May 2018 23:01:31 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-usb@vger.kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v3] usbip: dynamically allocate idev by nports found in
 sysfs
Message-ID: <20180523210131.6h3xsm2thnr6py4q@pengutronix.de>
References: <c57fa7e9-d811-234b-fefc-1be998c5a8f1@kernel.org>
 <20180523092256.25922-1-m.grzeschik@pengutronix.de>
 <ac85c509-72ec-c126-afb7-521ddde87ec1@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5fdpms3fw4rcgaxg"
Content-Disposition: inline
In-Reply-To: <ac85c509-72ec-c126-afb7-521ddde87ec1@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 23:00:58 up 153 days,  9:38, 70 users,  load average: 0.20, 0.12,
 0.05
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-usb@vger.kernel.org
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--5fdpms3fw4rcgaxg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 23, 2018 at 10:44:57AM -0600, Shuah Khan wrote:
> On 05/23/2018 03:22 AM, Michael Grzeschik wrote:
> > As the amount of available ports varies by the kernels build
> > configuration. To remove the limitation of the fixed 128 ports
> > we allocate the amount of idevs by using the number we get
> > from the kernel.
> >=20
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> > v1 -> v2: - reworked memory allocation into one calloc call
> >           - added error path on allocation failure
> > v2 -> v3: - moved check for available nports to beginning of function
> >=20
>=20
> Hmm. With this patch I see a segfault when I run usbip port command.
> I think this patch is incomplete and more changes are needed to the
> code that references the idev array.
>=20
> I can't take this patch.

I will test it again tomorrow.

Thanks,
Michael

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--5fdpms3fw4rcgaxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAlsF1qcACgkQC+njFXoe
LGTFLhAAr4+/dLkSnnY6hdwclYrGdX0r2++zPEIzMxCtsLNkl1plYJVo6uQdBDHr
oGkEjt6yA4MJ42fXi3yCguMPKnbATOsvCyl4W5kga9M5dm3+FM/3hola6/MeehSP
Ll068iny0R/d1WCIJsuH5HpOIgp+Byw8Xyg3VhjOg05NnByJM0hD1g9vbmoGC6wN
gjlkRLd7BhGCJcwIjK2jXLm5E6r3oXAgb5MoseWjwsFYqf5dJAxat6mOQOpB2zQh
+u5Vcu/StJHIR6IrVvrFKDhMURAgt1yLpFRwAiRZjJm2suKBZkk1WSdbU1sXcTYU
Ns1RdC4rS9L1cojeGlkxAbLCr7ZQMOV1o/M+wX8KKW7oKPJ0aiy2xDfZO/YwbQmE
AXpo9aMFtUssEc9q56JEZRAnLR40ByJTc4l1xRluO3P7WGM2LmGpK5AoiB3Gzpb2
cJig/W5qgIy6e2WKQCRt+nPcqpFXCf5aIab+gBcYoWsY9t1hbvtdWn7BJgjdLuaE
w5RnlbvcLc/9j1qiSKb5xrr6diNG9/zSGEYODK54P4rGixPqGFtIQFvM/23BYZ3h
mzGErIgIJgVRepwOkOZ9AoCG5GXfubEcPTbx1ywF9QdyNgfDDkcFB3WuE4vF3bu/
pIWzqNM38OgB/g9ICbWOuNdk1g7M0ZT1KUo3Cnea6oGAjXHnjeA=
=clDE
-----END PGP SIGNATURE-----

--5fdpms3fw4rcgaxg--
