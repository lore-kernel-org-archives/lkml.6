Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7FAC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B632F207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfBENLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:11:23 -0500
Received: from sauhun.de ([88.99.104.3]:57458 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728653AbfBENLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:11:22 -0500
Received: from localhost (unknown [46.183.103.8])
        by pokefinder.org (Postfix) with ESMTPSA id F07822C0509;
        Tue,  5 Feb 2019 14:11:20 +0100 (CET)
Date:   Tue, 5 Feb 2019 14:11:20 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     qii wang <qii.wang@mediatek.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, ryder.lee@mediatek.com,
        xinping.qian@mediatek.com, liguo.zhang@mediatek.com
Subject: Re: [PATCH v3 2/6] i2c: mediatek: speeds is replaced by macros
 definitions
Message-ID: <20190205131120.GD12401@kunai>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-3-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <1548057574-8061-3-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 03:59:30PM +0800, qii wang wrote:
> Different speeds have been defined by macros,
> so we use macros definitions.
>=20
> Signed-off-by: qii wang <qii.wang@mediatek.com>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

Applied to for-next, thanks!


--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxZi3gACgkQFA3kzBSg
KbbeYg//ZD5cth5gtax9A5yxAmHxRFYNjzjqpu6PFhKbUl50V+JFr/m0p4olHjJ7
0JMgRqdbfdsU+UWiqCw41N4T97aL/yQZ0GZCFEBfCS1vz30pzqzx9+inufmfjF8z
dAZV/SB9wRcAjfNaAA/k094Mkrkjo3mBgCMnmKDt7BtVUlFW3GeimXBfpOCiBnY8
Ldzd96pSeHhDTgnyeTmi/OEcF278UVg6MmJ+NPlycVCBjhMOYACMcXgYkMxWBpSh
uEnsyuv2+oH3+IvLBJfYQRUL6Su1g3LVIY3o/HGE+2OYX/YAfnLYI8RTzVcGOxuE
HwEKqGMcpn0O6zZmo56BtSBzg2DdQ4pwx7OMLCg/5v7Npqwf56fbjDsoIrYAlM3K
jEcCm95V96C43l0Bad8cem2gYvZclvISEoZccqg4xNe0dAPeYmj4mkqpjNTTQE72
NLYj+dxVjNowwgJDQNqkjFg65opQo38eCtoAACwR2wmiJM0D9Ixa2FkoyGODynwY
LPFlkUHu/UrM42P2gJRSbjx687lyK5baIRDIeVj/p5dyutIES5/nTpqMUqyWqbmX
0LHmxyVb7yecF8SQrlEYswn1Ge6K3hWaGBozdL+UxGhXAoVoo+OmYs+RYYFra5vN
wvWQ2GU1mumGMLSaJHAF/+j5VDkpRpvx3hEu2Ws46rfjRnkprwo=
=ch0i
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
