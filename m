Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23D7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E39320869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="fWW0lJvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeL1SgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 13:36:16 -0500
Received: from cock.li ([185.100.85.212]:55626 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeL1SgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 13:36:16 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546022174; bh=tRJ8FL/G03vWEpZXJJfaZWfc7QuMRqBAlAod0M3PgWc=;
        h=Date:From:To:Subject:From;
        b=fWW0lJvYYVVIcWYkWq1PGTXLakYvwqquHkG41MDzpzv0QkLhdrlbOmyY/NbJ3GMzp
         AZaFQtIetFZY28KaRcv++ZZelh1Npx5Hrmv0uJUJvzFb5wPUmXuaM72YV+yMUfCLTg
         EWpMLF+86CIWy1lDiCIP72ttOM9rYXMxQxcdGfcYfY2w+zWEyB0fi/9/Db94kn6Iwv
         23jhX7aotJ77IFoJJWAuq7yODFRjGRm072BbZSzllFTbslXIj8X00gVQ7gXkICdwW9
         y2PQVWqJmg6pLr7DRJb6oxi/pR55NbgwWFDeNe0Soe88bE4IBAhV2xArYlghBWANUL
         3YuxwZCnLZ5RQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Dec 2018 18:36:13 +0000
From:   vnsndalce@memeware.net
To:     linux-kernel@vger.kernel.org
Subject: FWD: 2: Re: [gentoo-user] Re: Yes: The linux devs can rescind their
 license grant. GPLv2 is a bare license and is revocable by the grantor.
Message-ID: <9f7d6c4e629ea75b0a3b73bbfd6841a2@memeware.net>
X-Sender: vnsndalce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: [gentoo-user] Re: Yes: The linux devs can rescind their 
license grant. GPLv2 is a bare license and is revocable by the grantor.
 From 	R0b0t1
To 	gentoo-user@lists.gentoo.org
Cc 	ubuntu-users@lists.ubuntu.com
, debian-user@lists.debian.org, dng@lists.dyne.org
Reply-To 	gentoo-user@lists.gentoo.org
Date 	Thu 20:42
Message Body

Apologize for the follow up:

Not being able to rescind the license is like saying someone who was
lent a lawnmower gets to keep it indefinitely with no contest because
the person who lent it can't rescind the grant to the lawnmower.

On Thu, Dec 27, 2018 at 9:39 PM R0b0t1 <r030t1@gmail.com> wrote:


