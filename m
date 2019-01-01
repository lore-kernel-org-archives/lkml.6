Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E114C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 20:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB20820836
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 20:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="MYSMoGLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfAAUDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 15:03:30 -0500
Received: from cock.li ([185.100.85.212]:58832 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfAAUDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 15:03:30 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546373007; bh=6FwiCcleh+lWAycTjvk5rum67ZchQonJTw1P8Ydty+c=;
        h=Date:From:To:Cc:Subject:From;
        b=MYSMoGLrtsZgvHxb/PYgJxXenQ54KOZ5L7u1t9SEA3+zIDQrxwboyYBz9i6Qn109V
         VkyNfAm+hwBgfjVeaiipAgrlLWvzdmrHx6Ip3ibAWsyczAOnkVPVJJ+kqEIwM8748o
         TuMsySB+xg0yXNBZrVgNPigsszXvy2tlW8Xm+TIInQVu211ZXD1Ux94gA2N/FTlvfU
         HGVoR6YsHwA8sT98m9bdoKYacWSJSoxX74yaTCuOFuNy5QiIyaxC+041zQdz2FkQTI
         y96Ny4DCecEkUI8H3VYgjC5D2dbsyDpu4DsmXwsUJldbneOaWrJsj181vQWu+R8dd6
         SVjHinYnZsVWw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Jan 2019 20:03:26 +0000
From:   vnsndalce@memeware.net
To:     linux-kernel@vger.kernel.org, debian-user@lists.debian.org,
        legal@lists.fedoraproject.org, users@lists.fedoraproject.org,
        rms@gnu.org
Cc:     gentoo-user@lists.gentoo.org, ubuntu-users@lists.ubuntu.com,
        misc@openbsd.org
Subject: Without an attached interest you can very well revoke the license and
 prevent all further distribution of your code, and further use of it in future
 versions.
Message-ID: <5ff2d769e29faad86bab566335820a29@memeware.net>
X-Sender: vnsndalce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The GPL is not revocable despite not being a contract. It is a license 
> to distribute software and you cannot revoke the license on already 
> existing publications. All you can do is revoke the license on future 
> publications.
>> 1014527

Without an attached interest you can very well revoke the license and 
prevent all further distribution of your code, and further use of it in 
future versions.

You can revoke the license.

What you are thinking about is the normal case of commercial 
distribution licenses - which have an attached interest (they were paid 
for, the licensor received consideration).

Almost all court cases involve such issues. Not bare licenses.

Additionally you are thinking about consumer protection statutes that 
would run against the property owner successfully suing for the 
destruction of all current now-unlicensed copies in existence.

Once the license is revoked the linux team may no-longer use the revoked 
code in future versions. They no longer have permission - the license 
they were given ceases to exist.

Normally the copyright owner then has the option to pray to the court 
that all unlicensed copys be destroyed. The court, as you put, is 
unlikely to grant this form of relief regarding existing copys that 
existed prior to the revocation.

That does not mean that Linux Team still is licensed to modify or 
distribute the code: they are not. The license does not survive the 
revocation.




