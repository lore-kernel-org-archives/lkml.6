Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753757AbeE3TG3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:06:29 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44345 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753685AbeE3TG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:06:26 -0400
X-Google-Smtp-Source: ADUXVKI7pLI6v5URnGE8ebB4hvHNg+zA8EAx0hxg0GnnWf36oNbCpkIkn+NwNHClbFGOIm4md1zCPg==
Date: Wed, 30 May 2018 12:06:22 -0700
From: Benson Leung <bleung@google.com>
To: Gwendal Grignou <gwendal@chromium.org>, lee.jones@linaro.org
Cc: bleung@chromium.org, eballetbo@gmail.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, enric.balletbo@collabora.com
Subject: Re: [PATCH v2] platform/chrome: Use to_cros_ec_dev more broadly
Message-ID: <20180530190622.GA36087@decatoncale.mtv.corp.google.com>
References: <CAFqH_50VYJC7aep6P+KtN4qmFeV66GEXvxmFy8KrNp1BRv33xg@mail.gmail.com>
 <20180530160413.33612-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20180530160413.33612-1-gwendal@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gwendal,

On Wed, May 30, 2018 at 09:04:13AM -0700, Gwendal Grignou wrote:
> Move to_cros_ec_dev macro to cros_ec.h and use it when the private ec
> object is needed from device object.
>=20
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Applied to platform/chrome for v4.18.

FYI, Lee, I'll add the new macro in cros_ec.h through my tree. Looks to
merge clean with mfd's changes this time.

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsO9i4ACgkQHwn1ewov
5liCqg/+OwRLP3R2rfmqEqmD72y9k9iSuqrMLJ4lFCUiYTTnYkZazzI+i3ELXNhf
FIAsBbzm+NDUWemKIzJSFLSqJuCkjUnhmPjh0JNwVr1rfkLLG+duoS0XdumrkXjk
j5NFDI5q3nEAdMFUQ5TnDykRJIviU+uEWhCXgeoVMd2pupvyH706hu8BIV4/aBi6
zIF+fhl5P6uuhYB6208as1uRvwEUbkD0fa2PIYYdozdeRdZR81NlrIwZHwdQlxss
tPBspDOoqQZxTXuXF5gpHvb3vcT7Yub/PwYSYUkLHzGgSGaEM/WxlABEgpfMSeTJ
hMpjkotBs851bIH801TiUAfuhWAJfb2IKyWswfSXdyPqiNhVe56kfoeRGLqBnci5
sJf+p4Yq9x+JIkH9/BRLq7jZxlUMsc//Y9OhUc1UcKO+oy4ybkwaNOhVsTI7fgIi
r/CYMkaaJCh1KEBheB5Ym5aG7ICjxrum20HFoR87/ayP+xzCkpY8jZ6vlELqjWVO
NgS3apg2xT2ijFo3W7RLxnc2CF9QG31Bb3Q2EmBudvsOfTX7YD/kO0WuCc9Broq9
qtGI5TY6kANXroCe860ddYKc10vKW0m6XobNwN3syfHd07LMBsQRMm4nx3pQ17EE
qv5VtZJTnlEVYK9g/2ZdRuYfIShgPsYzWGgnH8IXtEJRKgO2U1o=
=ushV
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
