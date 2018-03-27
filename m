Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeC0XTo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 19:19:44 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46644 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeC0XTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 19:19:43 -0400
X-Google-Smtp-Source: AIpwx48QWttSlW9OiliWgYSQYtBNpHoVeO4RG3njSftEbXOD6EdGE+4Q0Idcu/AAxeWPF2haZ9x5AA==
Date: Wed, 28 Mar 2018 01:19:40 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: sysfs: use put_device() instead of kfree()
Message-ID: <20180327231939.GC4097@mithrandir>
References: <416c89ec3cff87e842a0ff148df13bed35a44c46.1520502811.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <416c89ec3cff87e842a0ff148df13bed35a44c46.1520502811.git.arvind.yadav.cs@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2018 at 03:27:37PM +0530, Arvind Yadav wrote:
> Never directly free @dev after calling device_register(), even
> if it returned an error! Always use put_device() to give up the
> reference initialized.
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/pwm/sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq60YoACgkQ3SOs138+
s6HFxhAAk8Nln8GGhahf69otsHcHtigBEMI/pk9R1j+Tlf1fFkuPYKWsFykX7Zog
+1Vz0VxnSjwj1d63VT3hdxRvCJ6B8jmE6mvPEG7XsUPDst2PwMhOVo6G7dmkTHNf
33mHH+7QNikGPa4K9MaAlRuhuUIaaEQRhq+614dIx+xuXU3BXef7b18e8rWSUgSh
EN5+WVULbHtfQCBkClqpa9mgwfIJ/eXPe9PNM7Erq9GuAISz6l5ekzEaQvAMpGez
O9rGMAgG1TPhTKR0if3ZjVfwfinl5MfKlPqk+TRx2hDFnqKjwZgBjQ3IpSPjLfEG
G3Azty8Vv4mHONczDWcg4TFKV1A6niJvBh6R7xeaPTx52DPKXbMZbQW289Hrdbic
WyWP+EXL/cUKmNDNCjJCCeTmEPajLOrPus9bA7kGJSU8ZidssOXLE+uC5xon0Nnm
EUia1aAuC1unqMv7DRBWSfrKG65yR+50G8C0h/9zTwHOwU1X89WHpq+JGguAk6Yd
c68JdofbCJamRleIPF8aLRpy43V73yOqZojEvf4VykUx3wL3zrw00kgq7+F1f4Sa
fxMluge6lnfbWQ5TpNC2PtrkDbPVJHYaNUIRi8rBYpsN/BzjWSoCIbeF3f7extRp
E3q4lPa7LnEC+3fFG49KB/AjdnFI04sGg3f5S7wM3s7pBDUAYzg=
=+scC
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
