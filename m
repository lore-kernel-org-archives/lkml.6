Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBDEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC87205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550222576;
	bh=7NK07Qt7EbdU8JRgzbggaCZQBCeM0Cp9S+rc1XH8b08=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=0PA5DNAeRDduuyVM13RZDH7ehiUaB9ZL9bkiMf9GTs3iLNV3zuwtv1tO+kpvCWUD4
	 /jR9X8m+PNeQi+DFOPAzeAAEdVVqtOjyWZzD912QAP1IBsXHXjGwG8j31eASeYB8He
	 2/oeazy2+qfGHarGs0vLY3p51FQOlvEH7pUGW1mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404771AbfBOJWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:22:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404604AbfBOJWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:22:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CB192190B;
        Fri, 15 Feb 2019 09:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550222558;
        bh=7NK07Qt7EbdU8JRgzbggaCZQBCeM0Cp9S+rc1XH8b08=;
        h=Date:From:To:Cc:Subject:From;
        b=Xv8RjCJ3qz55TMeh7k6vN32UYbqonlMSSR3ww5TsZOCkkcTw2rFxrfvQb1D5q/y1Q
         1z/7YIuKhzz8wCzUuUhxLMtxigLI51P/QpLzUQ7qs5d8MtbYIE79A9tpDXctCDl5lq
         htxRMBNESbb5hb2sKXmTLiMoQKRdlfVJNFDuGgzc=
Date:   Fri, 15 Feb 2019 10:22:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.158
Message-ID: <20190215092210.GA961@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.9.158 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile           |    2 +-
 fs/binfmt_script.c |   10 +++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

Greg Kroah-Hartman (1):
      Linux 4.9.158

Linus Torvalds (1):
      Revert "exec: load_script: don't blindly truncate shebang string"


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxmhMIACgkQONu9yGCS
aT7c2BAArvJwe8wSpmuBl1ZNM4+SRi8oyLnhaQlIwrLu9laCM8XHxz5B3lF3RnbW
gnKzgzXXxIlAb0a0+7LlSFaEXJ9VAfUOtnZu6Cv9STaY5u0E1MJDsGhkAnZfq0G+
+YUTPX0uDK9ZGRTaiJJIIMkPWGKRNVTWV6qJcSe3jPIVStJLTD0XEWsjVepdLcvG
ZCK4AKloxsZClxeQU8ax5ieNZoMTun4nhVxkDGmhufDss1bCn1MOJrONP7LVLOij
SLJiyQ9Ms15LqsMIDr3rLvAvp4Q31YQPrMdaN4azgZsFsQrO6Xb0+zzhYUON9DPl
IsSiP5rlM102owHSlGaqvxZ2D93tusRPuDzRjuLf1CsB189oria0CtBUsS6OrQI8
z4EzO4Igr9q6c8oftN9r/wGQemgQGyMzs7AfQ0OhqXAEnSg6qivQ3XaezrC2C5+n
jXrPPlwZRSz7vGhwzORUXANPKtQCVdt+UfX0C/IiRkcfGeUfCvAxrABeqGQaI3Nx
yAMaEDLJJvOlE/n18CoYRb9CwVnrewOkpZuJV3XCl2q0qay2SNDAwggpG8AKqBwh
KZ92p8jkiutXA6D/OO92R0Vvfv9NpLHpkCcK4tmQGGcf/lx3qMtdfIABYcJWvZa3
BartMICcomWNrsS8mvCjC4E6XPdwlWA2i/cBUKMiApoCpqP/uro=
=7R2M
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
