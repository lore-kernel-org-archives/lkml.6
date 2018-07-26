Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3FAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDE52064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDE52064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeGZJ6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:58:31 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:13694 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbeGZJ6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:58:31 -0400
Received: from eos (unknown [80.242.164.60])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 2AA655FF23;
        Thu, 26 Jul 2018 10:42:35 +0200 (CEST)
Date:   Thu, 26 Jul 2018 10:42:33 +0200
From:   Alban <albeu@free.fr>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH linux-next] gpio: fix meaningless return expression
Message-ID: <20180726104233.72a9584b@eos>
In-Reply-To: <1532433463-42508-1-git-send-email-zhongjiang@huawei.com>
References: <1532433463-42508-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/DR5ElOMU3d801292d=RFp94"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DR5ElOMU3d801292d=RFp94
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Jul 2018 19:57:43 +0800
zhong jiang <zhongjiang@huawei.com> wrote:

> Fix the following sparse error:
>=20
> drivers/gpio/gpio-ath79.c:54:16: error: return expression in void
> function
>=20
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Acked-by: Alban Bedel <albeu@free.fr>

--Sig_/DR5ElOMU3d801292d=RFp94
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE0W61GceYqNjiMSkodJSaS524LbwFAltZiXkACgkQdJSaS524
LbxbRg//ZWb6FC/NrRGIYBOvvRAuJiL0HBDbXi6RVwkK0Ls5tnxgJBvEiQkW0tBh
kNy8ecypuGB3QcDd4HXUnQ+Xq7YehRQeN8D/E6xcgb+dvkjhwMLaDsj4+8Lb/SOu
bD3Q3oZO8WAhnHCNqgt3kOykK1+wLGowzTZaXwKncV6eMMSSvCrrtIpC0yxOp8ak
b8HGxqqCS8/kv/HbxAMIwsWczwwsxEJ2sU3JV9puOBsxuQ1q45p+3lw8jJjQ2Hf7
pxofbs9pVdsHclVuTghmIz01pPF7OkuXAVzIeYTQ/iauZ3qnGbs3m5LnZLQEHKLz
L5x+DIf5eweNoxs0fhxBVan+uIqR8n6gDt9WZfTlj0EfOnGg0066KtTpxuI45Hua
5YsMDt+xMD313XGai1BVXiOdwOYkeWOPzkMdGsIb9b1tphr6103Tnbay4gD/3h4m
aSwLPdgLmdOj6BOb4pWIWPDRCn4NZFQqmzOgv+8tQlBn3IOC3cSriAX1yeUq3y/5
AaeIBCIeW/ruImcBEncL3xvtyhVym8qmAi/5CwgTjgAFYBIXvDLj/PjUb3jIfc4Y
3+Bgl4UcJQZ/CKXy177ymYqmWRb4IpZbBxf3UL/X/JyrzCehHGIrIbhPJQhIzxkt
6fXmxJx6fMNW6ndnE7jhZ+opiOKOevzGn1uShWkxn5UANRnXHr0=
=2YJL
-----END PGP SIGNATURE-----

--Sig_/DR5ElOMU3d801292d=RFp94--
