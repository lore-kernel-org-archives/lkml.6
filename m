Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932609AbeE3WJF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:09:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:36647 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932394AbeE3WJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:09:03 -0400
From: NeilBrown <neil@brown.name>
To: Sankalp Negi <sankalpnegi2310@gmail.com>, gregkh@linuxfoundation.org
Date: Thu, 31 May 2018 08:08:55 +1000
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        sankalpnegi2310@gmail.com
Subject: Re: [PATCH v2] staging: mt7621-mmc: Fix line size exceeding 80 columns
In-Reply-To: <20180530190444.23006-1-sankalpnegi2310@gmail.com>
References: <87vab6unv2.fsf@notabene.neil.brown.name> <20180530190444.23006-1-sankalpnegi2310@gmail.com>
Message-ID: <87bmcwvls8.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, May 31 2018, Sankalp Negi wrote:

> This patch fixes checkpatch.pl warning and check:
> WARNING: line over 80 characters
> CHECK: Alignment should match open parenthesis
>
> Signed-off-by: Sankalp Negi <sankalpnegi2310@gmail.com>

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

> ---
> Changes in v2:
>   - Made alignments to match open parenthesis.
> ---
>  drivers/staging/mt7621-mmc/dbg.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/mt7621-mmc/dbg.c b/drivers/staging/mt7621-mm=
c/dbg.c
> index d897b1216348..6e4e223cddfb 100644
> --- a/drivers/staging/mt7621-mmc/dbg.c
> +++ b/drivers/staging/mt7621-mmc/dbg.c
> @@ -229,7 +229,8 @@ static int msdc_debug_proc_read(struct seq_file *s, v=
oid *p)
>  }
>=20=20
>  static ssize_t msdc_debug_proc_write(struct file *file,
> -				const char __user *buf, size_t count, loff_t *data)
> +				     const char __user *buf,
> +				     size_t count, loff_t *data)
>  {
>  	int ret;
>=20=20
> --=20
> 2.11.0

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsPIPcACgkQOeye3VZi
gbmcxw//dUZdLymFb4Yz+nb6znSxDKs3bQyJ1ABpXm4+hNszniSzq16pM7Q8lfrP
XFJNykKA4EPMhnJ2XF+VfMKZ5yYZ9PdotDX0Iia5NMqiP8co7jsvj+GxiDubtEwM
tpR9qS4e9v9zgqnS1V7fluRRLRICnDp77kNOvyzfLuPGKELo7EmIAIdNg9LgtiEf
GlE1fRCZXkiRtJzRI5ovA7/hOJiQ7c5Kcf/X0KmzmAjEpqFt7ToMEirC3HSqWnEN
ig+cQG5913hg+BNCQWo2JAJpzfpdEf9d9ex0scSMIYwoQJIpFhxEw7X9wIUII2dL
sivUxq7MaqnNO/MgSpWBsX0Beh8UJrF+ny8tNPs7uWw++6UnsoK9wrfaWvuuAuUj
WjipNeK9usATk49EEZDUiAejgcnUrUuEj/pnXiio88ALNGZrIU0O9RgSPiNIDMMN
S1lPRJoVwinERXioQaQEatLu45e1779ld0cYN7nVN2SNfYb62wHFVS252nkTAZ6s
O3DB770u6vW++1gjWEcGa19iQGUHFU9jFLL70Sbmk0nQaRvVknnji7jVfOZrf+N1
SV3kKxzqz/f8QZa3Ww60RtGh09asE7tzKYrslUpIxS5Cv1+AXsf0no+ZwfBUNhgQ
pNpmWHPx+DvJSseHkj7Wm930lVkThXW761BmxjWAfXgcaF1IY1w=
=7Rm6
-----END PGP SIGNATURE-----
--=-=-=--
