Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14800C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E347F21473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfA2P2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:28:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:34001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfA2P2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:28:04 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M70Td-1h38NA3m0j-00woWp; Tue, 29
 Jan 2019 16:27:30 +0100
Date:   Tue, 29 Jan 2019 16:27:25 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Kepplinger Martin <Martin.Kepplinger@ginzinger.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Minghui Liu <minghui.liu.95@gmail.com>,
        Michael Rodin <michael-git@rodin.online>,
        Grigory Shipunov <mail@oxapentane.com>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Stephen Boyd <sboyd@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] doc: Change LXR references to elixir.bootlin.com
Message-ID: <20190129152725.GA19354@latitude>
References: <20190129142923.5743-1-j.neuschaefer@gmx.net>
 <2755754cdd8e4bd3956648f9fb6315c2@ginzinger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <2755754cdd8e4bd3956648f9fb6315c2@ginzinger.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:eUjZXuKwDQpXkUKKXHxMm628c2zMQJH1aGeeYMXNjTfCal5RL2P
 gu+8HBbr835LdsiCPRjZ16h6dQrEoI/FXdgxLvc3AJ6O2LRHWKww2EUQkOnTekRITBHC+OW
 IgKttBGa8tzYDOPnWvS59kGHbyd4iDlT6q7KKEi+o7kjBB8DUteyQAy2aNEKSC3Kv1A/Xxv
 wPDxVotaNJIZxYSpOiveA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4qAnvEWiT/g=:FdRXxko351pFFTnbHueEyu
 kXE9n5GbC5YoCMpCAQnK3Xitra9XhAqEgO2w4/yifcNRUPpnKBp9EAa4X4C4gbjjIA4v2Ng71
 Abki7KkTOX9RyOiTDcDLuzb/KsmlrRUQXCsMJ4679DjRMo+mWKfLjvW2ogUe/D8b09XhE7QTI
 aUkxJuetnQfGelq6MYzuXWHq2i0IHnJ6uEs0Qq7ld8uq1De76vbiDIwVMrsJjiYrW0q2/PyHm
 rkps+w2xVqI+k3w+Sn58+VTA6o0u/QVyjv9AkqLpxJkE50fYRyXt2vmdejt7RoAXq7507bA1c
 20QBCvlHL43NBYTC0qZNQGQWeAlvI7MUctlyZXPKGdQw7HqkFj1Ymw5UxHbeKowT87E5NsUKA
 Egy42BaAVSrJPe/tMcdwQdvWViEI7izc71+/4C3qdvQod6m190GV+Mlk3blMnx5XG56tyOOA3
 +KL5CBAx4sxfwbjz/v7P1WiAU+Ph+qW43lM93erUSDC7iEsKHuaQWOAp69dDU2jm36+8PY3m1
 iT6SW/rAP7DtGsu/+6SmXazh0ue96ezmk3jCHWukHjJb2D+xBkyjKcEZG5+f9btFWWL2oY4t0
 eqChTgyFDsE9X9ZJ38LfwG7agDnmNQuqnVzhTY2KFxSyi/nn5dG7sgDnZv8zxPQ2Ji84knjfT
 M5DpIkevkstuPoKYzGxfccZcg6MtvPcqAMNYLg7BBw4ap/JZL0XPXSYfhuh0ANrnraR5ofQVS
 k1pgGI0l+f/If18FC4iCXYFXgETXgZIv2MewYT5jeDIWGOS5BYRzhxJCRu5pSRYVa+KiLf1Em
 jBbSUumIjQO2ayA2pkCY6jmfS/TYutgZS8msprgo+UOnyb8wa/6fFO2bjJabaFhuPu+YDD1I1
 IX80Z4VFkyejBN3LaBJla0dj6wrJ4x8c7bVdt8ABwSXrddm18ZFqU4xXs1YvYNElWm/G0mRq5
 z9t4wZrCdHw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2019 at 03:01:18PM +0000, Kepplinger Martin wrote:
[...]
> -.. [4] http://lxr.free-electrons.com/ident?i=3Dxpad_device
> +.. [4] https://elixir.bootlin.com/ident?i=3Dxpad_device
>=20
> that seems to be wrong. I think it's https://elixir.bootlin.com/linux/lat=
est/ident/xpad_device

Oops. Indeed, it doesn't work with the old syntax. I'll fix this in v2.

> other than that, good.

Thanks,
Jonathan Neusch=C3=A4fer

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlxQcNYACgkQCDBEmo7z
X9u4Ew/9FelWYWndNdMHR93IecjDouiZCV0jCiaO1/yx2wnqPx+mnEBnIxkrTcBw
V41za5eEdhwOX+kxS8sHupBZHbdLZxBR5xgEgnwc9P8PwogFJa6wx2CY0NnHAhSI
B7k1BVLMYuDIAWrSyMEN8GWbKFiCdlgzQMeDK+g9bDu9Hlo41AJxxa1foTpEFPue
d9zH0t0nL+WRwykPPOcG6MmjPMIpLfQLFHV0FOIee7KFY9ZpUPUdnpYSJEzA/7sS
/hCu3BU+d96H8VrcmxKP6Zv2p4Y+tlz3K/AhhOBQLe2jyWORBsBAT77oqxajs6u2
5VXABKrWmm72roFkMd4ePm9aOEsoEZmA+nYGRB2zQ6z3mXWsMlb5IOOqIEEmH8mx
85kljFP9HUvuwaQQ956SEtBHFVWRfqubM8oVTqjz+SR61I3OrWHTX5QuZ3HBH2/R
H1pJYkxTqEvUtQ47DEkum1SqKDnrPf4cCYrNV8herSvJC5h4tHks+whbHRH3lCzV
Fpxmi/gbCygzfpRecNu90j+gfW3RksIp4hh1odERUR6d/eyX1Oi98OPbvYf6aoTS
XJlK1vY2FqTV8rEdSzRwExEW8j8S2GraPTOYUUieLVTWpqV78J9yNLawS5BZxlsh
mkMuOYNv8hP8iHzXLOOw3ywJz3uD69NjOf9/xTasM+9j2ZLLJwk=
=Rd97
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
