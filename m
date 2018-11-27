Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67207C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB7321104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB7321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeK1AW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:22:26 -0500
Received: from shell.v3.sk ([90.176.6.54]:60411 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbeK1AW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:22:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 76466C796E;
        Tue, 27 Nov 2018 14:24:28 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id e3M4uqGd4L1o; Tue, 27 Nov 2018 14:24:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9802FC796F;
        Tue, 27 Nov 2018 14:24:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IyYmhzCnziUv; Tue, 27 Nov 2018 14:24:25 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D6879C796E;
        Tue, 27 Nov 2018 14:24:24 +0100 (CET)
Message-ID: <374b76346ab53851632e8d300164022db9ed9a3c.camel@v3.sk>
Subject: Re: [PATCH] Fonts: New Terminus large console font
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     nimrud <amanoeladawod@gmail.com>, gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 27 Nov 2018 14:24:23 +0100
In-Reply-To: <20181126034734.9423-1-amanoeladawod@gmail.com>
References: <20181126034734.9423-1-amanoeladawod@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sun, 2018-11-25 at 22:47 -0500, nimrud wrote:
> This patch adds an option to compile-in a high resolution and large
> Terminus (ter16x32) bitmap console font for use with HiDPI and Retina screens.
> 
> The font was convereted from standard Terminus ter-i32b.psf (size 16x32)
> with the help of psftools and minor hand editing deleting useless characters.
> 
> This patch is non-intrusive, no options are enabled by default so most
> users won't notice a thing.
> 
> I am placing my changes under the GPL 2.0 just as source Terminus font.
> 
> Signed-off-by: Amanoel Dawod <amanoeladawod@gmail.com>

I've wished for a 15x30 font for quite some time, because that would
look good on an OLPC laptop screen that's 19cm (7.5") at 1200x900. A
15x30 would give me 80x30 characters, while a 16x32 would give me
somewhat less practical 75x28 with extra space around.

I'm wondering what resolutions are you targetting? Perhaps a 30x15
would do just as well, and if we need an 32x16, then we could perhaps
just add an ability to scale one of the existing fonts by a factor of
2.

Cheers
Lubo

