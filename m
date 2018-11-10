Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FA9C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9591E20854
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9591E20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeKKBqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 20:46:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57472 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbeKKBqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 20:46:45 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OzHmmV0Nm-7s; Sat, 10 Nov 2018 17:01:16 +0100 (CET)
Received: from zn.tnic (p4FED3B23.dip0.t-ipconnect.de [79.237.59.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 379111EC01F6;
        Sat, 10 Nov 2018 17:01:16 +0100 (CET)
Date:   Sat, 10 Nov 2018 16:58:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Mark Gross <mark.gross@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ranganathan Desikan <ravi@jetztechnologies.com>,
        "Arvind R ." <arvino55@gmail.com>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: clean an indentation issues, replace spaces for
 tabs
Message-ID: <20181110155851.GC20023@zn.tnic>
References: <20181109133757.21471-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181109133757.21471-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 01:37:57PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to clean up an indentation issues, replacing 7 space chars
> for a tab and also inserting a missing indentation

Pls see section "2) Describe your changes" in

  Documentation/process/submitting-patches.rst

about how to formulate your commit message. Especially this:

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy to
do frotz", as if you are giving orders to the codebase to change its
behaviour."

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/edac/e752x_edac.c   | 4 ++--
>  drivers/edac/i3000_edac.c   | 4 ++--
>  drivers/edac/i5000_edac.c   | 4 ++--
>  drivers/edac/i7core_edac.c  | 2 +-
>  drivers/edac/i82975x_edac.c | 4 ++--
>  5 files changed, 9 insertions(+), 9 deletions(-)

Anyway, fixed up and applied,
thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
