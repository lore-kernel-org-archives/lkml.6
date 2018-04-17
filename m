Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx4/UFOCt1laRVX+V6WPzO6YeBeVg0LANnAodd7J7T7fu3arYxjD0u97US0aiOI13SjmGVfY4
ARC-Seal: i=1; a=rsa-sha256; t=1523998619; cv=none;
        d=google.com; s=arc-20160816;
        b=W9I/CkM2AEET21XAoq0LHhmr8jlTp72VsrWE0P4sQ8vbX14ft4dJ0HrpkHm4TZAFdy
         rBassI12bBPYVhU/VbM4x7LvsqWZLyAXifGwJ8ZsXbfpcRRaNXWmsnZWb0C++HfGxIwi
         rVg0a0gFe7XRUotFs4mJQlYyQhkHY4J0wUDyindYjs3sfJXkLpaCAhiysl/IY428AOFd
         /a19rQLf2JGq84cOeA4B0hTAnJUZamzyeyfbB8FNZxQGmKtrlGsVVpHJw9Vba3cxktKH
         /p1QtCELPq2wf0gcOrqOP55FhJrBnNXfvR5ka9QkwAmFbQJ1rZOxl4sqPN3X39oLdft9
         F7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=bsYnVpHfSy2Q0VdBVrsoTdeMnYRP+1JS6PuIxb3On00=;
        b=bQy04NBv3BJz8EylwF//eMzAZwDtkPwbyoAgdlvLmOPO3BXyuKfs7w2WUTzI6uWTyh
         6uV7ID9bWDADoFJuUtGPUH+atuDbU0xgMNOSAcLuMpMGyix0MXeI0MwtaBCeIyX+kxNi
         NWdvdtEyG/D7GyYxBG2lwagafBdHArW4IRL7c2DL4jO89G6fT1AyG3De7IbI7Iv+of/Y
         YLB9QJHqpuuaWLdtOC2T0HPN3mxs96YCDxzKbPoC+fqyLucPlRgjuKk4PfWw1YSZYtJ5
         4KksPsfQsRdceVnnythcYRY93qXzRDJ+su23dQJ67XgthinbjvkCt9Bw7HnMXS/vTXrc
         fMcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=I+t3Ks4C;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=I+t3Ks4C;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH 4/9] firmware: use () to terminate kernel-doc function
 names
To: Andres Rodriguez <andresx7@gmail.com>, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mcgrof@kernel.org, alexdeucher@gmail.com,
 ckoenig.leichtzumerken@gmail.com, kvalo@codeaurora.org,
 arend.vanspriel@broadcom.com
References: <20180417153307.3693-1-andresx7@gmail.com>
 <20180417153307.3693-5-andresx7@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <96d29209-da25-5325-0530-c336303a6ebe@infradead.org>
