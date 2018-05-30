Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753784AbeE3SWM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 14:22:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59271 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752982AbeE3SWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 14:22:11 -0400
Date: Wed, 30 May 2018 20:22:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Yunlong Song <yunlong.song@huawei.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com,
        yunlong.song@icloud.com, miaoxie@huawei.com, bintian.wang@huawei.com,
        shengyong1@huawei.com, heyunlei@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs-tools: do not ignore *.rej in git
Message-ID: <20180530182209.GA19379@amd>
References: <1527664249-147982-1-git-send-email-yunlong.song@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <1527664249-147982-1-git-send-email-yunlong.song@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-05-30 15:10:49, Yunlong Song wrote:
> When using git apply --reject to resolve the conflicts, we should better
> see all the *.rej clear, or we will miss merging some *.rej patches.
>=20
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  .gitignore | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/.gitignore b/.gitignore
> index 3f04e85..391c528 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -11,7 +11,6 @@
>  *.mod.c
>  *.lst
>  *.orig
> -*.rej

I don't think that's good idea. You don't want .rej files version
controlled, that's what .gitignore file says.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsO69EACgkQMOfwapXb+vLcGgCfUk0JoC0oK31sj+uiG+aHcA5x
QQ8AoJ4Vnq0zgWp1uergdZ1BZ8+PGVmT
=DllP
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
