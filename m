Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92184C282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 18:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6840B218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 18:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548526411;
	bh=oD1+bXXBTn4vItmpVLJ4xhXNHqpcAIxp3KxFEgkmFQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mzWqofZygPCtTSKbwY+JTVG5gJUlfObe5StBxcTJRw9N1gLSWHmiwuVbR8BP+4DOq
	 oHrBHGpWHHltx0B1mYnU5Gbg/zkj49aroIn457W7Lc0Vy8PCn3ADaE9TFtLXnOx+U2
	 beOkxDcX9mcqPBtnuHm858IEu9PJycHRg/IxzuJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfAZSN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 13:13:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfAZSN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 13:13:28 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9F3621872;
        Sat, 26 Jan 2019 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548526407;
        bh=oD1+bXXBTn4vItmpVLJ4xhXNHqpcAIxp3KxFEgkmFQw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qyqwPsjP/LcZPOD0lWYbt1lrKn0RLVDsTFAoWFAEfe0btMsIsN7XX54C618IBudUk
         vAV0xFbn8tbnspaOYBC8/Gt09dlSFgPIgmjS/vbeprVQpuhh3/kYVEATSQJHUAoyI6
         S+7i+HOs4ecg67XbS3LmQLP+ah1vBR5nCXFYmqLM=
Date:   Sat, 26 Jan 2019 18:13:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rodrigo Ribeiro <rodrigorsdc@gmail.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, Rafael Tsuha <rafael.tsuha@usp.br>
Subject: Re: [PATCH] staging:iio:ad7152: Rename misspelled RESEVERD ->
 RESERVED
Message-ID: <20190126181321.1439e485@archlinux>
In-Reply-To: <CAOeBkLq18nP6xsOCNNE2Bew=u37MsLCgH=W-8ofnFSAi6dYx=Q@mail.gmail.com>
References: <1548358316-8062-1-git-send-email-rodrigorsdc@gmail.com>
        <CA+U=DsqG6PKs1Off9QP_3_q+c5=uzRypHCs+O6iur=NC5QdDdQ@mail.gmail.com>
        <CAOeBkLogWyxbB3ZNwZh9=6xVUKxmT1YGZQseAx4uo7a4u+M+gw@mail.gmail.com>
        <CAOeBkLq18nP6xsOCNNE2Bew=u37MsLCgH=W-8ofnFSAi6dYx=Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 22:14:32 -0200
Rodrigo Ribeiro <rodrigorsdc@gmail.com> wrote:

> Em sex, 25 de jan de 2019 =C3=A0s 21:46, Rodrigo Ribeiro
> <rodrigorsdc@gmail.com> escreveu:
> >
> > Em sex, 25 de jan de 2019 =C3=A0s 06:20, Alexandru Ardelean
> > <ardeleanalex@gmail.com> escreveu: =20
> > >
> > > On Thu, Jan 24, 2019 at 9:35 PM Rodrigo Ribeiro <rodrigorsdc@gmail.co=
m> wrote: =20
> > > >
> > > > Remove the checkpatch.pl check:
> > > >
> > > > CHECK: 'RESEVERD' may be misspelled - perhaps 'RESERVED'? =20
> > >
> > > Hey, =20
> >
> > Hi,
> >
> > Thanks for answering.
> > =20
> > > A bit curios about this one.
> > > Are you using this chip/driver ? =20
> >
> > No, I am just a student at USP (University of S=C3=A3o Paulo) starting =
in Linux
> > Kernel and a new member of the USP Linux Kernel group that has contribu=
ted
> > for a few months.
> > =20
> > > Thing is: the part is nearing EOL, and it could be an idea to be
> > > marked for removal (since it's still in staging).
> > > But if there are users for this driver, it could be left around for a=
 while. =20
> >
> > This is my first patch in Linux Kernel, but if the driver will be remov=
ed, I
> > can send a patch for another driver. Is there any driver that I can
> > fix a style warning? =20
>=20
> Maybe, one checkstyle patch is enough, right? Which drivers can I truly
> contribute to?

How about the ad7150?  That one is still listed as production.
What do you think Alex, you probably have better visibility on the
status of these parts and their drivers than I do!

(note I haven't even opened that one for a few years so no idea
what state the driver is in!)

Jonathan

>=20
> > Thanks
> >
> >
> > Em sex, 25 de jan de 2019 =C3=A0s 06:20, Alexandru Ardelean
> > <ardeleanalex@gmail.com> escreveu: =20
> > >
> > > On Thu, Jan 24, 2019 at 9:35 PM Rodrigo Ribeiro <rodrigorsdc@gmail.co=
m> wrote: =20
> > > >
> > > > Remove the checkpatch.pl check:
> > > >
> > > > CHECK: 'RESEVERD' may be misspelled - perhaps 'RESERVED'? =20
> > >
> > > Hey,
> > >
> > > A bit curios about this one.
> > > Are you using this chip/driver ?
> > >
> > > Thing is: the part is nearing EOL, and it could be an idea to be
> > > marked for removal (since it's still in staging).
> > > But if there are users for this driver, it could be left around for a=
 while.
> > >
> > > Thanks
> > > Alex
> > > =20
> > > >
> > > > Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> > > > Signed-off-by: Rafael Tsuha <rafael.tsuha@usp.br>
> > > > ---
> > > > This macro is not used anywhere. Should we just correct the
> > > > spelling or remove the macro?
> > > >
> > > >  drivers/staging/iio/cdc/ad7152.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio=
/cdc/ad7152.c
> > > > index 25f51db..c9da6d4 100644
> > > > --- a/drivers/staging/iio/cdc/ad7152.c
> > > > +++ b/drivers/staging/iio/cdc/ad7152.c
> > > > @@ -35,7 +35,7 @@
> > > >  #define AD7152_REG_CH2_GAIN_HIGH       12
> > > >  #define AD7152_REG_CH2_SETUP           14
> > > >  #define AD7152_REG_CFG                 15
> > > > -#define AD7152_REG_RESEVERD            16
> > > > +#define AD7152_REG_RESERVED            16
> > > >  #define AD7152_REG_CAPDAC_POS          17
> > > >  #define AD7152_REG_CAPDAC_NEG          18
> > > >  #define AD7152_REG_CFG2                        26
> > > > --
> > > > 2.7.4
> > > > =20

