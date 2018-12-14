Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C42AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97FA206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbeLNPoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:44:19 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:34631 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbeLNPoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:44:19 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 3C29613F86F;
        Fri, 14 Dec 2018 16:44:08 +0100 (CET)
Subject: Re: [PATCH v3 0/9] Regenerate arm64 defconfig for current kernel
To:     Olof Johansson <olof@lixom.net>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <4344b70b-41fb-5ca0-281e-d4b5500b6256@free.fr>
 <20181211154159.54yaytbp4pyjqjhg@localhost>
 <20181213065113.sz7ce7kpkenyu3dy@localhost>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <78bcd495-087e-aabf-6462-8950ee986732@free.fr>
Date:   Fri, 14 Dec 2018 16:44:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213065113.sz7ce7kpkenyu3dy@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2018 07:51, Olof Johansson wrote:

> I've applied the patches from the series that were still needed. When
> re-running savedefconfig as part of patch 1, several of them were no longer
> applicable.

FWIW, Arnd had suggested that the first patch should only deal with the
trivial case (moving options around), and subsequent patches should deal
with removed options, and corner cases.

IIUC, you folded "trivial + removed" into a single patch. I suppose it
does make the commit log less bloated ;-)

Thanks for merging the series.

Regards.
