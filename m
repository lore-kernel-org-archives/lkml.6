Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E32C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FCD208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FCD208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756824AbeFOXi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 19:38:28 -0400
Received: from anholt.net ([50.246.234.109]:41972 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753761AbeFOXi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 19:38:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7CFFF10A1793;
        Fri, 15 Jun 2018 16:38:26 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id EIxB4uYq_I3X; Fri, 15 Jun 2018 16:38:25 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0FC7510A01FA;
        Fri, 15 Jun 2018 16:38:25 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 77E7D2FE462E; Fri, 15 Jun 2018 16:38:24 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        David Lechner <david@lechnology.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Stefan Agner <stefan@agner.ch>,
        Alison Wang <alison.wang@nxp.com>,
        Peter Senna Tschudin <peter.senna@collabora.com>
Subject: Re: [PATCH v4 19/26] MAINTAINERS: fix location of some display DT bindings
In-Reply-To: <5fd5928906086e37cdf8740296ee9766c85ee78f.1529079120.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org> <5fd5928906086e37cdf8740296ee9766c85ee78f.1529079120.git.mchehab+samsung@kernel.org>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Fri, 15 Jun 2018 16:38:24 -0700
Message-ID: <87vaajk4cv.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+samsung@kernel.org> writes:

> Those files got a manufacturer's name prepended and were moved around.
> Adjust their references accordingly.
>
> Also, due those movements, Documentation/devicetree/bindings/video
> doesn't exist anymore.

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlskTfAACgkQtdYpNtH8
nuhjoBAAqfjOg9SWl8EaVyho9Ektv+qc3imIyD5GVUyfMaXF9BTe7DEDj+g0QwVS
EppokorBJ2sAKatBuKmJ2kJtk6YjsOPI2BZwCNi7n1mfYAuZml9z1oSc5ByhkBBb
pcP9eb1VWfNYx00E4zSmeyOF/2TSxDMVGgKlNZb1QG2tapkx14u+DS0XRZ2hmZoc
SPYPDKup/wR6qEvyFJnjmJ+dXCty20/LvKjceV8dQtI9Uywrfd5rV8YYo3AuYDjL
C2pmL7nbHzZkQ22t4Tzg0HLPtGxKtCEoPYwyBhWxWRNgaK+zJCNxcamgI/AkEARm
p310FeTE6JEJ0Bd0uqngXS218UVDTDKVFcXRcBmAnUWlQE2ha4zX36MFCF2jelAQ
qJ0ELS11Wl/dbg8VQUkTsicFdjB6t/+Huuq8b+aOxrQ+GJClBllFAQCcnp+FJf0q
3zwSosP94OSaIQD2X1Ertwg07MGVj/NIvcJtlcil9y+xdQXGkXwd1B/htBEwekf2
q1DtvNFsS6vCSBM4ZlyAjOAULaVNiRE4XEzxTi1s9pLwpm33bepczPPi22T3E+vu
rEJjqXiE3yQNxslR0hnod7h95ug8I8sWY9m2hBblIV+gi+TfV6PQd5t7Ft/4hOOC
JLKUyH+jRhj1wFCgfHKQk5N16zEVGIG0j9U6A3kRydrQy29SMS8=
=q69g
-----END PGP SIGNATURE-----
--=-=-=--
