Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30884C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD542064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+z6mlZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD542064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbeH2VJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:09:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbeH2VJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:09:35 -0400
Received: from localhost (unknown [171.76.77.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80EA1205C9;
        Wed, 29 Aug 2018 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535562703;
        bh=oYI/XNaIVT+J0P9al//OL+TiuWt27DAlKg/m/F2yoEI=;
        h=Date:From:To:Cc:Subject:From;
        b=T+z6mlZVl7re8X8ghae0EtVCC58oADWlSBaSf95H5IRxohzgjjV0qyGfOwsydjII8
         w13TJIv/OybyNTcm3qvPx0XP7fh0Dvw/nFnLBOH4kZXxJiaWe4gExl8FUxxTBtm50m
         y79Tyb5jUAoGBgAZOOS0Hpw/yWnIdWx4IHY5w9Pc=
Date:   Wed, 29 Aug 2018 22:41:33 +0530
From:   Vinod <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Add SoundWire tree to linux-next
Message-ID: <20180829171133.GL2388@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

I maintain the SoundWire subsystem which get merged to Linus thru Greg's
char-misc tree. I would now like this to be added to Linux-next and after
the Greg's char-misc tree.

Please include next and fixes branches of the soundwire tree located at
git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git

Let me know if you need more details.

Thanks
--=20
~Vinod

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbhtPFAAoJEHwUBw8lI4NHQiAQAM+gZfW5IsogaNnH7EKT1RYE
2qVt6LanUCjwlyAKwUIah12pY4hZHasxY5JBBTBUZZSk/EhyRs8y/qVE76mjgOvj
QBA7xJKPt6ua5DKcWFQUoNbDMnJ+ot20XYnnj6F6LIgDwSCBWC9ZZRC9Bm1gccnV
cJWle/LjShd2h6+87b7zVIOg2Ht1A+2eP333xmxbMN3iJR8SZfPRr2FjLXmpH/yC
qRsQ6qmEhpka/+loflYm4k0jP2e23BdTgC6OJGFzfYWcuxJv+NK2YstuJX6coFx8
IhuLWYq3yj00uDmLasWYee5X8vFTkCdADTKO4fqgc9QZXWqbkRLd0IFUvr2M+5wt
76RLPMuDMSd9kwogeeukccCAD0VWC+y0SlRn0WHzaLyQjvdPjsX3vxmDyiWAEH+U
HtphDTuf0X9bIinOPQqAZiI9Odklx0FbmXZHrDTSfRegCCpcZ67bSkfCzzoMNDAT
OM1zewlZEi0rkeZkHwOFHtMVTDFkVargdQ5YAQ4gC5oSAQPsNTM5AExquQjRY//W
0LrJ6eL++szEhVyrvBghybC2KCNOmOroj6MMPIlE9qhPwbeOxY4upd5GncVAv8F+
LiBEjMHunNuoz2Y2pYQj2DdAoedMDa2DVMped8k8dQ34J/yEeKOMvQPBpJNDKcZ6
GCTf3t8b9nyWyeziys+S
=kCip
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
