Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B13C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D012081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D012081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeLIVho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:37:44 -0500
Received: from mout.gmx.net ([212.227.15.19]:44173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeLIVho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:37:44 -0500
Received: from [10.1.1.220] ([125.120.80.114]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MLujU-1gXDkn0KWC-007nd1; Sun, 09
 Dec 2018 22:37:33 +0100
Subject: Re: [PATCH] staging: erofs: Add braces to do-while statements
To:     Thomas Jespersen <laumann.thomas@gmail.com>
Cc:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        gregkh@linuxfoundation.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20181209155900.10164-1-laumann.thomas@gmail.com>
From:   Gao Xiang <hsiangkao@gmx.com>
Message-ID: <5db45ff8-ea1a-10f3-fc63-f1918818c9ce@gmx.com>
Date:   Mon, 10 Dec 2018 05:37:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181209155900.10164-1-laumann.thomas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:eZNvgb51EpxmGLISM+xYs4Ip+S97XE1qWF6Hw80nt41Dmp7yRiA
 hoWiX1JJY6l0PxPE2RvQqPO9VRUT5taEcqjQwqzB+hBXglIMAIxNbFBFQ2nfOAvULF7FBiM
 8c0b2mrsAVuXwrBd48fZozQ7QaSRS2g8h/S6jSwKfmNRfwE4mv06ankElHYGNuXeRB8+ZV9
 xY2sSFtEHdKeencj+c5iQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pGn5yHpBCzg=:2KAl0dNUnNCZzJ6mFa1QL2
 pRAhWKKqMy+rhJN5qyEqm167/fJP65zfDuus2C7S4rAdmSlx21WBQTOyhckhVh1F5ZR8m8UdX
 1zrJ4YNSE5CapCiACOFe3fjR6SxyQ/dDTnZ3WQTj/oIZ/l4K3i3OaquXggTMpV89ZEuKkDEf/
 dsEwswf879NFuDeKsskWmOKTyZ90u150cfUnXHsZK2hIrxl1u7hJrU0TeCWMZULSjYfJun+kd
 K6XnGC4GaleZznhyMDOmj2On2gipsgiZnofUjQwKcpEIR0wlHcaytYWxyLPN5lsYadU1q8hkW
 e1umg7AinRxxpvUEKTZ7/WgSehjKREmkRHyMw2kcobWvhQ4/ptbgHZkEyQ9fo9oTlPXajAz1u
 nmFqehhqX1oii6lF9DQezzyAeJqG47asZzagSV0/YMjiV4ygo8Y7egku0Jj1JmGqq+FhYIR8E
 izWdpVEEtsKwO5huaDiOYMpu/VxF7Dpn0S7k3UEcvp0JM2ZGZLBWEM6RNHg1T+rF1rA5+oCdA
 RvcU5N38QHKZNg7y2le66VXyAk8wTzxrGnxsgGVEepqH8+vD5WlUzBdfmAx62HfbDHOb9q5wF
 dtsnUSlWGxb9l8nPPindHZrHQ6q64gjHaEjh8oZz4RiYZFZstAl98B8+1b0D3rcXmtGMV0KNp
 760wg7xrDwyWUZPT7OBRyXII2yOvfsHGZ+40osbj1WcexJn9P8KhCwVEeFBMzrwBwVlLOAbYq
 oZ67M+nglG/xVHz5F1vq0RPbYZMmYhiH2tTta8XpYnyLMJUVGO8ZEdXc1nzClPRSJpt8ECVqU
 hT8TeWFxUTAdWzF4HzTZ/8PZeo5dH4OrnjytJGVLj37nl2Wy3KuGFl5XVPRKovD+aGCCqtHvj
 cmImwqStK4kTLpUM9TR6/peWI04caLAK50ThuF/LGvzcUAHVLBiZyJJbxudTvH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[oops... I found Thomas sent the exactly the same email again.]

On 2018/12/9 23:59, Thomas Jespersen wrote:
> This fixes warning reported by sparse (with -Wsparse-all).
>
> Signed-off-by: Thomas Jespersen <laumann.thomas@gmail.com>
> ---
>  drivers/staging/erofs/internal.h | 4 ++--
>  drivers/staging/erofs/utils.c    | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
> index 57575c7f5635..bf180a803446 100644
> --- a/drivers/staging/erofs/internal.h
> +++ b/drivers/staging/erofs/internal.h
> @@ -232,9 +232,9 @@ static inline bool erofs_workgroup_get(struct erofs_workgroup *grp, int *ocnt)
>  	/* spin if it is temporarily locked at the reclaim path */
>  	if (unlikely(o == locked)) {
>  #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
> -		do
> +		do {
>  			cpu_relax();
> -		while (atomic_read(&grp->refcount) == locked);
> +		} while (atomic_read(&grp->refcount) == locked);
>  #endif
>  		goto repeat;
>  	}

Could you please check the latest source code? I cannot find the above code...

So I think this patch cannot be applied directly :(

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/erofs/internal.h?h=staging-next#n260


... and why you send this patch without modification...

https://lists.ozlabs.org/pipermail/linux-erofs/2018-December/001099.html

https://lists.ozlabs.org/pipermail/linux-erofs/2018-December/001100.html


Thanks,

Gao Xiang

