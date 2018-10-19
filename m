Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6701BECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C80021476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C80021476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeJSVYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:24:24 -0400
Received: from ms.lwn.net ([45.79.88.28]:50804 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbeJSVYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:24:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A1DB87F5;
        Fri, 19 Oct 2018 13:18:18 +0000 (UTC)
Date:   Fri, 19 Oct 2018 07:18:16 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Will Korteland <will@korte.land>
Cc:     gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/uio: fix a grammar nitpick
Message-ID: <20181019071816.07e80ed5@lwn.net>
In-Reply-To: <fa74b1f965d5a33d708f74d9fe8d7517@korte.land>
References: <7e426c03c0e342ade7ce86a977ef13b2@korte.land>
        <20181018123126.3e59c3fd@lwn.net>
        <fa74b1f965d5a33d708f74d9fe8d7517@korte.land>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2018 10:55:58 +0000 (UTC)
Will Korteland <will@korte.land> wrote:

> Thanks for
> the pointer to the email docs, but unfortunately my client isn't covered
> there. Still, I've used it as a guide for the kind of settings I need,
> hopefully my patches won't get mangled from now on.

When you figure out what's needed to bring your client into line, I would
more than welcome a patch to email-clients.rst providing the necessary
information for the next person who comes along!

Thanks,

jon
