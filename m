Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CABECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB5A20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB5A20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388619AbeGWQYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:24:50 -0400
Received: from ms.lwn.net ([45.79.88.28]:34746 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387831AbeGWQYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:24:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5AD5C9B0;
        Mon, 23 Jul 2018 15:23:06 +0000 (UTC)
Date:   Mon, 23 Jul 2018 09:23:05 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] Documentation: document ktime_get_*() APIs
Message-ID: <20180723092305.1f44b9f6@lwn.net>
In-Reply-To: <20180710144737.1136856-1-arnd@arndb.de>
References: <20180710144737.1136856-1-arnd@arndb.de>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018 16:46:41 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> As Dave Chinner points out, we don't have a proper documentation for the
> ktime_get() family of interfaces, making it rather unclear which of the
> over 30 (!) interfaces one should actually use in a driver or elsewhere
> in the kernel.
> 
> I wrote up an explanation from how I personally see the interfaces,
> documenting what each of the functions do and hopefully making it a bit
> clearer which should be used where.
> 
> This is the first time I tried writing .rst format documentation, so
> in addition to any mistakes in the content, I probably also introduce
> nonstandard formatting ;-)

It looks good to me - I guess you really can teach an old dog new
tricks :)

I've (finally) applied this, thanks.

jon
