Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D612C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D322E23DDD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D322E23DDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932767AbeGFLeE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:34:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48102 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932348AbeGFLeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:34:02 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B327A260102
Date:   Fri, 6 Jul 2018 13:33:58 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: max1721x: fix spelling mistake "RSenese"
 -> "RSense"
Message-ID: <20180706113358.va5jyd3u2x7oo5gd@earth.universe>
References: <20180526135606.1153-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m7rmygmwc5vxsndp"
Content-Disposition: inline
In-Reply-To: <20180526135606.1153-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m7rmygmwc5vxsndp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 26, 2018 at 02:56:06PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Trivial fix to spelling mistake in dev_warn message text
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks, queued to power-supply-next.

-- Sebastian

--m7rmygmwc5vxsndp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls/U6YACgkQ2O7X88g7
+pqwrxAAoWN/p6SXkr4ZE3OIsIfUwWKI3Qv+Llqy7os3bnqXHIzWb2bxZU7NNmzh
su/7wSJIvnteyBZWr0hNIdvs4naQ/e6dKYuuLvqmYlAtMzerOph5m0YPJCaPfCX7
L83DLU9kOfVluZvY7pGku91uzmVZSN9OZTkccTp1djFfsrbpdBvZ+28HFr4PWi06
60uoU/+STBTT2Sy+ywTQ11dQfLHomz0OJOBR4Gby5tcMqd3W2CRE3DamgPyp07+H
touGpJOGxyI144ZWgZq/HZ/A1fezR6XdGdJ+0aotC19c4wPy2DLFo45s/rH+/fNg
lVrx52fbrMcsIP6DxSyz7MW7yxkjSQFDfqEYQPodGtkXJdgGZwgtY96x/qb7Aq+9
gtH1qApASXFi3v8uXq0eyQaJePcQqz2ZzfVmT7tsU51T06XoFURtY5Iv4OAJHefl
/0WtkcmM2oscC/ttYPkU11DcXy6XlqSzJ5huFZnlW1bhDntAvp2TPEGHr/cKukFP
odLy4+AKGTKIRN4/HoXpMYbm12TxPMrM8/PRxRZ3L47HkKcMtJu7ccUlNvuLlMyq
FnaPphYECez9SnwOTeHYhrw45RydSavjL7CVOvNbSiSWfTA+v5+ZeyZx0a/U/GN2
vqggJG5v9rW7GCkzO5JxD8HlnEoE1noGwOqMgsk9FZtl9AOW+W4=
=Gi+s
-----END PGP SIGNATURE-----

--m7rmygmwc5vxsndp--
