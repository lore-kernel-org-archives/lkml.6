Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8849EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8D6214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8D6214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeGCTwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:52:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:54066 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752732AbeGCTwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:52:33 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4166D2DB;
        Tue,  3 Jul 2018 19:52:33 +0000 (UTC)
Date:   Tue, 3 Jul 2018 13:52:32 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reed_solomon: Fix kernel-doc
Message-ID: <20180703135232.669c9554@lwn.net>
In-Reply-To: <CAGXu5jKN2HTno=1MfAug+pn0yf82tV-YAWURpx6v_xk7spc4mA@mail.gmail.com>
References: <20180703194354.21614-1-willy@infradead.org>
        <CAGXu5jKN2HTno=1MfAug+pn0yf82tV-YAWURpx6v_xk7spc4mA@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 12:47:44 -0700
Kees Cook <keescook@chromium.org> wrote:

> > The current doc build warns:
> > ./lib/reed_solomon/reed_solomon.c:287: WARNING: Unknown target name: "gfp".
> >
> > This is because it misinterprets the "GFP_" that is part of the
> > description.  Change the description to avoid the problem.
> >
> > Signed-off-by: Matthew Wilcox <willy@infradead.org>  
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> Jon can you take this?

Will do.

Thanks,

jon
