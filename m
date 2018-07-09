Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8ECC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37986208E1
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eh3od5Ku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37986208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933475AbeGIVtP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:49:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933118AbeGIVtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:49:14 -0400
Received: from mail.kernel.org (unknown [185.189.112.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA168208DB;
        Mon,  9 Jul 2018 21:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531172954;
        bh=wMG/ROHcG4b0v0MB3mUbASHhAh3VlunNiqGZH3tnsKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eh3od5KuIM8GLTd4D9NnTK9YA8Kphx+XirTXaGPjXLfT4Tm3R8BTRVBraipcZCQtE
         d8GC5D9U3rh/Z/VAIOwBmCx9ZySeYk030pjWcndmoNmZgbpshjM2A7LWw0oACbT4HM
         2/89v+jW/+6NY/tD0u4rqnlfD+Ykh2IRa0kHh68E=
Date:   Mon, 9 Jul 2018 23:49:10 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Vibrations on Droid 4?
Message-ID: <20180709214910.tes6u4ivxomd3aja@earth.universe>
References: <20180709081534.GA6799@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="afdumk7vq5rawzdc"
Content-Disposition: inline
In-Reply-To: <20180709081534.GA6799@amd>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--afdumk7vq5rawzdc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 09, 2018 at 10:15:35AM +0200, Pavel Machek wrote:
> Do you have vibrations on d4 working?
> I believe I have required drivers enabled, but no luck:
>=20
> user@devuan:/sys/bus/platform/drivers$ ls pwm-vibrator/
> bind  uevent  unbind
> user@devuan:/sys/bus/platform/drivers$ ls omap-dmtimer-pwm/
> bind  uevent  unbind

Have you checked probe deferrals?

-- Sebastian

--afdumk7vq5rawzdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltD2FMACgkQ2O7X88g7
+ppfow//VhWRvwAOGV4UPkWy2uJ9v7OZuPNp21Jd+JIaHXFzVr4yP9z3e4/cb7z6
SqEEroHTSu9cpAIewsTLBuCPyMmGc19sTC8NAldK5vdEHm+u2KxPyofzDEHXAjJW
pGwx82Zoo2VZdFuo6Pmql4IVGDnRDNHG3pisM7f+KrMwgGMmqc2p1EnqJUA49Hwx
UvfNcIRWlf0u9/LqlL+Nx8AbYLW8hlLWZgrYl0Q0Olxk+9r5HoZIajwno4QNVcR4
tb/zm6Mdx0KVVev70sGQfqmIMlQ6OZc5UPtIMD2HtdzinWyQ9hBD5/OS1GVaRNk7
qByO1HsCTQ1xCBVB0i+XWmo8i/LSBXayVdUgixhpHcuzekjIR+sAvPdcd/86PWyV
NRnKs1ywQ3MCKIdVgArmDzVu6P8mFBX543VBEgNe0nm7UUFgi5E7lvRJwN93zSyq
sG12jMJZPAH/l3hkSqFfOqWg9PerJ/rCgopRkGJJjyUWj/oW3pAbpBUSN+1y54Ox
ClD7Y0Sfs93aiUc+MM47v2Ct3VWWfMbViiztfAXbEN6CHkAHCR8xLCLOKwPoPcqC
rKc3iY1V0kpfjS3a9xo925y27v8oKexWikg8apZOmRrzmxTUgRIqiqjEtCjmgp7X
PlRLhqyde9oGwr7h9yvX1LPEvqgdGnVWszlSMBpsU8e+ykNH1Ug=
=GQ+z
-----END PGP SIGNATURE-----

--afdumk7vq5rawzdc--
