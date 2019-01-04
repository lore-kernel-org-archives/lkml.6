Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348F7C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A452070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="JCjgBo4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfADG5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 01:57:03 -0500
Received: from cock.li ([185.100.85.212]:57042 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfADG5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 01:57:03 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546585020; bh=lIUAFyA3qxp9VNmRlAq8MH7Ypis1iKWdXinUxfw5m04=;
        h=Date:From:To:Cc:Subject:From;
        b=JCjgBo4AmBs3elyXRs45wvE7KTW9e+/CZLSYgmju7Ny0XOhnn+L41q5DP9Mgvdsxi
         za/lzLg9248o9l/aRgoWeVDyER/ju9PHuJS1HHOq7TOWn4jS0tjHgDGvZ4fpx5hazy
         JCUz94LCY88f8L7Wm86gSDNo7mgVBgXlrDgmLzDwgOhLIKT2n4rEwPVjUdoPmJLaSM
         xCNG+Ttu5Q2Ri4hNNz+Op3db+F2a9Dn4Z7HcyKdw3p8y8Xedt9ODZSPPvELGLSiX+c
         MK0BMrGJ/czkzxgyHB0HI9SaDuKuMe/WzSDGg1GZNuHljWm6Gi0Z080sSK1An4ZBRA
         mbFkNyGf+pETQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 04 Jan 2019 06:56:59 +0000
From:   vnsndalce@memeware.net
To:     linux-kernel@vger.kernel.org, gentoo-user@lists.gentoo.org,
        ubuntu-users@lists.ubuntu.com, debian-user@lists.debian.org
Cc:     rms@gnu.org, freebsd-women@freebsd.org, freebsd-chat@freebsd.org,
        misc@openbsd.org, esr@thyrsus.com, moglen@columbia.edu
Subject: Software distribution licenses are not "irrevocable as a rule"
Message-ID: <b4aa73e42abeb0ad1cc8191846ed8c8b@memeware.net>
X-Sender: vnsndalce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> 1016160

> The difference between you and them is that you believe that the GPL 
> requires consideration between licensee and grantor to be revocable. 
> Everybody else in the SFConverancy and the LKML disagree, a software 
> distribution license is non-revocable.

Incorrect. The SFConverancy tries to construe the clause I cited earlier 
as a promise not to revoke, thus inducing, by their argument, a 
reasonable reliance on the part of the taker that the permission will 
not be revoked.

THAT is their argument.

That clause is not what they pro-port it to be, nor would it be 
effective if not contracted for. It is not reasonable to rely on a term 
that you paid no consideration to the grantor for.

> a software distribution license is non-revocable.

Absolutely wrong. There is no such rule.

What you are thinking of, and you hinted at previously by calling the 
license a commercial license, is ... indeed, commercial software 
licenses where the taker pays consideration to the grantor.

In those cases, where there is a clause regarding revocation of the 
license, where the taker has payed for that license, the courts construe 
the contract to be one where those terms are not revocable because they 
are supported by the consideration the taker payed to the grantor.

THAT is why commercial software licensing contracts "are irrevocable".

Go read the cases. The fact that the consumer actually payed for the 
license is the deciding factor. He payed, he keeps what he payed for.

You did not pay? You did not pay linux coder 729 who is still a 
copyright holder to his code? Well your "interest" is unsupported as 
regards to that piece of linux coder 729's property.
