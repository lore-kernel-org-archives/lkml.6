Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeCMVSC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:18:02 -0400
Received: from sauhun.de ([88.99.104.3]:48697 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbeCMVSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:18:00 -0400
Date: Tue, 13 Mar 2018 22:17:58 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: "Christ, Austin" <austinwc@codeaurora.org>
Cc: Abhishek Sahu <absahu@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] Major code reorganization to make all i2c
 transfers working
Message-ID: <20180313211758.kv5voneg4akm3rqo@ninjato>
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
 <2a092d8f-6d1a-27e4-01f6-49790f767ae6@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="estlfzz3vgzqxlx7"
Content-Disposition: inline
In-Reply-To: <2a092d8f-6d1a-27e4-01f6-49790f767ae6@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--estlfzz3vgzqxlx7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 03:09:00PM -0600, Christ, Austin wrote:
> I've tested this v2 series on Centriq 2400. Looks good to me.
>=20
> Reviewed-by: Austin Christ <austinwc@codeaurora.org>

I am a little confused. Do you mean Tested-by or Reviewed-by?


--estlfzz3vgzqxlx7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqoQAIACgkQFA3kzBSg
Kbb3sRAAhoVs4VwqxYhK2LTlhbBJWX3NZexA22TmwCxlsSXxlqbbs259Wqk+MZaV
DjHWqt3xOc04wbkIS6qCe45jtfjPt4A1FYFD+1mgRdKDxeKjsrUSpo8al0WOgVR2
dGsFV63xSeYASbSzziWnz4MVO6iTsK0ea+HRkVJWZlbFE80/3iRyE3kobyAB6Vcq
UiJbleLMCwiylg4dvxyX5C6Cax8pdNy+2oAA8K8vrRN6z5yQJS0gD8Ezn586Lwsr
7Sc77TYv6l/wEsm78UQWeCbWw3tvw+iOo6BrlCqcsjjPwTXV9AsS0P+97jim1fJR
/CLUEwQxnnBiJrY6RCxAhU6ZUGfCxhK7cPizZqk/YfqD6V9sNkqOf+6Y04OwVWnj
MsnT/JAJo2sTqIbOdus4YMK///1tLqiNZ7UGJCfkRCDQyO2uYEqeK8ekjctjqQog
kIhZiOOdFFGP71C8HG0LgoWztAzw6/JtHHvVzlEnMxUyqK3o4hFKx18m176cU7LE
yxG5PycL3oTfY+gI1LzkOC84vPLbUUU3HDT++DOGDPLZcDYqvBepvs6vzGA33pGF
QVH5i3vDzOxiembm4+2xoM+csK+ATVro25kd5gfQ5KjI1m1Ish2cU/AgA3kDp0uf
gcTxlwbcy1Bjj2A3XXaPMKzlQ7uA6WD3fUFG56BHbB6gfJ3V4DI=
=go3g
-----END PGP SIGNATURE-----

--estlfzz3vgzqxlx7--
