Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9661BC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A49217AA
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 14:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A49217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeHRRIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 13:08:55 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:7459 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbeHRRIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 13:08:55 -0400
X-IronPort-AV: E=Sophos;i="5.53,256,1531778400"; 
   d="scan'208";a="276167689"
Received: from abo-214-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.214])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Aug 2018 16:01:04 +0200
Date:   Sat, 18 Aug 2018 16:01:04 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     zhong jiang <zhongjiang@huawei.com>
cc:     Himanshu Jha <himanshujha199640@gmail.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, yamada.masahiro@socionext.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Coccinelle: remove pci_alloc_consistent semantic to
 dectect in zalloc-simple.cocci
In-Reply-To: <5B782572.5000802@huawei.com>
Message-ID: <alpine.DEB.2.21.1808181600470.2348@hadrien>
References: <1534593700-3036-1-git-send-email-zhongjiang@huawei.com> <20180818125228.GA1000@himanshu-Vostro-3559> <5B782572.5000802@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Aug 2018, zhong jiang wrote:

> On 2018/8/18 20:52, Himanshu Jha wrote:
> > On Sat, Aug 18, 2018 at 08:01:40PM +0800, zhong jiang wrote:
> >> Because pci_alloc_consistent has been deprecated. We prefer to use
> >> dam_alloc_coherent directly. Therefore, we should remove pci_alloc_consistent
> >   ^^^ typo "dma"
> >
> > Also, typo in the patch subject "dectect" -> "detect"
>  Thanks,  will fix it in v2.
> > Otherwise,
> >
> > Acked-by: Himanshu Jha <himanshujha199640@gmail.com>
> >
> > Thanks for cleaning up, we still have few more *_alloc/memset
> > in the mainline, especially in the scsi subsystem, even after
> > I cleaned up with two long patch series in the past.
> >
>    I post same patches like *_alloc/memset in the scsi subsystem. Unfortunately,
>    Maintainer maybe do not care about the change.  therefore,  None of my patches
>   are received and rarely feedback.

Maybe they will be picked up later.

julia
