Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F680C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27853217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfBQWtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 17:49:03 -0500
Received: from ms.lwn.net ([45.79.88.28]:38016 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfBQWtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 17:49:02 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 41C02300;
        Sun, 17 Feb 2019 22:48:54 +0000 (UTC)
Date:   Sun, 17 Feb 2019 15:48:19 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: change linux-4.x references to 5.x
Message-ID: <20190217154819.515efcf2@lwn.net>
In-Reply-To: <20190212144126.18487-1-arnd@arndb.de>
References: <20190212144126.18487-1-arnd@arndb.de>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 15:41:01 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> As linux-5.0.x is coming up soon, the documentation should match,
> in particular the README.rst file, so change all 4.x references
> accordingly. There was a mix of lowercase and uppercase X here,
> which I changed to using lowercase consistently.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[...]

> -This will let you move from something like 4.7.2 to 4.7.3 in a single
> +This will let you move from something like 5.7.2 to 5.7.3 in a single

Heh...I like a guy who thinks ahead...:)

I was hoping somebody would do this so I didn't have to.  Applied, and I'll
try to sneak it in before 5.0 as well.

Thanks,

jon
