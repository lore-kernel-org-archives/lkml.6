Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id oOV0FdYcHFvwGgAAmS7hNA
	; Sat, 09 Jun 2018 18:34:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 27DBB608C1; Sat,  9 Jun 2018 18:34:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="InhQSZz8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 56791601C3;
	Sat,  9 Jun 2018 18:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56791601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933167AbeFISef (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 14:34:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753510AbeFISdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 14:33:20 -0400
Received: from mail.kernel.org (unknown [91.207.57.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B9D320874;
        Sat,  9 Jun 2018 18:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528569200;
        bh=kbxvhLXUx47w5cpwgM6km5MoWmj4yVw3Y9GLcaqeMIg=;
        h=Date:From:To:Cc:Subject:From;
        b=InhQSZz8G7Nj5uppErZr2tyC2YdGwiiLUFlnqicmYvzMgtBSzNQTllYaz4AnkfV9r
         G5SS79sKOyiY2ol+K4twueGWPIDnEqThyM/CKY3H0O4xCQ/SWz0aL4cisoC6uV/4mM
         fcA++33lSJz3QY1VBFD9zUfkjjJIgZFrFURGoBZU=
Date: Sat, 9 Jun 2018 20:33:16 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for hsi-4.18
Message-ID: <20180609183316.pzfbcndn32gb44o7@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yiv77ushflonumne"
Content-Disposition: inline
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yiv77ushflonumne
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Just one patch for the HSI subsystem this time:

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-4.18

for you to fetch changes up to 70d52ba9e57eb93cfe916f7f4d14a09750890ffd:

  hsi: clients: Change return type to vm_fault_t (2018-04-17 16:05:26 +0200)

----------------------------------------------------------------
HSI changes for the 4.18 series

* use new vm_fault_t return type

----------------------------------------------------------------
Souptick Joarder (1):
      hsi: clients: Change return type to vm_fault_t

 drivers/hsi/clients/cmt_speech.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--yiv77ushflonumne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlscHWsACgkQ2O7X88g7
+pq82A/+I81DpXTfZ0ll2ynWhnl8YAG7JJqXmjfNLUtX5omLYP8V99sU5V8Hy/eM
SnNysAsWVWRCrQ/OQ6Bt/X/lYS8dTPxh9DTznRbj5Mi6nBL2CB0MiHq6EDiKIjxf
EZ0Zj6WIFcazk39kyaKWmILVLO9xZL0ro+JCUt6eS1ySwe5VYZdAv6sEKvYQR6un
vLc87VOZ3PliILRwds+IKr/GQ4snjSwIh7Qr8VAe62rcz6ar/islArjB8oBMIVRJ
rDn6TG3xy975FSvyZkKJtcF+onYNr2iRzYjBvvKOH9uKhVwBdreOcUgAOJWV7H6j
R6m3PxRMp24X8+SiASDEiYT+SB3yfl0tElZWIvpF9jLKpIDIpLAXIPpoh9MCHLY9
cFZxTbaUDg62u3FIMgfbqA/+J9fx5EeQ2Q3KHe6ILXbBKbBtG4llJ50m35qDtQGK
saQJ4nutCkBhV9u8g9kjInYs+E6KaWoJxQN7kdLBu5DqEckJ5yY4a1BSPJJ8DXWa
orQ9UlBg2KryNTmW+xaOk9stiNIADiAXHF02HBV/ZxrXr2s3VLbAFrQxvhT0gw47
peaQNAy2FlkmAKxLzwmD7O1jD5jhr9df5K/rCussEBs9Oh8rwJkmgEzYbCoEvRzS
8YTEJ+R5hS5O/KuYp0KOM2MS6yEAmgfySoDgBNYS66yoCe9Yl9w=
=eob4
-----END PGP SIGNATURE-----

--yiv77ushflonumne--
