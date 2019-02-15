Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B700C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC85206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550222756;
	bh=AQgF3anftLUM0XZ4TVygsQarUlLNVoOl7ngiH7RnVvE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=M/9qeeIX2b4Ow3HYFqqBjxNUnFiG1HSm1HzEumF6SVGAP3QrrGLt6td6FuKqxGdwc
	 4z0RdELuGnKtdtX5wWGER/Ct736EQtTj88Yk7cHRAPP5FEVRStxzWHyS2gs2oRHnrv
	 4DopAgntPkxOA7WOs/QR2jHWbk/iieogTEhC8qnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392649AbfBOJZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:25:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392338AbfBOJZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:25:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E470206BA;
        Fri, 15 Feb 2019 09:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550222733;
        bh=AQgF3anftLUM0XZ4TVygsQarUlLNVoOl7ngiH7RnVvE=;
        h=Date:From:To:Cc:Subject:From;
        b=ixryRa+AXKRsscD06bI59I/Ed55elzRUlomvXOzCfotw6WEnhNAdNakX3ZLJTVJDT
         ZMgYsJrXwIgD8FuYjiMWODigj4Dyhc9Ttg1rk6mRQzuaWGFx9FAEAhDZ1bJUvFZKZ3
         aSXBGHz0GpKUu7KoHtWk+CU0Z7CDaeSF0mdvOVYQ=
Date:   Fri, 15 Feb 2019 10:24:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.20.10
Message-ID: <20190215092459.GA1536@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.20.10 kernel.

All users of the 4.20 kernel series must upgrade.

The updated 4.20.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.20.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile           |    2 +-
 fs/binfmt_script.c |   10 +++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

Greg Kroah-Hartman (1):
      Linux 4.20.10

Linus Torvalds (1):
      Revert "exec: load_script: don't blindly truncate shebang string"


--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxmhWsACgkQONu9yGCS
aT5Xag//cAJpavtgTRnGqs12LbeI/xdckbgUAZw/UYGYEv6umqW+4laR8mcXIT9R
6Wmu8AKDONoNMfXwvey+JSAKTVOTTYgw9XKsaHfDMjfNzCCgOcpIP98OlzU/0XdI
7uo4Zv9jMKmPlrC0pJpRUlXBuJUIa1jdcNv2sXG9ZscCNhS6Lfx5fQLQeFmrwkAb
C2wr00GoGAoa7vKpRRwq+zXJYJIgiWOJU6Xd+cGnk7/9+4Rv2YqI9TcNdiAG01aX
sAtjCxUgUTNuPx8psYLsrU/+IGZlPbV++IeYbr/DVkhif7hhH1DohQGjfRSi1TkZ
JafHOlHmXVo62LG1eH6BexXmTpA3iITJ5F70zylseUYFwThkSc2JFdfy68hU8XG+
oymRTVcZaAQawBBYyH0ngeqNQoX/fW9F40V+YPKAGVVS5w/INTR+o3c6SZlD9IdT
FM0UHm4GZ4FWDA+EHmsz0vJgR1r1F0VCP3OxO6jvrc7MXIy9HsGl19VFajfWGG/B
e7tVLr6XEDDDxLmkc60a4zvX1+Eb4NClW7l21dXnM0s6L28YbQpL12PPUkXXfYyS
ECKIr1kJo12VQtUy4SBTZUJgQZwUr+zBdvY4PAPSq1hreyrCKc0DM7y8w9iWr9XV
Mue0QsCLFZOi7lvbRict9cPhTejqCfdQibzieT78VUSmKPkfzQ8=
=1yw4
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
