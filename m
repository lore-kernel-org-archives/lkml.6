Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB42C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220DD218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 02:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbeLVCA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 21:00:57 -0500
Received: from baldur.buserror.net ([165.227.176.147]:38626 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeLVCA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 21:00:56 -0500
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1gaWWa-0000MD-Ma; Fri, 21 Dec 2018 19:56:20 -0600
Message-ID: <930cf79431defc6fd4da2c2e64bd9a8a2c2f72bb.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Dec 2018 19:56:19 -0600
In-Reply-To: <CAJr6mf0HfJNdsHG2H6VnRMYW1WGqBr1gvwMQoWk3mSdDhO3EmQ@mail.gmail.com>
References: <5bdfa97d.1c69fb81.4aef7.c9f7@mx.google.com>
         <CAJr6mf0HfJNdsHG2H6VnRMYW1WGqBr1gvwMQoWk3mSdDhO3EmQ@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: sabyasachi.linux@gmail.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, brajeswar.linux@gmail.com, linuxppc-dev@lists.ozlabs.org, jrdr.linux@gmail.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH] arch/powerpc: Use dma_zalloc_coherent
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-15 at 23:26 +0530, Sabyasachi Gupta wrote:
> On Mon, Nov 5, 2018 at 7:52 AM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> > 
> > Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
> > 
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> 
> Any comment on this patch?

Just that FSL patches should be CCed to me, and the subject line is too broad
(and duplicates another patch posted around the same time).

I'm applying with the subject changed to
"arch/powerpc/fsl_rmu: Use dma_zalloc_coherent".

-Scott


