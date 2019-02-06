Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03967C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A362070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="MSNgXiZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfBFSug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:50:36 -0500
Received: from narfation.org ([79.140.41.39]:37832 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbfBFSue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:50:34 -0500
Received: from sven-edge.localnet (p200300C5970C7DFD0000000000004065.dip0.t-ipconnect.de [IPv6:2003:c5:970c:7dfd::4065])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id 84A951100E9;
        Wed,  6 Feb 2019 19:50:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=narfation.org;
        s=20121; t=1549479031;
        bh=ZT2iVolpGVF/aFD0RZSwa+SRUlF7l+9DEHhvtscUMwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSNgXiZUHMcuVcu97YrAbCTq7jiNLDwZ54EJSthfY7Yagk14hPzv3VrkP1/lRyqcl
         x+wmiQ5DreAeZcnywfZVdCPgUxdwWe22XbKLnwI2jOBMLu+W4ShJ9qj0zYHBN+/rwt
         0osRJp6pPWmP8P88KN8SIiW4bviTK46IQeF5lTXw=
From:   Sven Eckelmann <sven@narfation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [patch 2/2] scripts/spdxcheck.py: Handle special quotation mark comments
Date:   Wed, 06 Feb 2019 19:50:17 +0100
Message-ID: <20661651.ZxqjWeeW99@sven-edge>
In-Reply-To: <d9eb35b2594d9cfedd8525dc32a18b40c60451b0.camel@perches.com>
References: <20190116102651.489113812@linutronix.de> <3904432.cpar7GfAiZ@sven-edge> <d9eb35b2594d9cfedd8525dc32a18b40c60451b0.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4519362.vEzlPQ4pp3"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4519362.vEzlPQ4pp3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, 20 January 2019 19.39.55 CET Joe Perches wrote:
> Well, maybe checkpatch should remove the comment trailer.
> ---
> Miscellanea:

In case you are waiting for me (haven't seen it popping up in linux-next): 
yes, this patch solves the problem for me.

Tested-by: Sven Eckelmann <sven@narfation.org>

Thanks,
	Sven

--nextPart4519362.vEzlPQ4pp3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxbLGkACgkQXYcKB8Em
e0Z7bxAA1cAsljRChsAqqXoGxC0jGvcS3o1NJmwBWwkbMn1TnSx7JxmxdFm35xmQ
POC4mgN4O/T1Y4hzKawm0f74jsTTIsU8k6JaOqVEIMgzrtFkavvymkWzfXKgSA0k
xpmNkov6VqOuy4XwqHvBxNwO3qt7B0bUknbVzPxpSVr6eLPkPaoGN7l1hbUK/8dK
gZ2s4OCuqdVO/XDm91KblMwOmcm0M6EPafRBAV+7AKfMumIzQCmUoBn2gKuQt4JG
W1Ho7wd4Js1cAMj0WUFHNb8Lrx7fOS97R0xjsM02Tb9SN8yqQPOCblOncLcpnUc5
cJy8Z2e/0mQYvVROGQEkOXGFvj0AbYp2fcrNPmvm2NRFvpCDo/NpZ4vAIZ7u4/0x
vPgIgUWG+N3mVTqPwsmQlXTgznr754iId+UPITu4Iy6yRp9E+chG24+zEg04Q8tG
OsDS4guVvgr4tVjnG/Oin5E6ax/j2t6OnlNzwG8WVrs5VB0WOfnz2tqTaeyTMuoc
/1V+6NZ4HIaLjXmVEOuOJl7kyw7Q5KWpQcutfQeHOQSxZjF936SxfVtHEmSaHvaR
fGmOifCr44KVAQyfM4NxIgELarMydomgUr6jg96yitkpjL8SqVqmGQYjl8F2GFiF
5Kiqk/9CYvD7UQf9hU74GD05fRVUqIleowDeqFA8D2Fe/BrN6hA=
=wqKT
-----END PGP SIGNATURE-----

--nextPart4519362.vEzlPQ4pp3--



