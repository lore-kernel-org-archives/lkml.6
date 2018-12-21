Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEBEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B75217D8
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388168AbeLUAda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 19:33:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:40574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730634AbeLUAd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 19:33:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9097AD0A;
        Fri, 21 Dec 2018 00:33:27 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jonathan Corbet <corbet@lwn.net>
Date:   Fri, 21 Dec 2018 11:33:21 +1100
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Documentation: convert path-lookup from markdown to resturctured text
In-Reply-To: <20181220085403.5538683d@lwn.net>
References: <87k1l9dgx9.fsf@notabene.neil.brown.name> <87sgzc7v50.fsf@notabene.neil.brown.name> <20181205124644.3f8a452a@lwn.net> <87woonelit.fsf@notabene.neil.brown.name> <20181206100912.535b351d@lwn.net> <87h8fmcnoi.fsf@notabene.neil.brown.name> <20181220085403.5538683d@lwn.net>
Message-ID: <87pntvu3am.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 20 2018, Jonathan Corbet wrote:

> On Mon, 10 Dec 2018 09:58:37 +1100
> NeilBrown <neilb@suse.com> wrote:
>
>> However we now have a stub section "Pathname lookup" which serves only
>> to introduce another stub sectoin "Pathname lookup in Linux", which does
>> little more than introduce the rest of the section.
>> This seems inelegant, and is probably why I went for the "include"
>> approach.
>>=20
>> What would you think of something more like the following?
>
> Sorry for the delay ... $EXCUSES ...

'tis the season for $EXCUSES

>
> This makes sense; I went ahead and applied it with your SOB on it; let me
> know if that's not what you wanted.

Perfect, thanks.
NeilBrown

>
> Thanks,
>
> jon

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwcNNIACgkQOeye3VZi
gblLIA/8CclSfkfHjV6RWLO4G1ogmF8r+uBVpIjzN3VBfoqudx6iDp8eJ35j2XM3
rjZU3Mwm+j4DJ/hPmHh6GuK2qoEefzJ51uN9gZclOgUaJ7FLb9Vlzjw9+hPlEFIv
KeoOt1U/rdwiIsz7Qpy98CKR9rhWZ/RvWDyntIyvzRPgOQ6MOfkg8we7VujZMNFh
omHEVvNn+SF+E9AuoRelwqp4MEG6MAfSiikt/w+zvZV4h0TprB0EhQrtLGNViZ/r
12TsB6ffSIkxBs8QxoLY0H3WnEbQqpq0rcy2mZMi5ILnMgwnswhVnnBlf8ajSBBl
iailk9loS8+xYlaQ5z9vopK58r2PQQ8/3zzt0seNHs5bBubMXspYjwopMAA9Olnh
RrXGHF1JSf+iRRtzB/Jj2RwdPLgC7FgGXHivSl0iHa922kHVE8RKdfuNfXh8G6Eh
NyDiCBxvwMCHK3iyxddrHsUQg7Itmf3XIlDabprehjSKlfFHNzRuVAbgu9m7by69
N9LBrNr63zKwPfxKdU4M5ivO1oZEBT92+PU7vzcgcGFMulOedpudT3oYHzzGUBzq
Lmhot8URkd9vht9HR00WxAUgWBlenqqbz//uPj55mpm8sKjcxOCVOpeGWOHOdOdo
1RnjKOI9MpZhHXlGRQbGs0She62c/ZzUZh6J1sRw8jTrE5INzeM=
=ltnp
-----END PGP SIGNATURE-----
--=-=-=--
