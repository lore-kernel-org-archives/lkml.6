Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED31CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02B0240BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02B0240BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbeGESqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:46:33 -0400
Received: from anholt.net ([50.246.234.109]:33020 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753838AbeGESqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:46:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 1194710A1860;
        Thu,  5 Jul 2018 11:46:32 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id QdVZxLFC8A4r; Thu,  5 Jul 2018 11:46:30 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id DEC2210A0F6A;
        Thu,  5 Jul 2018 11:46:30 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id D1B9A2FE2D94; Thu,  5 Jul 2018 11:46:29 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, svptas.linux@gmail.com,
        brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com,
        ajitn.linux@gmail.com
Subject: Re: [PATCH v2] gpu: drm: v3d: use new return type vm_fault_t
In-Reply-To: <20180704164215.GA4583@bombadil.infradead.org>
References: <20180704145556.GA11036@jordon-HP-15-Notebook-PC> <20180704164215.GA4583@bombadil.infradead.org>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 05 Jul 2018 11:46:28 -0700
Message-ID: <87r2khtta3.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Jul 04, 2018 at 08:25:57PM +0530, Souptick Joarder wrote:
>> Convert v3d_gem_fault to return vm_fault_t
>>=20
>> Instead of converting an errno into a vm_fault_t ourselves, use
>> vmf_insert_mixed() which returns a vm_fault_t directly.
>>=20
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>

Thanks!  I touched up the commit message and pushed to drm-misc-next.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAls+Z4QACgkQtdYpNtH8
nugzig//SmJNOJKCla5dyAiyJY24Povn+jp6dksbYMtaZwgmqihLFGRUW41xJAyk
nfU+q9uIbZSp6UP8RiBwiznPSQRTlopWQ0krrfk2kAExf2ppMip/5Y4T+/KIEvXM
34LutlJbhmTdk4vDVt8riAfBRCQLCpVpyyGBmDSH1SQFbMDrbRb5Q+Liua5QaWb7
tOuCthxBpCR7oemcpC8UpK/92Al91fr4l8jOO2f00PoPNvrDHoxJUxyzZZ4f5oti
HeWAPmPkiBrIJcsAMyhWKcI4DikKCGJ7vh3FutOyy70uqvZ8dh9hC/Q+VgHm+cyB
VcHOrOUeSusAW9spU7/IkBTEqj8oPyz+VPZ5KdHAtmuMP+JdsmyZAoW4Fvd/oLnh
WldFKwT8+izHdSJMAwfMeNPggoZ6ZAdFry/CVh883a7SR+sGhuCkjYJXSYXX7CKO
gs6DuAbbS5c+p/YR7Sq7HDE06C4dvef/9XjZapKvlb6i5F25pTAwK2E1IsU32/Zy
JHszmCirRBjpV7bbxVVqfVdcIUIKQ5dCHoGf+UcmNcKfYXRVFu5PQJNW9k9RhKvc
ruA4Cx7Y84BMTNHgEZN6X9OJ79Gp21DNZVO9u8NWonjS5SaPj7/ri97bssCpZ8Mj
AFCB00a0/NPtek6F+UQ21wPyDXZkyf+VaDh//PoT/YT/H1Q5rTo=
=8FPq
-----END PGP SIGNATURE-----
--=-=-=--
