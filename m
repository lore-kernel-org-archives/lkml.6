Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BF6C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27462084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27462084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeJESmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 14:42:02 -0400
Received: from sauhun.de ([88.99.104.3]:38618 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbeJESmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 14:42:02 -0400
Received: from localhost (p54B3360B.dip0.t-ipconnect.de [84.179.54.11])
        by pokefinder.org (Postfix) with ESMTPSA id 313792C052A;
        Fri,  5 Oct 2018 13:43:37 +0200 (CEST)
Date:   Fri, 5 Oct 2018 13:43:36 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Luca Ceresoli <lucaceresoli77@gmail.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Peter Rosin <peda@axentia.se>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v2 1/3] i2c: mux: pca954x: simplify code to reach the
 adapter
Message-ID: <20181005114336.GB5433@kunai>
References: <20181003155024.16024-1-lucaceresoli77@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <20181003155024.16024-1-lucaceresoli77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2018 at 05:50:22PM +0200, Luca Ceresoli wrote:
> From: Luca Ceresoli <luca@lucaceresoli.net>
>=20
> struct i2c_client has a direct pointer to the adapter, no need to dig
> it out of the struct device tree.
>=20
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

I like such cleanups!

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3TmgACgkQFA3kzBSg
KbY/wxAAn7G7Vdc1KEByMKk9/3TAiEhJTn3MfACEsR6i42Jt/y1GspZ45xyn//2T
GZRFv+Ci9qNXh+t08KASjiS9N85/72l3zOhBqSQcmJN5zDtdTtES2rbvsK1HOTAU
ukEygzgofLPd+O0+26L8nBq1QRhmPhe+wYOArw/56/gTH1RUGEr+FY2J9SZBfqoT
G2+RnFszAYhC2A5BubZm8BN01Sim6fHI0CAye6CWYBDypr8q6FoSEfvmmTvjgDTC
u2smf6Q2ZMOHGC9GsZIRMaAahLFW5VkJwTDdA8QY62FaM7XAc6QRzQGmEDbJ46Ig
vWPUekCx703gOXPDNGUb+AAXKRaT9URuY0jbOmV/Y+lTZiUhjdHgDXlv8PfR4yep
twrMDeK3dzbqB9qh3puVugSLqHV5NDKIP5/j0s4/UDLvMFzezJ1klrqJl52szieq
o/SrPKG3OxyHavlTDeIKBHufc5Eo9QgOd0sfw14WCJT/Y16fU3aysStuDWtJ23z+
HLt3ItE3c2rg2FEJRW+23LkoiF8gXD17TArwrhJIeGiSeHfFw3dycAG+9EODz7BQ
DX9Fu6aT2I1Fzo46BiTZ1woQz8kxlslAb25j6Wd3ytzVzlnlXFz3+eiLV5CIv2Iu
fLV/ASCdLkLJrozZzQdZmiNKxWua9fK+qw1SgQIokvE1GdG62Dc=
=UVAc
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
