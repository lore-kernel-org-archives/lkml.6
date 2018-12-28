Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3853DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 13:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041212080D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 13:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546002608;
	bh=ctV+K/hsCEVMhNgKNXlY9RjtGdNON0VBDuG/HCdZhAw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=vzQdnHNW/MB/GDc/02PwPOTB+7H8jam7UC2+EXSPh4MKrJ25U0QXaqzD4TF7qYAN6
	 kfhdl3Yj1Ev9ffICYblV1ziJ+/ap1GlTMZytnZo31D217w2aouznn1fsG9Hb7ZSlTY
	 uYl25EdE1HKpKe6HuolYpNj+n7dMRjVh/QWGyt0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbeL1NKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 08:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729401AbeL1NKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 08:10:06 -0500
Received: from earth.universe (unknown [151.217.27.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBE772080D;
        Fri, 28 Dec 2018 13:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546002605;
        bh=ctV+K/hsCEVMhNgKNXlY9RjtGdNON0VBDuG/HCdZhAw=;
        h=Date:From:To:Cc:Subject:From;
        b=BgpoKdVTws+rd6fADVV03mo67ob9+geyl9KoAZJ4g8SbgPY20qefI5B/yVjKIjlkW
         mnpfDkPKzoHi6SZR+Es0c/SK3jp6nZrz13ze4MctaqqFsCEGfRfsUp84PAUiTGtsOY
         UA6tV3q2hKW+6J7KiPBK+w0CiyveWb6JJJrjeLxA=
Received: by earth.universe (Postfix, from userid 1000)
        id F2D853C08E4; Fri, 28 Dec 2018 14:10:03 +0100 (CET)
Date:   Fri, 28 Dec 2018 14:10:03 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for hsi-4.21
Message-ID: <20181228131003.5ncwdjazidyk3rgz@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgxvcfdi2dt6i554"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xgxvcfdi2dt6i554
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Not much to say about this. The patch has been in linux-next for 3
or 4 weeks.

-- Sebastian

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-4.21

for you to fetch changes up to 3a658e09a215586918044d8f8b8358eb14fa3f7d:

  HSI: omap_ssi: Change to use DEFINE_SHOW_ATTRIBUTE macro (2018-12-05 00:16:59 +0100)

----------------------------------------------------------------
HSI changes for the 4.18 series

* omap-ssi: use DEFINE_SHOW_ATTRIBUTE

----------------------------------------------------------------
Yangtao Li (1):
      HSI: omap_ssi: Change to use DEFINE_SHOW_ATTRIBUTE macro

 drivers/hsi/controllers/omap_ssi_core.c | 29 ++++-------------------------
 drivers/hsi/controllers/omap_ssi_port.c | 14 ++------------
 2 files changed, 6 insertions(+), 37 deletions(-)

--xgxvcfdi2dt6i554
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwmIKsACgkQ2O7X88g7
+pqoEw//bK49o25VbfkMNbvrUIH8UreeP9ta+By1rwwnsdvYLk1tVF0Imk1hBhJq
RkactDqxdjVYg/g2LAamhRbvJfl5BD1ZL4vyFG4P91jsAUEKsb4jFltvUWYI3yyH
hu8oR7OT+OJXk+XOZ8f+NjLpm7ko+3fYXmK2ImJz142psaPiypDzWTsKuKpRRZeL
NYL4GjDUPWRjynPBSo028unffRUCBzD+h9aXEtf3f30E58D+0zMh50D1dAgEpmke
7piPRDUbRG6J9ouiPpvC9NTy3jzO1a5E9gTbE76cb158X+pYaEZ2H7bTDnHgqd6n
bt/dRXoU3OSPGtT8DTAopxeeLUwLaFx3fTlSUI/ba9hGK8J1X2EIgHaRlBVTDMH7
AZjaE4oRg3lAeNIEuoa4OAjZCcD7QAsdRDYyJ0C0Nwo9xi1+Ef9cYIyBunq9J/2m
aljBBMsZ1jkC0tsCDBhqhAc1rWY5JMZSxdILBQucjn6FFmizt+uTWJ2szV9hun/I
Ud5h/L9scj5H1Wd4XnUICXWlksi+Hj55+RHHlT7Fx3ZgSwK+msRZmI2C+y+LKAmr
vbjU14oHR4cXjlFzlenOE7aEyMEoL0BOm0Xf371ENn++w+tqcXaQzlZRQnFrrXnL
5qF0JUVUv0u5qQojDDXrWY6XYU1ibAH3AuzeAQWHMKy1XNW9WtY=
=H261
-----END PGP SIGNATURE-----

--xgxvcfdi2dt6i554--