Date: Tue, 17 Apr 2018 13:56:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417153307.3693-5-andresx7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008014188968321?=
X-GMAIL-MSGID: =?utf-8?q?1598028376455976367?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/17/18 08:33, Andres Rodriguez wrote:
> The kernel-doc spec dictates a function name ends in ().
> 
> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/base/firmware_loader/fallback.c |  8 ++++----
>  drivers/base/firmware_loader/main.c     | 22 +++++++++++-----------
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index ecc49a619298..e75928458489 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -124,7 +124,7 @@ static ssize_t timeout_show(struct class *class, struct class_attribute *attr,
>  }
>  
>  /**
> - * firmware_timeout_store - set number of seconds to wait for firmware
> + * firmware_timeout_store() - set number of seconds to wait for firmware
>   * @class: device class pointer
>   * @attr: device attribute pointer
>   * @buf: buffer to scan for timeout value
> @@ -238,7 +238,7 @@ static int map_fw_priv_pages(struct fw_priv *fw_priv)
>  }
>  
>  /**
> - * firmware_loading_store - set value in the 'loading' control file
> + * firmware_loading_store() - set value in the 'loading' control file
>   * @dev: device pointer
>   * @attr: device attribute pointer
>   * @buf: buffer to scan for loading control value
> @@ -430,7 +430,7 @@ static int fw_realloc_pages(struct fw_sysfs *fw_sysfs, int min_size)
>  }
>  
>  /**
> - * firmware_data_write - write method for firmware
> + * firmware_data_write() - write method for firmware
>   * @filp: open sysfs file
>   * @kobj: kobject for the device
>   * @bin_attr: bin_attr structure
> @@ -536,7 +536,7 @@ fw_create_instance(struct firmware *firmware, const char *fw_name,
>  }
>  
>  /**
> - * fw_load_sysfs_fallback - load a firmware via the sysfs fallback mechanism
> + * fw_load_sysfs_fallback() - load a firmware via the sysfs fallback mechanism
>   * @fw_sysfs: firmware sysfs information for the firmware to load
>   * @opt_flags: flags of options, FW_OPT_*
>   * @timeout: timeout to wait for the load
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 5baadad3012d..d028cd3257f7 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -597,7 +597,7 @@ _firmware_request(const struct firmware **firmware_p, const char *name,
>  }
>  
>  /**
> - * firmware_request: - send firmware request and wait for it
> + * firmware_request() - send firmware request and wait for it
>   * @firmware_p: pointer to firmware image
>   * @name: name of firmware file
>   * @device: device for which firmware is being loaded
> @@ -632,7 +632,7 @@ firmware_request(const struct firmware **firmware_p, const char *name,
>  EXPORT_SYMBOL(firmware_request);
>  
>  /**
> - * firmware_request_direct: - load firmware directly without usermode helper
> + * firmware_request_direct() - load firmware directly without usermode helper
>   * @firmware_p: pointer to firmware image
>   * @name: name of firmware file
>   * @device: device for which firmware is being loaded
> @@ -657,7 +657,7 @@ int firmware_request_direct(const struct firmware **firmware_p,
>  EXPORT_SYMBOL_GPL(firmware_request_direct);
>  
>  /**
> - * firmware_request_cache: - cache firmware for suspend so resume can use it
> + * firmware_request_cache() - cache firmware for suspend so resume can use it
>   * @name: name of firmware file
>   * @device: device for which firmware should be cached for
>   *
> @@ -681,7 +681,7 @@ int firmware_request_cache(struct device *device, const char *name)
>  EXPORT_SYMBOL_GPL(firmware_request_cache);
>  
>  /**
> - * firmware_request_into_buf - load firmware into a previously allocated buffer
> + * firmware_request_into_buf() - load firmware into a previously allocated buffer
>   * @firmware_p: pointer to firmware image
>   * @name: name of firmware file
>   * @device: device for which firmware is being loaded and DMA region allocated
> @@ -713,7 +713,7 @@ firmware_request_into_buf(const struct firmware **firmware_p, const char *name,
>  EXPORT_SYMBOL(firmware_request_into_buf);
>  
>  /**
> - * firmware_release: - release the resource associated with a firmware image
> + * firmware_release() - release the resource associated with a firmware image
>   * @fw: firmware resource to release
>   **/
>  void firmware_release(const struct firmware *fw)
> @@ -755,7 +755,7 @@ static void firmware_request_work_func(struct work_struct *work)
>  }
>  
>  /**
> - * firmware_request_nowait - asynchronous version of firmware_request
> + * firmware_request_nowait() - asynchronous version of firmware_request
>   * @module: module requesting the firmware
>   * @uevent: sends uevent to copy the firmware image if this flag
>   *	is non-zero else the firmware copy must be done manually.
> @@ -824,7 +824,7 @@ EXPORT_SYMBOL(firmware_request_nowait);
>  static ASYNC_DOMAIN_EXCLUSIVE(fw_cache_domain);
>  
>  /**
> - * cache_firmware - cache one firmware image in kernel memory space
> + * cache_firmware() - cache one firmware image in kernel memory space
>   * @fw_name: the firmware image name
>   *
>   * Cache firmware in kernel memory so that drivers can use it when
> @@ -866,7 +866,7 @@ static struct fw_priv *lookup_fw_priv(const char *fw_name)
>  }
>  
>  /**
> - * uncache_firmware - remove one cached firmware image
> + * uncache_firmware() - remove one cached firmware image
>   * @fw_name: the firmware image name
>   *
>   * Uncache one firmware image which has been cached successfully
> @@ -1042,7 +1042,7 @@ static void __device_uncache_fw_images(void)
>  }
>  
>  /**
> - * device_cache_fw_images - cache devices' firmware
> + * device_cache_fw_images() - cache devices' firmware
>   *
>   * If one device called firmware_request or its nowait version
>   * successfully before, the firmware names are recored into the
> @@ -1075,7 +1075,7 @@ static void device_cache_fw_images(void)
>  }
>  
>  /**
> - * device_uncache_fw_images - uncache devices' firmware
> + * device_uncache_fw_images() - uncache devices' firmware
>   *
>   * uncache all firmwares which have been cached successfully
>   * by device_uncache_fw_images earlier
> @@ -1092,7 +1092,7 @@ static void device_uncache_fw_images_work(struct work_struct *work)
>  }
>  
>  /**
> - * device_uncache_fw_images_delay - uncache devices firmwares
> + * device_uncache_fw_images_delay() - uncache devices firmwares
>   * @delay: number of milliseconds to delay uncache device firmwares
>   *
>   * uncache all devices's firmwares which has been cached successfully
> 


-- 
~Randy
