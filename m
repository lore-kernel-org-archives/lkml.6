Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx49MBm8G4FS0yTe1dOLZz2o4wnBxMibQffBHdmxTvlWd8EA1aiXdOPFaJv+Gjc9f30ZBicVF
ARC-Seal: i=1; a=rsa-sha256; t=1523998803; cv=none;
        d=google.com; s=arc-20160816;
        b=giIofUCdcGJaGdOmwjiQJBeaNALe/0dZJiZC9D2yc3s7kGzJviDi7Qb1aaPWmyrSxb
         4nKpKsLFaLpPzbBTwrttGYkBjB2RzlDILMljowM/1BzR5I8YwvhCdmTVJt3SBciNepqk
         +NFS6jOckcgUAzgpg1kQUZJYjvajyfIh0SrQwyt3iXcSWXpidYa+82KCXIppHuP8rinv
         KL63B7CNp4exANzv8VqzPJOIcisMqe6xKFNMNadqGK9/rtuOuMEcJUrcyq9/3VaRjLkt
         LPARQXmG6nhjwkXPeEjnOVlcNsPli87WZ7Iu1FfEGkVV31q60y/U+LsRk+NQeO/sQIm4
         1d2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=e+CPsIoXnI9a4R6MF1I3MgM3GVhhyhT/2AQIHBRtuRQ=;
        b=qVFWnUfrVZZzKbdlLxFWb9JxM6D31TbdTEBRS9D68EsUYMIWjzGaBC3RGLI3/g80CZ
         qRh7jD8aP/NDlOsXKi2ZlsYrHur5+KopBaDb6mrIG6EG17p8H0A91CyZGSr5mHtcg4BO
         JXp5Ehd3DAUYrht/r3YQyllvfY420LNcysBy+TYLwZOrYvJ+kjgrz+KwIstywS9xa8sG
         5JIT5EjquU8PRgXObTxvHyzTAPAzpPer3nA3H2a76QnRmfDleT9LEIuRNWmN8TIN5iNY
         nxO+Ck4qqdvP3JecuLPuXmlhcJ9krsQuVTVcFz4AA3oQ1mV/gbGJ9NixNHt5FKeGuIcg
         mW0A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=ht+A92Kq;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=ht+A92Kq;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH 1/9] firmware: some documentation fixes
To: Andres Rodriguez <andresx7@gmail.com>, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mcgrof@kernel.org, alexdeucher@gmail.com,
 ckoenig.leichtzumerken@gmail.com, kvalo@codeaurora.org,
 arend.vanspriel@broadcom.com, Hans de Goede <hdegoede@redhat.com>
References: <20180417153307.3693-1-andresx7@gmail.com>
 <20180417153307.3693-2-andresx7@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <63e446c5-fbbb-cdbb-446c-43577c82f157@infradead.org>
Date: Tue, 17 Apr 2018 13:59:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417153307.3693-2-andresx7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008010982700219?=
X-GMAIL-MSGID: =?utf-8?q?1598028569417154454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/17/18 08:32, Andres Rodriguez wrote:
> Including:
>  - Fixup outdated kernel-doc paths
>  - Slightly too short title underline
>  - Some typos
> 
> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>

BTW, Hans de Goede <hdegoede@redhat.com> has already submitted a patch to
handle the file rename(s) for Documentation.


> ---
>  Documentation/driver-api/firmware/request_firmware.rst | 16 ++++++++--------
>  drivers/base/firmware_loader/fallback.c                |  4 ++--
>  drivers/base/firmware_loader/fallback.h                |  2 +-
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
> index 9305bf4db38e..7632f8807472 100644
> --- a/Documentation/driver-api/firmware/request_firmware.rst
> +++ b/Documentation/driver-api/firmware/request_firmware.rst
> @@ -17,17 +17,17 @@ an error is returned.
>  
>  firmware_request
>  ----------------
> -.. kernel-doc:: drivers/base/firmware_class.c
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>     :functions: firmware_request
>  
>  firmware_request_direct
>  -----------------------
> -.. kernel-doc:: drivers/base/firmware_class.c
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>     :functions: firmware_request_direct
>  
>  firmware_request_into_buf
>  -------------------------
> -.. kernel-doc:: drivers/base/firmware_class.c
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>     :functions: firmware_request_into_buf
>  
>  Asynchronous firmware requests
> @@ -41,7 +41,7 @@ in atomic contexts.
>  
>  firmware_request_nowait
>  -----------------------
> -.. kernel-doc:: drivers/base/firmware_class.c
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>     :functions: firmware_request_nowait
>  
>  Special optimizations on reboot
> @@ -50,12 +50,12 @@ Special optimizations on reboot
>  Some devices have an optimization in place to enable the firmware to be
>  retained during system reboot. When such optimizations are used the driver
>  author must ensure the firmware is still available on resume from suspend,
> -this can be done with firmware_request_cache() insted of requesting for the
> -firmare to be loaded.
> +this can be done with firmware_request_cache() instead of requesting for the
> +firmware to be loaded.
>  
>  firmware_request_cache()
> ------------------------
> -.. kernel-doc:: drivers/base/firmware_class.c
> +------------------------
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>     :functions: firmware_request_cache
>  
>  request firmware API expected driver use
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 71f529de5243..da97fc26119c 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -536,8 +536,8 @@ fw_create_instance(struct firmware *firmware, const char *fw_name,
>  }
>  
>  /**
> - * fw_load_sysfs_fallback - load a firmware via the syfs fallback mechanism
> - * @fw_sysfs: firmware syfs information for the firmware to load
> + * fw_load_sysfs_fallback - load a firmware via the sysfs fallback mechanism
> + * @fw_sysfs: firmware sysfs information for the firmware to load
>   * @opt_flags: flags of options, FW_OPT_*
>   * @timeout: timeout to wait for the load
>   *
> diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
> index dfebc644ed35..f8255670a663 100644
> --- a/drivers/base/firmware_loader/fallback.h
> +++ b/drivers/base/firmware_loader/fallback.h
> @@ -6,7 +6,7 @@
>  #include <linux/device.h>
>  
>  /**
> - * struct firmware_fallback_config - firmware fallback configuratioon settings
> + * struct firmware_fallback_config - firmware fallback configuration settings
>   *
>   * Helps describe and fine tune the fallback mechanism.
>   *
> 


-- 
~Randy
