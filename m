Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00559C282E9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C258C2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="RTEF1iCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfAUIMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:12:05 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:48172 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbfAUIMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:12:05 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 4BEBA4041C;
        Mon, 21 Jan 2019 09:12:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1548058321; x=1549872722; bh=rRK5zbJ2GLNb8GmKWoEV7fBC/nFW6gG75gs
        gSol8LrM=; b=RTEF1iCVUubZ+3l+JoE3UtLwbnvY7+G8shNdyw9QBipJwUmNvh6
        nTSbIQOdOgjSWxb60ywv9zSR8B6OgGgIjTOnWp+/bOPEoK/zo0PUdAwUr+3A51h3
        zBfgKCmgVVLfKHEGMaECR9pSTTidLII93pmhcoxzc65iqeiuqKKK+9k5Cx9fDA1J
        VmW46V1i7JSbJmCVxjAJZ1p8CuDCGqtIvaLLDgtPuT2VaYBkOP5m9mhXJoMnk1fQ
        348SarHkPxABYeVZYy3Vu7A+MWXtB6B3IfenkQvkJNW2H8zVjkqAOS0Fn1jdS+ox
        mSIS5ThIFUmb7a713aeQN0Z5LP6BpjqXmMRhHEjhKJI4j5uUhJ/aeWYqMIQzqGuv
        i/P3Yp89Cunb2H8rVoJRQXZ6tZpc2L0WQ9cttWRrCD9RBovaxPTee3MvzgiHN+IK
        t/q8MpkK9IgDzoNQAsZUJYvjC+BmRRndTcjBZd7/eCSJ8gjb8zDYrQRlqi+m80u9
        TMZRpzNSNcd2uhsUnlGu9EvN9R29iOvMy6nsJSpNnGrE0lxxZZGZVV6oaGbbmGuB
        T96CMCiNf+AQoxMSL7VL5w0HevEVFr+i+kh4HhRP2q4zRPPj1cUXfPhspj8nOaXW
        MKIi/Hh8cqP/EoWC8w7628GOXahRDhpLlsJU0E8m/WzzvDvhjyM5SA5o=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id njzRGPxtKfs5; Mon, 21 Jan 2019 09:12:01 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 4376B403EA;
        Mon, 21 Jan 2019 09:12:01 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id EA53BA62;
        Mon, 21 Jan 2019 09:12:00 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: add translations in process/
Date:   Mon, 21 Jan 2019 09:11:58 +0100
Message-ID: <2146324.8BP4ZdZamE@pcbe13614>
In-Reply-To: <20190120185617.44a7f275@lwn.net>
References: <20190119221341.3622-1-federico.vaga@vaga.pv.it> <20190120185617.44a7f275@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 21, 2019 2:56:17 AM CET Jonathan Corbet wrote:
> On Sat, 19 Jan 2019 23:13:41 +0100
>=20
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > This patch adds the Italian translation for the following documents
> > in Documentation/process:
> >=20
> > - applying-patches
> > - submit-checklist
> > - submitting-drivers
> > - changes
> > - stable api nonsense
> >=20
> > Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
>=20
> In general, this looks good.  One thing jumped at me, though...(OK, more
>=20
> than one, but only one to fix):
> > +Perl
> > +----
> > +
> > +Per compilare il kernel vi servir=E0 perl 5 e i seguenti moduli
> > ``Getopt::Long``, +``Getopt::Std``, ``File::Basename``, e ``File::Find`=
`.
>=20
> Didn't Rob Landley go though some considerable pain a while back to
> eliminate Perl from the basic kernel build?  This, perhaps, should come o=
ut
> of the original.  (As long as it's still there, it makes sense to be in t=
he
> translation, of course).

I can have a deeper look and try to fix the original document too

>=20
> > +Modifiche architetturali
> > +------------------------
> > +
> > +DevFS =E8 stato reso obsoleto da udev
> > +(http://www.kernel.org/pub/linux/utils/kernel/hotplug/)
> > +
> > +Il supporto per UID a 32-bit =E8 ora disponibile.  Divertitevi!
>=20
> Speaking of stuff that should come out of the original...this is not
> exactly news at this point...

Well, generally speaking this document mix things from the past and the=20
"present". Probably it requires a review.
=20
> Meanwhile, here is the thing that actually needs to be fixed:
> > +Raiserfsprogs
> > +-------------
> > +
> > +Il pacchetto raiserfsprogs dovrebbe essere usato con raiserfs-3.6.x
> > (Linux
> > +kernel 2.4.x).  Questo =E8 un pacchetto combinato che contiene versioni
> > +funzionanti di ``mkreiserfs``, ``resize_reiserfs``, ``debugreiserfs`` e
> > +``reiserfsck``.  Questi programmi funzionano sulle piattaforme i386 e
> > alpha.
> Even in Italian, I believe that 'Reiser" is spelled "Reiser"...

oops, your are right. I will fix this and send a V2 patch. Then I will have=
 a=20
look at the original document and try to update it

> Thanks,
>=20
> jon


=2D-=20
=46ederico Vaga
http://www.federicovaga.it/


