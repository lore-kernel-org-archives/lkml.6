Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CE3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E94E21726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfBAQYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:24:33 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:19777 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfBAQYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:24:32 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id CE02013F8AE;
        Fri,  1 Feb 2019 17:23:45 +0100 (CET)
Subject: Re: [PATCH v2] of: fix kmemleak crash
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>,
        Sachin Nikam <snikam@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>
References: <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com>
 <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
 <20190121143704.GE29504@arrakis.emea.arm.com>
 <CAL_JsqKQb34zVNTzo9DLNiDwmWGxkrKezSOjwCUPAvgzUoLYjg@mail.gmail.com>
 <20190121174234.GC26461@rapoport-lnx>
 <2bb30550-435a-046c-4f45-21dd594aa695@free.fr>
 <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr>
 <CGME20190123055509epcas3p18a6d66fa08412f2308cb2c1997328ea8@epcas3p1.samsung.com>
 <20190123055414.GA4747@rapoport-lnx>
 <78f4ea8a-996d-038e-9e33-5ff02fa2c43f@samsung.com>
 <20190123123143.GE4747@rapoport-lnx>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <f2bdb061-2fdf-ee78-fc46-a38ebb40b03f@free.fr>
Date:   Fri, 1 Feb 2019 17:23:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190123123143.GE4747@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2019 13:31, Mike Rapoport wrote:

> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/of/of_reserved_mem.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)

Thanks for the patch, Mike.

Whose tree should this patch go through?

Regards.
