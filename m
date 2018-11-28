Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7189BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3062520832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tRjeQb1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3062520832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbeK1Qlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:41:55 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36050 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726894AbeK1Qly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:41:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 49DED8EE1F7;
        Tue, 27 Nov 2018 21:41:30 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UibN9_b1TQ5T; Tue, 27 Nov 2018 21:41:30 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B81028EE0C8;
        Tue, 27 Nov 2018 21:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1543383690;
        bh=6a261lD2WwsRHMP5wgIib1i/7WBJPZHLxw3C51Gb9G8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tRjeQb1dOQZOtvaJyq5lhabCUCIo3UKLjN2w3EFAkbTS1FXlXgGY8gN0dQwsInVl2
         z115gNPsp/YFW2gamuZm6fNTmStuYyqx7bBDFyEJU1fFN1Oib6HBAFioivD54o5gWK
         IBUzbVrfL9qfvkD8P7ekurrbVNEe1ZcPclmbO8LM=
Message-ID: <1543383684.3518.2.camel@HansenPartnership.com>
Subject: Re: linux-next: Tree for Nov 27 (scsi/aha1542)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Date:   Tue, 27 Nov 2018 21:41:24 -0800
In-Reply-To: <20181128153847.08ead1c9@canb.auug.org.au>
References: <20181127152539.55426063@canb.auug.org.au>
         <ef9090cf-e86a-7fd0-dfa9-6810eaaf7e65@infradead.org>
         <20181128153847.08ead1c9@canb.auug.org.au>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-INqxb6r8LVHJxEOwNF5S"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-INqxb6r8LVHJxEOwNF5S
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-11-28 at 15:38 +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> On Tue, 27 Nov 2018 20:14:58 -0800 Randy Dunlap <rdunlap@infradead.or
> g> wrote:
> >=20
> > On 11/26/18 8:25 PM, Stephen Rothwell wrote:
> > > Hi all,
> > >=20
> > > Changes since 20181126:
> > >  =20
> >=20
> > on i386:
> >=20
> > ERROR: "__udivdi3" [drivers/scsi/aha1542.ko] undefined!
> >=20
> > somewhere in aha1542_interrupt() according to objdump.
>=20
> Presumably caused by commit
>=20
>   1794ef2b150d ("scsi: aha1542: convert to DMA mapping API")

Yes, it's because dma_addr_t can be u64 on pae systems but
isa_virt_to_bus only ever returns unsigned long (because an ISA
physical address can only be 24 bits).

I think this is the fix; there doesn't seem to be much point converting
to do_div given all the limitations.

James

---

diff --git a/drivers/scsi/aha1542.c b/drivers/scsi/aha1542.c
index a9c29757172f..afb693d7b44f 100644
--- a/drivers/scsi/aha1542.c
+++ b/drivers/scsi/aha1542.c
@@ -325,7 +325,7 @@ static irqreturn_t aha1542_interrupt(int irq, void *dev=
_id)
 			return IRQ_HANDLED;
 		};
=20
-		mbo =3D (scsi2int(mb[mbi].ccbptr) - aha1542->ccb_handle) / sizeof(struct=
 ccb);
+		mbo =3D (scsi2int(mb[mbi].ccbptr) - (unsigned long)aha1542->ccb_handle) =
/ sizeof(struct ccb);
 		mbistatus =3D mb[mbi].status;
 		mb[mbi].status =3D 0;
 		aha1542->aha1542_last_mbi_used =3D mbi;
--=-INqxb6r8LVHJxEOwNF5S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCW/4qhAAKCRDnQslM7pis
hfOxAQDz5qxC4lFi29t44zMABjdsUIB0s3NkLl3XIr3Okx6nMwD6AhqqSMLVAMOc
ltgP1Qm/FVEspHfkd4yMFj/ygWexeFY=
=X0+P
-----END PGP SIGNATURE-----

--=-INqxb6r8LVHJxEOwNF5S--

