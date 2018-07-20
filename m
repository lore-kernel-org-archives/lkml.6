Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDFEECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2544F20850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2544F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeGTHz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:55:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:36444 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725139AbeGTHz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:55:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F228AF49;
        Fri, 20 Jul 2018 07:09:09 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Miller <davem@davemloft.net>
Date:   Fri, 20 Jul 2018 17:09:01 +1000
Cc:     herbert@gondor.apana.org.au, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH - revised] rhashtable: detect when object movement might have invalidated a lookup
In-Reply-To: <20180719.234329.512279372120817504.davem@davemloft.net>
References: <87fu0kt5m0.fsf@notabene.neil.brown.name> <20180719.051440.931407144963903326.davem@davemloft.net> <87va9aqv05.fsf@notabene.neil.brown.name> <20180719.234329.512279372120817504.davem@davemloft.net>
Message-ID: <87sh4eqt82.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Thu, Jul 19 2018, David Miller wrote:

> From: NeilBrown <neilb@suse.com>
> Date: Fri, 20 Jul 2018 16:30:34 +1000
>
>> Does this ruling also apply to the bit-spin-lock changes and the
>> per-cpu-counter changes that I have proposed?  These improve
>> scalability when updates dominate.  Not having these in mainline
>> would mean I need to carry a separate rhashtables implementation for
>> lustre, which means code diversion which isn't healthy in the long
>> run.
>
> If it helps existing rhashtable users generally, then it is fine,
> since it will actually be tested by upstream users.

Good, thanks.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltRio0ACgkQOeye3VZi
gbmtog//X8squ2wPl2LDLLe34S2GMQ9uANO5+mCZLKImPqr+1EoSCyiQJeWpl6j8
oiuqDKgF2V3lixs6N6zhZCkW9QLU0PqlovVtc4RGWZg5Roa4qHeT+BTQBT0CtwHc
YFGDqYTQQAWv71aT4y2fqiNHPL4+LduZdWaEWrQwusTtzHnaVKqXdbSay0A0gMCU
LaPlCKuwPMH3ZubeP18PBPhz+rF3nb3X+KG18wCaz4CQAdqpxue7wiUFybeDimrL
Rdarh5e7YEmrWtNUpnnUBybu0RQsLm3v5pXhNGBKKGfwgecHD930bXO/weVttBXH
LK08tUhvepppHmHXgfH20ReVSGIWUuwOMWZANK+6r5idjPhZgPh5FqKWHN8NfOgE
ScE3aFAx+YJk3QKEb2WbrYQ75iJ2UNMZO8xD1BIXNy9OGZ4pK7Zq1fE2lUpFz6r1
cFI9AjVnTxuKsqfVVKyvNytjN0ab8jV1b4wyUS9UQs3bD6tAsKgEixU7mex2WWVr
DXgoihENUu3tGAENVt2Ncey1cNWFgBQHyj4tM5VduUBjinaEMchLyzpHjvd7AoS9
erHsPvuIWzbFXdWmzP0byEQILNvotLF+97rfdy69FTFhVymyn5RJFAVqWyqv1vLW
jgLMSd6erFG2KHOzFsaWi7JWXT4IBhcg7jd/QkSP0UFHkrWqYZQ=
=qfRm
-----END PGP SIGNATURE-----
--=-=-=--
