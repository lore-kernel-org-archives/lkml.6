Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8586AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B7B20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B7B20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbeLFRO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:14:29 -0500
Received: from ms.lwn.net ([45.79.88.28]:33840 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbeLFRO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:14:29 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C88532DB;
        Thu,  6 Dec 2018 17:14:25 +0000 (UTC)
Date:   Thu, 6 Dec 2018 10:14:20 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Uwe Kleine-Knig <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Huang Shijie <sjhuang@iluvatar.ai>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: devres: note checking needs when
 converting
Message-ID: <20181206101420.24aad198@lwn.net>
In-Reply-To: <1543668269-27207-1-git-send-email-hofrat@osadl.org>
References: <1543668269-27207-1-git-send-email-hofrat@osadl.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  1 Dec 2018 13:44:29 +0100
Nicholas Mc Guire <hofrat@osadl.org> wrote:

> There are a number of cases where conversions to devm_* API have been
> done but developers forgot that this conversion may imply that return
> values need to be checked for failure of internal resource handling
> like allocation. While this should be clear, it does seem to be a
> relatively common issue with API conversions or maybe "managed" is
> being misunderstood ? So add a note to make the scope of "managed" clear.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Applied, thanks - let's see if things get any better!

jon
