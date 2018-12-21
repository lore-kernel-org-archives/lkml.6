Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B854AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CBF2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391368AbeLUSFf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:05:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387726AbeLUSFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:05:34 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77680218E2;
        Fri, 21 Dec 2018 18:05:33 +0000 (UTC)
Date:   Fri, 21 Dec 2018 13:05:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [for-next][PATCH 09/24] seq_buf: Make seq_buf_puts()
 null-terminate the buffer
Message-ID: <20181221130532.532c51ea@gandalf.local.home>
In-Reply-To: <20181221130021.6e66484f@gandalf.local.home>
References: <20181221175618.968519903@goodmis.org>
        <20181221175656.827708767@goodmis.org>
        <20181221130021.6e66484f@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 13:00:21 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:


> > Can result in:
> > 
> >   Message is fooÂªÂªÂªÂªÂªsecret  
> 
> Sending this via quilt, and that we have non UTF8 characters causes
> LKML to blow up.
> 
> There's a couple more patches with this issue. I'm going to fix up the
> change logs and rebase them.

Actually, this change log should have them. Bah, I'll just ignore it.
The repo that gets pulled is fine.

-- Steve

