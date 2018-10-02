Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9281FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C4620878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=firemail.cc header.i=@firemail.cc header.b="0MCsaJbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C4620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firemail.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeJBMog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:44:36 -0400
Received: from cock.li ([185.100.85.212]:45950 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbeJBMof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:44:35 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1538460181; bh=+zKFz1IHmEi3kOni9XY+JImwYk7a0+4bn98wwcS0OjQ=;
        h=Date:From:To:Cc:Subject:From;
        b=0MCsaJbfx2+UaPG6gGtu4nSpKgh3OOZDiHydL6wUztaoHCni5xltnzLyPsWDuG7Ym
         h2DEe1/QB5AYpNq6/0WHx4n1gbrr3nHoaVAxSu17wSaX1xE7qngjnthqq02PdZK6IB
         VMA/EfCyHLgJrC3eudGENEQyjgmMuJY6rvFtf7LpUbQPJnVFzJU1lxCxoG+rTDm7BD
         mgE6N/zcVbAyx+MeD4nPSYsgI0tCN9TNed7glUWne0V9GOjb4lH8W7m2zJ6nLQOq7D
         wStuIFz+8HZ4tZ5Co7kCCfCiJO7C2hriOYVS5PXNyn4NKZD9zfb3/UtQmN5d00rD7z
         rYQzrsdFte5dg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 02 Oct 2018 06:03:01 +0000
From:   clarityabovecompulsion@firemail.cc
To:     linux-kernel@vger.kernel.org
Cc:     martin.espinoza@gmail.com, scott.ferguson.debian.user@gmail.com,
        debian-devel@lists.debian.org, debian-ctte@lists.debian.org,
        debian-vote@lists.debian.org, debian-project@lists.debian.org,
        pascal@plouf.fr.eu.org, yaro@marupa.net,
        cbannister@slingshot.co.nz, andreimpopescu@gmail.com,
        ghaverla@materialisations.com, debian-mirrors@lists.debian.org,
        debian-security@lists.debian.org
Subject: The GPLv2 is not a contract. It is supported by no consideration.
Message-ID: <24036503356668916a0ea41961456711@firemail.cc>
X-Sender: clarityabovecompulsion@firemail.cc
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> by drinkypoo ( 153816 ) <martin.espinoza@gmail.com> on Monday October 
> 01, 2018 @10:21AM (#57403506) Homepage Journal

> >What consideration was given?

> The right to redistribute was given in exchange for use of the license 
> for one's own code. Something for something. What was your question 
> again?



Incorrect.

The permission to redistribute was simply given, gratis, by the grantor.

He asked for nothing in return, and, infact received nothing, not even a 
promise of compliance.

At a later date any of countless licensees might decide they wish make 
derivative works based upon the copyright-owner's property.

By law this is barred.

However the copyright holder here has magnanimously granted that the 
licensee is, contrary to the default rule, permitted to create and 
publish derivative works provided that they use the same license as the 
original work.

Here the copyright holder suffers a detriment. He is payed nothing for 
this forbearance (no consideration).

The licensee does not suffer a detriment: he had no right to make nor 
publish a derivative work to begin with.

The extending to him, of permission, is a pure gratuity.
He payed nothing for the change from "You may not create nor distribute 
derivative works" to "You may create and distribute derivative works 
under the same license as the original work".

