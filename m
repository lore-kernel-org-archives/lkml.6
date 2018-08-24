Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5460C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955E121564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955E121564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=burcheri.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeHXKCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:02:55 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:38223 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeHXKCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:02:55 -0400
Received: from localhost ([94.79.149.170]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0MdLdb-1fajdX3SSZ-00IXog; Fri, 24 Aug 2018 08:29:40 +0200
Message-ID: <1535092156.11909.8.camel@burcheri.de>
Subject: Re: MQ-BFQ crashing on battery mode
From:   Massimo Burcheri <massimo@burcheri.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
In-Reply-To: <a43c5bdd-06ec-ae23-ebd3-bda8c0ea4f5c@kernel.dk>
References: <1534926011.18658.29.camel@burcheri.de>
         <a43c5bdd-06ec-ae23-ebd3-bda8c0ea4f5c@kernel.dk>
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-g/wU6nwrQoj7I+d5cqX4"
Date:   Fri, 24 Aug 2018 08:29:16 +0200
Mime-Version: 1.0
X-Mailer: Evolution 3.24.6 
X-Provags-ID: V03:K1:BR/pQCAuaZcJbiqxwPCsTM+vq2FPdeCk5ysRrgrdkHKC8Umggse
 ja0uIvsj8d50U7zfUEV3Wa5AuovhTzy4wBhBh5haNnpfNEX//K1Lc03dobIkkS0UlHFeTUQ
 2j3k+eNlRr3K5DLMBHYkiLnXROMkH2jGGgX+HxKdmIh6XHviCdyQlVpyvl4h6h8/w7Ykgl6
 z3xH/qmR5MusfuWp5lk0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:77JbQgrQ9zY=:QyjKOn3TvJeZpQ+OwnEZLd
 hUhuY0F+oMDZV1nZQBQxq2U6lkdzfhfbqL9xjZBNhsHVbtTXqZLPXl3RTXi5cJQQxWmgJyVx7
 mSHThdBeNV8l4HxMu+ZSkePOO7uE/je3/0Lq8Gx02MbSOe+9K/2hyT4HaNYyv8sS8uzOrFBGU
 QJadRbOguTIKXgtJE0pHyiqEvdbhymWZFEX7RV8dS4ugF6Vofp+nR25nSlaq95zi6IuJdusOX
 NEo+LzoTf8xMQLAV+fEaSwdBcclvTr7qt3BMVBzbCqTjsXD5qchgbwtWSGcIXThT0hrWAOW0v
 jwOyf7bgyDxxYs6XfLvbeiwv763nUwcDR7UO3SBg6xU6xvkvXl1ttFTo2/d2c5jarsTRMUrBS
 g2NNo5SZ7fg7idIYy2KT5+XI00JWbVZz8/9KvHUsrghpCTQA4ER8u2vlsw3nRbDQln/C9nge+
 Sgz4pvhPstNXKJ9Qew9/PGHNvGRdwukoYw35n0gJMjoN5NSq6VAFbAh+2ek43pRn2optl/j5g
 Oi2vE1E0UyOow0+2N5qMLWm/HezfwbkEzEGbR6azGjDeSeLD0syy343jgy4Ewye1mLmrHybsZ
 3l1ZAovsgBBiHqW+Zz8XB+dHi+4UIyX16jlo7KIKe52Dw2EXXRmc2QN3zDcVbHjgNw4nrRO1k
 vn3SkNxt2j0p2cYSGtn3fPMZTWmWRr/Z+tt/DCWoN6RIZJEc8fDPsUHAm1f7w0v5Ye4s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g/wU6nwrQoj7I+d5cqX4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-08-22 at 11:42 -0600, Jens Axboe wrote:
> Any chance you can try 4.18 at least?

Of course, I tried the kernel.org sources now, sys-kernel/vanilla-sources-4=
.18.3=20
on Gentoo. The issue is the same.

I wonder that nobody has noticed that issue that I can reproduce on many ke=
rnels
since 4.13 or even older. Is it a rare combination with my bcache, luks or
btrfs? Or hardware specific? Or scheduler specific, as even BFQ is not that=
 well
tested on btrfs like the default one.

> Schedulers are specific to the queuing infrastructure, so certain types
> will only be available with MQ and certain types will only be available
> on !MQ.

I noticed that. It's just a bit intransparent from the menuconfig, options =
don't
mention if a scheduler is working on MQ or not, like CONFIG_IOSCHED_BFQ.
There it's written in the description, while CONFIG_MQ_IOSCHED_KYBER has th=
e
note in the name.
Actually MQ schedulers could depend on BLK_MQ to make it obvious.

Best regards,
Massimo
--=-g/wU6nwrQoj7I+d5cqX4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEjdL61EKP3VOAA+I8lQj3p5VSZjIFAlt/pbwACgkQlQj3p5VS
ZjLVbhAAiSmWLiGV5zu+M11FU6Z4W5Emdl6fZHJG9w424mH/7A0hRwgpVup79uJ3
nHW7W/oZMc5g3dshJ6raZICSiEnWc4ichvgXcTIY5jNQdmntG1KstFszucT8z7iP
MC5NfteTJGjgvH//INcIkId71d8BFbynqUNZA8uYGsNrq8i1IjTYb3VIhtnafGWf
dei2cKwGhFVKA7vOZkSRaD/u1eR7lKfoLewUuVC09ufVrKlkiAZ1fEEUc0RL6UZ9
/LGkBwoywBGSaLfIk306P3mWfJN4Bc+X2qO/N3Nqq1f4jbtG+7NYnGhi+t9+1zXu
/0/GxnGJ8OAwd4i83bMwahaYNu3/5Zqe6/UlU3Vq5/UHWdjTyFoWYs29IA6cL+Kg
65+h6YQ8hY78pvhnicH756+OGkf40rr+NIwzAZZ4nqfFiLn/lzJlVQcP4E9bY5ni
XTDUfprpeAUDeuFtD9gDtdm523dKXXsKcDOMJGpeeIJgDwagG/g8QuOrr0xFkQ+c
5m3BxGAdTBQeSbjxh34Av53sK8CRr7mm8bYNYepBXpYnfTMzrtfKzRRoqcr3Dv7E
HnHk12l3SeyljRpmfQ9UtkrAIyjW0PbVwu7B3WekFV5Sh6NO1tTYJXj0MBzCJGov
aTbBA0uD7jgQta6SrHlWk9Z65YtI4Ax5eI6H4sU25rmGSAf11mQ=
=vvfj
-----END PGP SIGNATURE-----

--=-g/wU6nwrQoj7I+d5cqX4--

