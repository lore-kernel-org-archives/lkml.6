Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HmSMCHvyGFvtJAAAmS7hNA
	; Thu, 07 Jun 2018 08:53:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 135BE607E7; Thu,  7 Jun 2018 08:53:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8EA946063F;
	Thu,  7 Jun 2018 08:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EA946063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932558AbeFGIxL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:53:11 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:33010 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbeFGIxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:53:09 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 411fSx0yPPz1qymG;
        Thu,  7 Jun 2018 10:53:05 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 411fSw70fbz1qsLM;
        Thu,  7 Jun 2018 10:53:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Y1LHNO4SKiVX; Thu,  7 Jun 2018 10:53:03 +0200 (CEST)
X-Auth-Info: L4notD97Ueine1IDI1CgJF3D17NrJ6sC58dJWEiDHpI=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  7 Jun 2018 10:53:03 +0200 (CEST)
Date: Thu, 7 Jun 2018 10:51:32 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] ARM: DTS: imx53: Add support for imx53 HSC/DDC
 boards from K+P
Message-ID: <20180607105132.16f28635@jawa>
In-Reply-To: <CAOMZO5BiKjoiyh0dxycRhPkRzS2Uk9h8fPTA+sXMZBDJpbcyWQ@mail.gmail.com>
References: <20180509153428.1440-1-lukma@denx.de>
        <20180519121506.32344-1-lukma@denx.de>
        <CAOMZO5BiKjoiyh0dxycRhPkRzS2Uk9h8fPTA+sXMZBDJpbcyWQ@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/esdQhX_4xzCN10eHNJjxJVV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/esdQhX_4xzCN10eHNJjxJVV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

> On Sat, May 19, 2018 at 9:15 AM, Lukasz Majewski <lukma@denx.de>
> wrote:
> > This commit provides support for HSC and DDC boards from
> > Kieback&Peter GmbH vendor.
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Gentle ping on this patch.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/esdQhX_4xzCN10eHNJjxJVV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlsY8hQACgkQAR8vZIA0
zr0XBQgAsgImf0VM/M8wO9K9WQv7RA+ok/6DrrxrKpO7RpME65YYG7MLWHL0R60S
RDnM/sBHypEGLBl2JqF9GHJsJQxdfncgrOmBodeRKgIbTP99/2U7IiNoGEjC2jc+
dE6Mv5PHLJKe+UuErjvvQMn7K/FDJnqIdC3McpCQV+bOHc7RSggckIL52REukuNT
8EWLCsQpqlkcpRTGktMXUpcCJDTjnUgzYmymDCTcvjtiOdLa++arvlezcZOY0Toe
2Vyw2QJYLhcvIQUQbPMaGy06xufB8bJdxMRqwN5IJM5I5S2LG6fE4c2v933VZ2TG
sqZh3NSHu0R7+hiBKR6HiuMcuWOvQA==
=rxn9
-----END PGP SIGNATURE-----

--Sig_/esdQhX_4xzCN10eHNJjxJVV--
