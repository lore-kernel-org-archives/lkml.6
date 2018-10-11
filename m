Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D482C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EBD20644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jOb0gDbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4EBD20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeJKKCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 06:02:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48638 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeJKKCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 06:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1QfUskeT3ljf/UBXEM80gRQryBwrL9O+Sx402a6eADk=; b=jOb0gDbSKl9AF+D70bVKHHTWX
        dOJIobxUStvRyxkRB5b6aIRhH4Ua7BBieWuuq2RMivWZwOsOjAxNAppnyUu+oXG/ZqfqIYdd1Fre6
        zQgqgMd7W6aqlf4o2FuwkPHJnj8MG5zCyYGCFwiQ+c1YTmQx1iivHRexk5LVH13Qat2/xkc3CRGAB
        OQZ85/PKCTvrhb7PZBbAQTn89D53FlH5wZk9pW7XMUPkgw0ZG0jJN29hnZ1WRsC9l75WMVT7As2Fw
        EHNzZEyKwN288lgNw3QZSuF0XGgSx3WRfv1xZPqx3TNtPWkthyEiRuWc7cNYAHsuImHuAwa6CSap4
        ZiTV/Q3LA==;
Received: from 177.43.144.224.dynamic.adsl.gvt.net.br ([177.43.144.224] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAQqa-0006jq-Cr; Thu, 11 Oct 2018 02:37:08 +0000
Date:   Wed, 10 Oct 2018 23:37:05 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH v2 2/3] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Message-ID: <20181010233705.12f0f727@coco.lan>
In-Reply-To: <1539202180.12644.10.camel@HansenPartnership.com>
References: <1539202053.12644.8.camel@HansenPartnership.com>
        <1539202180.12644.10.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 10 Oct 2018 13:09:40 -0700
James Bottomley <James.Bottomley@HansenPartnership.com> escreveu:

> Significant concern has been expressed about the responsibilities outline=
d in
> the enforcement clause of the new code of conduct.  Since there is concern
> that this becomes binding on the release of the 4.19 kernel, strip the
> enforcement clauses to give the community time to consider and debate how=
 this
> should be handled.
>=20
> Note, this patch is expected to be the starting point for a discussion no=
t the
> end point, so there is an expectation that an Enforcement section will be
> added again to our code of conduct once we have sufficient community cons=
ensus
> on what it should say.
>=20
> Fixes: 8a104f8b5867c682 ("Code of Conduct: Let's revamp it.")
> Acked-by: Shuah Khan <shuah@kernel.org>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Alan Cox <alan@llwyncelyn.cymru>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

I still think that this series should contain a 4th patch removing
"responsibilities" with that text proposed by Alan.

E. g. instead of:

	Maintainers have the right and responsibility to remove, edit, or reject

it should say, instead:

	Maintainers should remove, edit or reject

>=20
> ---
>=20
> v2: Added additional commit paragraph clarifying we do expect eventually =
to
>     have an enforcement section (as requested by Shuah)
> ---
>  Documentation/process/code-of-conduct.rst | 15 ---------------
>  1 file changed, 15 deletions(-)
>=20
> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/pr=
ocess/code-of-conduct.rst
> index aa40e34e7785..4dd90987305b 100644
> --- a/Documentation/process/code-of-conduct.rst
> +++ b/Documentation/process/code-of-conduct.rst
> @@ -59,21 +59,6 @@ address, posting via an official social media account,=
 or acting as an appointed
>  representative at an online or offline event. Representation of a projec=
t may be
>  further defined and clarified by project maintainers.
> =20
> -Enforcement
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -Instances of abusive, harassing, or otherwise unacceptable behavior may =
be
> -reported by contacting the Technical Advisory Board (TAB) at
> -<tab@lists.linux-foundation.org>. All complaints will be reviewed and
> -investigated and will result in a response that is deemed necessary and
> -appropriate to the circumstances. The TAB is obligated to maintain
> -confidentiality with regard to the reporter of an incident.  Further det=
ails of
> -specific enforcement policies may be posted separately.
> -
> -Maintainers who do not follow or enforce the Code of Conduct in good fai=
th may
> -face temporary or permanent repercussions as determined by other members=
 of the
> -project=E2=80=99s leadership.
> -
>  Attribution
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20



Thanks,
Mauro
