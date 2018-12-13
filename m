Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99252C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5482620851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544714312;
	bh=sF4o+u51i8Rg4YKTIoOKYYylhyrjcyakPc/9GbSa/ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tZW+jI2QWyswP7yQQcQhnYR4lIuOwp9FPKlb78RVL5rQ3nRrZOeXxCXPpPIf2vuLo
	 O2m3fDWNvuqdc/o1E1JMcwPKBjP80Y0Yc3s8ZZeBEZxamMRgd3qrbCXv8uhdQm8KoV
	 j+il94dKTERt3xPbHDOi5kOr+IBzIy0K+zVYOFac=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5482620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbeLMPSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:18:31 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57526 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbeLMPSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sTfDHF/9ixLpuR51/hHbP7ddj5Ec+5LnO2f9lOVW7oE=; b=N4xy7i2kN5GEHfpj8k4AIhKnd
        D5Gxd1yOdZm3PrPClG8Dn54mPtwacPGLL3lKFIsJtLkzJe3GzLLJunXG6U9jblK8vXkCXWRCDXGNR
        1UHWE6cMdpSHAUTBNU74n25VKWQeceh0ZEyIJ5TCwxbbyttm8R5tKMyhtJ/GCW4zCv3Y8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXSkq-0001ev-AW; Thu, 13 Dec 2018 15:18:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C8EDF11254D1; Thu, 13 Dec 2018 15:18:23 +0000 (GMT)
Date:   Thu, 13 Dec 2018 15:18:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, mingo@redhat.com,
        rostedt@goodmis.org, akpm@linux-foundation.org
Subject: Re: [RFC PATCH 3/3] arm64: add a new config option KTEST_RUNNABLE
Message-ID: <20181213151823.GK10669@sirena.org.uk>
References: <20181213122910.24193-1-anders.roxell@linaro.org>
 <20181213122910.24193-4-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1y1tiN5hVw5cPBDe"
Content-Disposition: inline
In-Reply-To: <20181213122910.24193-4-anders.roxell@linaro.org>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1y1tiN5hVw5cPBDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 01:29:10PM +0100, Anders Roxell wrote:

> With this new config option, we can boot a allmodconfig kernel in qemu.
> Config options SERIAL_AMBA_PL011, SERIAL_AMBA_PL011_CONSOLE, UNIX needs
> to be enabled in order to get a console. Options like CPU_BIG_ENDIAN,
> CMDLINE_FORCE, CMDLINE_OVERRIDE and HVC_DCC needs to be disabled.

Does ktest really not run with BIG_ENDIAN? =20

> +config KTEST_RUNNABLE
> +	bool "Test build kernels that run in qemu for ktest"
> +	select SERIAL_AMBA_PL011
> +	select SERIAL_AMBA_PL011_CONSOLE
> +	select UNIX

The opposite angle for my question on patch 1 I guess but is this really
a generic thing for running ktest?  It seems like it's specific to qemu
(and other systems which have the PL011 as the console serial port).

--1y1tiN5hVw5cPBDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSeD8ACgkQJNaLcl1U
h9CipQf/Y8dJuYSGQjtX5OQAgxZF7FzE0W1efuwUFyGZF8KV2655u+b4km8llPbt
1KSbpc8n+7HIsZRzy8y9IP3/A5vs907N4A1RqGX+7Z+79ORvdlXsGUEDa0QfNN6p
WgYZFV3Pik4pZYdX1iTcy9YK1N1sF/cHb4ADjMft8drH+m/eB3BylwhgxV0w5CY+
b4AvD8dACOfRexo3OkMN4GW6kng5nri5weUsPzw3rDgQDMi7jVrUO0jbzPvxpdCH
BUBUi+A3L+3CUIm9W39veDPBPPpqGM2Zm9cXNDljOkRF9xTlJr8pltK38H00okGy
Xdph8XjYMS3Z24VADmRMfYvB7HTPDg==
=AHiJ
-----END PGP SIGNATURE-----

--1y1tiN5hVw5cPBDe--
