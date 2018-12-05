Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66454C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33589208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33589208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeLEWLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:11:04 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39699 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLEWLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:11:03 -0500
Received: by mail-qk1-f196.google.com with SMTP id q70so12879486qkh.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 14:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NI7VYINyyD+VcudHLBcOrOdzhgpZLEB/aKK1DU8jC4I=;
        b=TsnjkVuJRBNS+d6kYqZcleQ48WJMZGg3m+waK9FEc5pOqH+BhGFtjlbgGehsuIWlJ/
         OYbn7rKFvXavaY58ZENpc53nVsVRC3nAFTPTC7xioj5EpaTNtVM85WhaEZOutWUXSYv5
         RjTFWGFLm/IVqtRuI6Q+0OfB9L67d1B1TQPjOHd52p2Q8n5/PcreihoCLTee24j51SyK
         X5HX6y4TgPIfFlPGDhvIUeiurttEDhpVMoErmoCa5ADT/qVbnooOndBiCtsHrEpDlgUH
         9Wg3AQHPV8qoFJUL3m9DRpWHvMqto5EBYPA8sxJsjOjAEIEHACPeYlyiQvkQTwo12S2y
         OIMw==
X-Gm-Message-State: AA+aEWY4Sl4TjI3b2mt3+vo8a+8urKUbJ/8zf3sTKaCqDhygpJH8LC3F
        tBzG1zp462UgyUAqAAjlEKiS9pAsVtk=
X-Google-Smtp-Source: AFSGD/WV4WPxSaV00a3WVDufHBFob5KNBKiXIh+IUySkh0GpgbDcK62XEbQpx6rKoHznYTFytGzm1A==
X-Received: by 2002:a37:a9cf:: with SMTP id s198mr22558453qke.274.1544047862611;
        Wed, 05 Dec 2018 14:11:02 -0800 (PST)
Received: from ?IPv6:2601:602:9802:a8dc::5a45? ([2601:602:9802:a8dc::5a45])
        by smtp.gmail.com with ESMTPSA id r56sm13510501qtj.30.2018.12.05.14.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 14:11:01 -0800 (PST)
Subject: Re: [PATCH] staging: android: ion: Remove unused header files
To:     Yangtao Li <tiny.windzz@gmail.com>, sumit.semwal@linaro.org,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org
Cc:     devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20181130144348.2877-1-tiny.windzz@gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <46cded86-4477-95c2-d41e-b03a18b6b17b@redhat.com>
Date:   Wed, 5 Dec 2018 14:10:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181130144348.2877-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/18 6:43 AM, Yangtao Li wrote:
> seq_file.h does not need to be included,so remove it.
> 

Acked-by: Laura Abbott <labbott@redhat.com>

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>   drivers/staging/android/ion/ion.c             | 1 -
>   drivers/staging/android/ion/ion_system_heap.c | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index 99073325b0c0..0d61e9cd0887 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -23,7 +23,6 @@
>   #include <linux/mm_types.h>
>   #include <linux/rbtree.h>
>   #include <linux/sched/task.h>
> -#include <linux/seq_file.h>
>   #include <linux/slab.h>
>   #include <linux/uaccess.h>
>   #include <linux/vmalloc.h>
> diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> index 548bb02c0ca6..9ce2c0d7ac17 100644
> --- a/drivers/staging/android/ion/ion_system_heap.c
> +++ b/drivers/staging/android/ion/ion_system_heap.c
> @@ -11,7 +11,6 @@
>   #include <linux/highmem.h>
>   #include <linux/mm.h>
>   #include <linux/scatterlist.h>
> -#include <linux/seq_file.h>
>   #include <linux/slab.h>
>   #include <linux/vmalloc.h>
>   #include "ion.h"
> 

