Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8245DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5338A20578
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbeLPTR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:17:26 -0500
Received: from zimbra.alphalink.fr ([217.15.80.77]:35167 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbeLPTRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:17:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id B983B2B5202D;
        Sun, 16 Dec 2018 20:17:23 +0100 (CET)
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id E9cj4bUYgXrW; Sun, 16 Dec 2018 20:17:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 8B5A42B52093;
        Sun, 16 Dec 2018 20:17:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail-2-cbv2.admin.alphalink.fr
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WZcyzzybzUsM; Sun, 16 Dec 2018 20:17:22 +0100 (CET)
Received: from localhost (unknown [82.120.188.200])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTPSA id 4ED462B5202D;
        Sun, 16 Dec 2018 20:17:22 +0100 (CET)
Date:   Sun, 16 Dec 2018 20:17:58 +0100
From:   Guillaume Nault <g.nault@alphalink.fr>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     James Chapman <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] l2tp: Add protocol field decompression
Message-ID: <20181216191758.gosagnvrp6seqcdb@kdev>
References: <20181214175921.6859-1-semen.protsenko@linaro.org>
 <20181216162605.qn2jjbyb2bgcbxgq@kdev>
 <CAKaJLVtG=BiLHe=3X57hBgrrc-FrHG6C1vbq96wDqeWwrEP52w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKaJLVtG=BiLHe=3X57hBgrrc-FrHG6C1vbq96wDqeWwrEP52w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 08:36:42PM +0200, Sam Protsenko wrote:
> Hi Guillaume,
> 
> On Sun, Dec 16, 2018 at 6:29 PM Guillaume Nault <g.nault@alphalink.fr> wrote:
> >
> > If you all agree, can we please revert this patch and properly
> > implement PFC in ppp_generic.c?
> 
> How about instead of reverting I will try to provide the patch
> extracting duplicated PFC code (from L2TP, PPTP, etc) to
> ppp_generic.c? This one fixes actual problem, and if we are going to
> add it to ppp_generic anyway, why not do it in one patch? I'm willing
> to do this work in next few days. Hope there is no rush with revert?
> 
Hi Sam,

Yes, no problem. Thanks for taking care of that.
But please try to get the code ready before net-next gets closed.

Guillaume
