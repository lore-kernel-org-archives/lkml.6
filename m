Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108D1C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58C52086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58C52086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mirbsd.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeLLKzl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:55:41 -0500
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121]:20432 "EHLO
        herc.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeLLKzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:55:41 -0500
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
        by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id wBCAmFob025724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 12 Dec 2018 10:48:16 GMT
Date:   Wed, 12 Dec 2018 10:48:14 +0000 (UTC)
From:   Thorsten Glaser <tg@mirbsd.de>
X-X-Sender: tg@herc.mirbsd.org
To:     Steven Newbury <steve@snewbury.org.uk>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        macro@linux-mips.org, luto@kernel.org, arnd@arndb.de,
        dalias@libc.org, s@ecloud.org, catalin.marinas@arm.com,
        fweimer@redhat.com, glaubitz@physik.fu-berlin.de,
        christian.brauner@canonical.com, hjl.tools@gmail.com, hpa@zytor.com
Subject: Re: Can we drop upstream Linux x32 support?
In-Reply-To: <1544605954.117529.27.camel@snewbury.org.uk>
Message-ID: <Pine.BSM.4.64L.1812121047070.21176@herc.mirbsd.org>
References: <1544605954.117529.27.camel@snewbury.org.uk>
Content-Language: de-DE-1901, en-GB
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Newbury dixit:

>I can't help but wonder if it wouldn't make more sense to drop x86
>support from long mode than x32.  AMD64 x86 support was always intended

Do you mean i386?

x86 = { i386, x32, amd64 }

No, please don’t. I use i386 as “companion architecture” to x32,
only the kernel and actually memory-hungry things (qemu) are
amd64 binaries on my system, and this works very well.

Thanks,
//mirabilos
-- 
18:47⎜<mirabilos:#!/bin/mksh> well channels… you see, I see everything in the
same window anyway      18:48⎜<xpt:#!/bin/mksh> i know, you have some kind of
telnet with automatic pong         18:48⎜<mirabilos:#!/bin/mksh> haha, yes :D
18:49⎜<mirabilos:#!/bin/mksh> though that's more tinyirc – sirc is more comfy
