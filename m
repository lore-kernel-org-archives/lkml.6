Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeC0V2G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:28:06 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:39809 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbeC0V2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:28:04 -0400
X-Google-Smtp-Source: AIpwx4/9IS7AnSZ0/pe7DxnTwqEp/Gcsu/QleifKq3wZREk9YXVkAmoGw3doykWL/h//pLUc8m76rA==
Date: Tue, 27 Mar 2018 23:28:01 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pwm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pwm-puv3: Delete an error message for a failed memory
 allocation in pwm_probe()
Message-ID: <20180327212800.GB28058@mithrandir>
References: <93e81e95-01e0-1493-5b4a-92f36f998dac@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <93e81e95-01e0-1493-5b4a-92f36f998dac@users.sourceforge.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 06:33:49PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 15 Dec 2017 18:29:49 +0100
>=20
> Omit an extra message for a memory allocation failure in this function.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/pwm/pwm-puv3.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Thierry

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6t2AACgkQ3SOs138+
s6HBJA/9EEEWSz0ll4MuRhBseuY0eeF6Y4jEa4hWORg3Cq51w0rpIgwm7ma6f3pD
PP3/lt285NUloke/CwEsLoSvajFfOGAh/ejDTOAFaC2cJI1HNOYOFuP//ULSymbv
x054kIVqU8/TDy0tvl/LCJIIh33z4I5AEnibkagRNuyWd3Z4qWz5XpRxlRK85l0r
iZFG+xram3u71sFaDr2U+FBI620SVSzzPeusW7yn0S3ngJ3AyFbdGEUfjj3dtxYC
pixvjAAWMxBjy4oNCa9es8+WXCGOVqOkhkBvT1SIVwLQMbP5Mh5NkYIsvb8I9/Xj
agAYuAhjvgPwYTXp9KFw3MG99jqQgrKPR7igiMtlnoAFGLieQCYUFXx/D9zNOTQX
Vh8puizdORcRH2I91pFygVsSJ3eEZ0uMROlT9GddWR6T62TNjCOJlyJoFQss3BfT
z8zti0JtDY10U+acApjCCy/HyT7p0ZpBVwzv3JNL5zA4OH0ZXbZ6JsRL9PDhcXdl
M+pFVKOgx6KR3mMm1THOhsLk1rjy/eizIaSVoJFQOD0l4TWigOmgwpkNTCsVbg9G
/r2Rw3Zzo+l+pW/qOw2hRyAAKy6Xw59uwXxuHML8XhY4MBMtq3+Cxif7b6zPYDvp
26E1Ha9kOtel4T8DQcVpnOzeNurkqnF6hlzFvfaAIxwcGL2Mdrc=
=GraV
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
