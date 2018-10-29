Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72194C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175B52081B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175B52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeJ2Uo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:44:57 -0400
Received: from sauhun.de ([88.99.104.3]:34342 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728142AbeJ2Uo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:44:57 -0400
Received: from localhost (unknown [87.114.85.207])
        by pokefinder.org (Postfix) with ESMTPSA id 928222E35DD;
        Mon, 29 Oct 2018 12:56:34 +0100 (CET)
Date:   Mon, 29 Oct 2018 11:56:34 +0000
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Vitor soares <vitor.soares@synopsys.com>
Cc:     boris.brezillon@bootlin.com, linux-i2c@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, psroka@cadence.com,
        agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com,
        dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com,
        sureshp@cadence.com, rafalc@cadence.com,
        thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, linus.walleij@linaro.org,
        Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org,
        nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se,
        mshettel@codeaurora.org, swboyd@chromium.org,
        joao.pinto@synopsys.com, luis.oliveira@synopsys.com,
        manuel.abreu@synopsys.com, gustavo.pimentel@synopsys.com
Subject: Re: [PATCH 0/3] Add driver for Synopsys DesignWare I3C master IP
Message-ID: <20181029115633.GA5881@kunai>
References: <1540807618-13246-1-git-send-email-soares@synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <1540807618-13246-1-git-send-email-soares@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Boris,

> This patch series is a proposal for the I3C master driver for Synopsys IP.

Any news on the I3C mailing list? It is not much yet, still I was
wondering...


--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvW9W0ACgkQFA3kzBSg
KbZC9A/+Ii8yRdJYBTx6mJ1Qq2cAjCodzhjGOYHap458IBp5QdRGZi2JAIaPD+Zo
4RXK2gcYq59xC975wRfd6DrUTEQLvIr/qVWLCLqeBzWjbqWPPDKeDpdWUs39JRiJ
kCxu15q+tpnIqtIpiocE5xGrWXL0xHatzOqn915hwOJr5ebqBgroHoMzVjR5v2+w
hLxMnyDvYee0mN/AsgOObrCeHHbrpnFhduvISsTvNKz0CAE5OpbJNPQbjj3+U2aM
GpfHGK5m5aPvW38BFsadD0lY+P0zNkHJ8ejL5mWlXqFS6G6gGLvHfEcYwxF5vfSJ
gqFiKqDY/JOAEApDCiDe21UUXyy02l27PQwP4cXA3QiBObHWg+dlIKc5EnNoT+r5
3pO6eteZnqF0gGA5JiruBw+vOZrPuse9NDuzRoPExO2KE7BXLwR0UDcprr4Z+Usi
4LlaoagkaFMexuVFFykBaB9Z8U9Y6aBc9f52cjGCuQ28PkCzNuwYINGf65NUWOcY
IEOjA9v/1RTrQPMlmywoOMyQnmZflvNf9uUG7Dk2HiViO5F7u0IxjwWqTOD7Sc1U
QLhOGNlfDLJdcLRwlSFE4xsUkrMdAqSfx+Mnzwj0C53ds+2GX5g0zdA/TZmt7JVs
MLCxt2rGulK1kRPBeVqVs6GH0yXy/iORF/OI4Y2u/OQl0yAteXg=
=sUO6
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
