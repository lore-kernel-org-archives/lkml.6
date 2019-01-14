Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8055BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 00:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558D720854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 00:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfANAD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 19:03:58 -0500
Received: from ozlabs.org ([203.11.71.1]:54259 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfANAD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 19:03:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43dDGM6WW3z9s7T;
        Mon, 14 Jan 2019 11:03:54 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.0-rc1
In-Reply-To: <20190108084857.26756-1-geert@linux-m68k.org>
References: <20190108084857.26756-1-geert@linux-m68k.org>
Date:   Mon, 14 Jan 2019 11:03:54 +1100
Message-ID: <87muo4ds0l.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> Below is the list of build error/warning regressions/improvements in
> v5.0-rc1[1] compared to v4.20[2].
>
> Summarized:
>   - build errors: +12/-4
>   - build warnings: +405/-350
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bfeffd155283772bbe78c6a05dec7c0128ee500c/ (all 240 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8fe28cb58bcb235034b64cbbb7550a8a43fd88be/ (all 240 configs)

FYI you can get a high-level comparison of the failures between the two
revisions here:

  http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bfeffd155283772bbe78c6a05dec7c0128ee500c/compare/8fe28cb58bcb235034b64cbbb7550a8a43fd88be/

cheers
