Return-Path: <labbott@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522851462; cv=none;
        d=google.com; s=arc-20160816;
        b=ExyIRyHDsckuvQ1asKGDflwzAvV8dQMXHGRS001SJhs1Vzt9yiVE3L0N9y7iJc7GPb
         x7zKCWJZ/fiAipSQMRZeQzNiUDU8o7hyGbp6R5xcwr0CIAplzGK2b68axAbIYHz+dTmV
         vBfygBZp6HD2KwhgxOzN5oPwCThVMAS5IZng7S8jOjM2Gtl1BVjDuZaDRWRgsrTDII8p
         VFXLXRDbKlmlxeCCd1PMxPHxD0MSJxI05nzP9mZihc8gzsoxVVY3KfbDsbjcusHcVQyq
         aBfXh5GsG/moMHyMw3gjw57ThR+eyUYzQ2mSsO1kwlP1cY1pLtqZiMviAy/1s+ZcbuX4
         QYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=8gZ6eW8sXXXD3MIg0YbzVfCxwhctIhknXZ2XcDVEt9k=;
        b=PcCQjTQLK3QZ8K0tVHe+HnntFvEPgJPSk8erpYsyBcjOaHTsYJQk51eKe1kBudxrCS
         qO+FGhVqMPdfK02iguxT6pqUvK96OKASoqXiWGXdwLXG4IjOrqFxLZGLTEM1l5eZB8nX
         fW4TjhvxXAWJMCNHW6M57frLLjW69ZosTHAHiCqQKy7KJNrGHpbyvC4wJnQOqOWFmG6G
         RP5g/DZGpI44Jp7u62KdW5WHlE8OV+SQ+0s+WLQg8/eWj3P5CToKpKIymL8hCPqEOGQf
         gRO3KTsTh1qTpey1OKegP9X0fLgsWfPvXMksDjFNPDvUgHxRXSH61r+ymVNOP/wiJCDo
         qecQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx48nnarRPcHGAG2iM/VlZVHrWUYOWeMn1oFiZhl7ZKP5yj4x+daGwkPj856mIElqrfGQOP0aCA==
Subject: Re: [PATCH] MAINTAINERS: add dri-devel&linaro-mm for Android ION
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, devel@driverdev.osuosl.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Daniel Vetter <daniel.vetter@intel.com>
References: <20180404103037.11581-1-daniel.vetter@ffwll.ch>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <222a21c2-6de0-d8a8-852a-35786af76a5a@redhat.com>
Date: Wed, 4 Apr 2018 07:17:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180404103037.11581-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596811215801988069?=
X-GMAIL-MSGID: =?utf-8?q?1596825495244447832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/04/2018 03:30 AM, Daniel Vetter wrote:
> Most of the other cross-driver gfx infrastructure (dma_buf, dma_fence)
> also gets cross posted to all the relevant gfx/memory lists. Doing the
> same for ION means people won't miss relevant patches.
> 

No problem from me, the rate of checkpatch fixups should be
small these days.

Acked-by: Laura Abbott <labbott@redhat.com>

> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: devel@driverdev.osuosl.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 555db72d4eb7..d43cdfca3eb5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -902,6 +902,8 @@ ANDROID ION DRIVER
>   M:	Laura Abbott <labbott@redhat.com>
>   M:	Sumit Semwal <sumit.semwal@linaro.org>
>   L:	devel@driverdev.osuosl.org
> +L:	dri-devel@lists.freedesktop.org
> +L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
>   S:	Supported
>   F:	drivers/staging/android/ion
>   F:	drivers/staging/android/uapi/ion.h
> 
