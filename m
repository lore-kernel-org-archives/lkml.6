Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616B1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2620920873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=your-benefits.eu header.i=@your-benefits.eu header.b="l3/Pf1dP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2620920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=your-benefits.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbeK0UFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:05:17 -0500
Received: from mail.your-benefits.eu ([80.211.149.54]:53650 "EHLO
        your-benefits.eu" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbeK0UFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:05:17 -0500
Received: by your-benefits.eu (Postfix, from userid 1001)
        id 23B73A1B9B; Tue, 27 Nov 2018 10:02:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=your-benefits.eu;
        s=mail; t=1543309604;
        bh=c14RFkzaLGlrhR+55xbHiwHqcL653MGVSdPbdypDSPk=;
        h=Date:From:To:Subject:From;
        b=l3/Pf1dPC6wl45hiJyhDmgMhahwYdKVSST1p8jU7wnOQJDbvrOPLKnqG0h/j7sEa7
         pM2So3KQeWM2YiIdw4OKv+bwt0uBxr6bdxZ6YL5ByigFh/LfFaHRcwKY3QamABUhVc
         QARkvNx+HKZyDNUgUli4bSLbJdb1SxyxURfjFj1w=
Received: by mail.your-benefits.eu.your-benefits.eu for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:02:01 GMT
Message-ID: <20181127091301-0.1.k.1b22.0.p4pqmfjb5z@your-benefits.eu>
Date:   Tue, 27 Nov 2018 09:02:01 GMT
From:   =?UTF-8?Q? "L=C3=A1szl=C3=B3_P=C3=A9ter" ?= 
        <peter.laszlo@your-benefits.eu>
To:     <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Dolgoz=C3=B3i_juttat=C3=A1sok?=
X-Mailer: mail.your-benefits.eu
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kedves H=C3=B6lgyem/Uram!

2019 janu=C3=A1rj=C3=A1t=C3=B3l szinte minden b=C3=A9ren k=C3=ADv=C3=BCli=
 juttat=C3=A1s j=C3=B6vedelemk=C3=A9nt fog ad=C3=B3zni (kiv=C3=A9telt k=C3=
=A9pez ez al=C3=B3l a SZ=C3=89P k=C3=A1rtya). A v=C3=A1ltoz=C3=A1sok elle=
n=C3=A9re a v=C3=A1llalatok t=C3=B6bb mint 55%-a meg k=C3=ADv=C3=A1nja ta=
rtani a dolgoz=C3=B3i juttat=C3=A1sok nett=C3=B3 =C3=B6sszeg=C3=A9t, mag=C3=
=A1ra v=C3=A1llalva ezzel a megemelkedett ad=C3=B3terheket.=20

Juttat=C3=A1si k=C3=A1rty=C3=A1ink seg=C3=ADts=C3=A9g=C3=A9vel 2019-ben a=
 munk=C3=A1ltat=C3=B3k lefedhetik szinte az =C3=B6sszes jelenleg haszn=C3=
=A1lt b=C3=A9ren k=C3=ADv=C3=BCli juttat=C3=A1st, mik=C3=B6zben munkav=C3=
=A1llal=C3=B3ik =C3=A9lvezhetik az ak=C3=A1r korl=C3=A1tlan felhaszn=C3=A1=
l=C3=A1s lehet=C5=91s=C3=A9g=C3=A9t.  A SZ=C3=89P k=C3=A1rty=C3=A1t=C3=B3=
l elt=C3=A9r=C5=91en a mi k=C3=A1rty=C3=A1inkkal olyan mindennapos k=C3=B6=
lts=C3=A9gek fedezhet=C5=91ek mint p=C3=A9ld=C3=A1ul =C3=A9lelmiszer v=C3=
=A1s=C3=A1rl=C3=A1s, eg=C3=A9szs=C3=A9g=C3=BCgyi ell=C3=A1t=C3=A1s, ruh=C3=
=A1zat, elektronika, =C3=BCzemanyagk=C3=B6lts=C3=A9g, k=C3=B6zm=C5=B1d=C3=
=ADj, s=C5=91t, ak=C3=A1r m=C3=A9g k=C3=A9szp=C3=A9nzfelv=C3=A9telre is a=
lkalmasak.=20

Ez az egyetlen olyan juttat=C3=A1si k=C3=A1rtya a magyar piacon, melyet m=
inden hazai POS termin=C3=A1l elfogad, ezzel biztos=C3=ADtva a k=C3=A1rty=
a sz=C3=A9les k=C3=B6r=C5=B1 felhaszn=C3=A1lhat=C3=B3s=C3=A1g=C3=A1t.=20

Sz=C3=ADvesen bemutatom =C3=96nnek, milyen tov=C3=A1bbi el=C5=91ny=C3=B6k=
kel j=C3=A1r k=C3=A1rty=C3=A1ink dolgoz=C3=B3i juttat=C3=A1sk=C3=A9nt t=C3=
=B6rt=C3=A9n=C5=91 alkalmaz=C3=A1sa, =C3=A9s r=C3=A9szletes t=C3=A1j=C3=A9=
koztat=C3=A1st adok a k=C3=A1rty=C3=A1k felhaszn=C3=A1l=C3=A1si lehet=C5=91=
s=C3=A9geir=C5=91l =E2=80=93 k=C3=A9rem jelezze ez ir=C3=A1nti ig=C3=A9ny=
=C3=A9t.=20


L=C3=A1szl=C3=B3 P=C3=A9ter
Menedzser
