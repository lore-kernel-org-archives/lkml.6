Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBC8C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0588A21B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389742AbfBKP2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:28:17 -0500
Received: from ms.lwn.net ([45.79.88.28]:46140 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfBKP2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:28:14 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 841622F3;
        Mon, 11 Feb 2019 15:28:13 +0000 (UTC)
Date:   Mon, 11 Feb 2019 08:28:11 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matan Ziv-Av <matan@svgalib.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [PATCH] Documentation: fix lg-laptop.rst warnings
Message-ID: <20190211082811.3831e35e@lwn.net>
In-Reply-To: <CAHp75VeLCFD8EKG+hHGNUyoE9VJrFEgTvv9aD23NH49n6SMOgg@mail.gmail.com>
References: <16ce109c-69a3-1f27-7fd4-9b99c9780565@infradead.org>
        <CAHp75VeLCFD8EKG+hHGNUyoE9VJrFEgTvv9aD23NH49n6SMOgg@mail.gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 13:31:58 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> > From: Randy Dunlap <rdunlap@infradead.org>
> >
> > Fix markup warnings by inserting blank lines.
> > Also correct one typo.
> >
> > Documentation/laptops/lg-laptop.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> > Documentation/laptops/lg-laptop.rst:16: WARNING: Unexpected indentation.
> > Documentation/laptops/lg-laptop.rst:17: WARNING: Block quote ends without a blank line; unexpected unindent.
> >  
> 
> Thanks!
> 
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Applied, thanks.

jon
