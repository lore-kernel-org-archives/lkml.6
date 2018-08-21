Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDDDC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 02:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E045721531
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 02:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E045721531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeHUFXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 01:23:02 -0400
Received: from sauhun.de ([88.99.104.3]:36878 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725731AbeHUFXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 01:23:02 -0400
Received: from localhost (p54B3375F.dip0.t-ipconnect.de [84.179.55.95])
        by pokefinder.org (Postfix) with ESMTPSA id 61E3E2D6425;
        Tue, 21 Aug 2018 04:04:58 +0200 (CEST)
Date:   Tue, 21 Aug 2018 04:04:54 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        sedat.dilek@credativ.de, Jean Delvare <jdelvare@suse.de>,
        linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>, pmac@au1.ibm.com
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler
 warning
Message-ID: <20180821020454.lpzjgq6o4mverxyy@katana>
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
 <CA+55aFxv5_8C5ApV4cDjpvAmZbn1aiKebc7yrRWBskQQbz9=Hw@mail.gmail.com>
 <1d2a7c56cc44ff639ef2943366f4868e6e5ecdfe.camel@kernel.crashing.org>
 <20180820080629.i7y4cx4wewmcyqpk@ninjato>
 <CA+55aFy+vVH4Mb-unrxm72JNORdxHaCFYEhD8iXbxo-OW0f8qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cubhey26wvbgge4a"
Content-Disposition: inline
In-Reply-To: <CA+55aFy+vVH4Mb-unrxm72JNORdxHaCFYEhD8iXbxo-OW0f8qg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cubhey26wvbgge4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

> Wolfram, should I just take that patch as-is and get rid of the
> deprecated atach_adapter thing, or will you send me a pull request?

I'll send you a pull request.

Thanks,

   Wolfram


--cubhey26wvbgge4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlt7c0EACgkQFA3kzBSg
KbZu3A/9EUEpzl7HJ4cM3qETfI4HfDRDYjINFP2gEbxZqzHN0tkH/fWrZ6CtHUeA
AdQd37K/HyFjquehDitzvtyd74lb168j/YEUklMMgqoUiNZ/pH9xtudGFov0b66T
JO/9Y0pClRlyEuZwuj4jQpwzjB5HGK9xN+TiUhwb3fwvYYWmQvQ/eDZFqZ3Y1ECC
ygBeoHbrPiZpyrOxVYixlZjh9XKGXutIDjyYL+nGgiZnLkiMFcWPwKCcacdUKmaa
SPQxMdZYNZW2XACx4vtLinqcFO5We9kWm+YbCfccWHbtOSvIY9lajScTziFjDoMO
5XzNy49t2b/so5ycwfYpPvQcP5QTJDMx/1gtx2qtTjG+ZuXsTubKRhSocCvlXZpK
k/wfrqKXW8oUxQ0a36PYKci4yajn2fPfLVh820Q57YLkNb+5aUz9xLK/mVEFVy/F
iAphIszgmzXZrAHdLGswWHc4wFybirhDWQUkpUuQxddbt3kc0RiB6Ow4Le4261SE
rFOqHfo+tfcu2FIYG7mDP5eKS//1pgJXQU6EsiVA+Cq7M9Q4QZqu4t6l8uRjeeJq
v1EtRHPE2hae8pcqcBxhYMq8L8V9dlh6FmKrtLM7gtda5dQg4WqiStY0SGSvEmmL
2G0t8qWukPhqqBwkxtd5a0MyeaiEYsLQhuxvm71+gDT8Av120wk=
=H763
-----END PGP SIGNATURE-----

--cubhey26wvbgge4a--
