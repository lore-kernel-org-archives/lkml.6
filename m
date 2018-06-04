Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeFDASl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 20:18:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:39588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbeFDASk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 20:18:40 -0400
From: NeilBrown <neil@brown.name>
To: Sankalp Negi <sankalpnegi2310@gmail.com>, gregkh@linuxfoundation.org
Date: Mon, 04 Jun 2018 10:18:32 +1000
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        sankalpnegi2310@gmail.com
Subject: Re: [PATCH v3 0/5] staging: mt7621-spi: Fix C Coding style issues.
In-Reply-To: <20180602183731.12395-1-sankalpnegi2310@gmail.com>
References: <eeae408864c6df4ccc6fe9e781ff7f1ac9f79427.camel@perches.com> <20180602183731.12395-1-sankalpnegi2310@gmail.com>
Message-ID: <874lijqu93.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Sun, Jun 03 2018, Sankalp Negi wrote:

> This patch series lists different changes for coding style fixes
> as reported by checkpatch.pl, changes can be broken down as :
>
> 1. Indent switch and case labels at the same level.
> 2. Fix a line over 80 columns by refactoring.
> 3. Use tabs for indentation instead of spaces.
> 4. Add a space before open paranthesis in switch.
> 5. Remove unnecessary braces {} from single statement if block.
>
> version 2 changes
> - segregated changes in individual commits as per fix category.
>
> version 3 changes
> - added unique subjects for each patch in the series.
>
>
> Sankalp Negi (5):
>   staging: mt7621-spi: Indent case labels and switch at the same level.
>   staging: mt7621-spi: Fix line over 80 characters by refactoring.
>   staging: mt7621-spi: Use tabs for indentation instead of spaces.
>   staging: mt7621-spi: Add a space before open paranthesis.
>   staging: mt7621-spi: Remove unnecessary braces {} from single
>     statement if block.
>

Thanks,
All
  Reviewed-by: NeilBrown <neil@brown.name>

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsUhVgACgkQOeye3VZi
gbnuORAAg5lN7BoRIPWy7jY55vQvyqmNrL0EvrqWwzChBvGfEIsdy0k9NIeFXIU4
C1qpliHSm8E+kxEudHLyRACUMpnzXaW38dABGj+r2OrGgCEWOI/M96QV2q3ApyEF
gguISQ6FqN0BaZctUkCL+zhXMOQDNmMCorN+dRtA7ANE+HPjzMWhhKA+YU3zWFbj
EG0UBlMG26MRihrJ5GD6bAeaMJN0Dl0rftT06+KrinEPctI7Fbf2B4YRCcZAedIx
AmShve2nKjqyqtNsjWI3inMgdY5Q+b5p8k+mrvwImPiD4GrwKMAn2xMHx+7KgLHo
wvIBsQbPe8flwhLnn7L2cW9hwY36vG+GLjji/n1QXP2WwWUllapxfICEhkQyiW5O
knCuDehsmYAVZFwlYj8DLz6AD6BqA0c1HcdftyrStfSKm/JDvb1aAFWgaMHjfvXx
UhD35qdf3d1WFkO2/5X7Wd1mhi3NuwvyMj4fppCofO8paKi8d0ciuDvVx7end4cN
LFuHdXnDVJj1G6vlg6XVyfCOYxt1sUnxqIKXPcX7NLpdcyKvkxoVo/q7/ynDffk0
9RQeOA2jpiPuKa5zmvwVERApQa2kPr5c8OLItvaC5DoBvVOi2auGrTa9PXeDcUy8
1tv9YJ/Gj4uox3fhql4SVCRioJkqzE/cvfo3Z0cDba8nKkaQd7c=
=tzkj
-----END PGP SIGNATURE-----
--=-=-=--
