Return-Path: <borntraeger@de.ibm.com>
X-Google-Smtp-Source: AG47ELvtnnZyEdFJfgw8rbRPFtcbSEOlTskGEul+pteImzRXWlAHibCavKSaLH9lVJhxRYtFU//Z
ARC-Seal: i=1; a=rsa-sha256; t=1519723422; cv=none;
        d=google.com; s=arc-20160816;
        b=NR027luvti4yIPSsNZo4d9dQawx1igBUHjm9ywdq2nzRR3nvCH/zHf/WH16jTEhw1F
         /soRGrzVc7bSgXoTbMKotKZ+vqjktTlUtVE3GPmPN6bPyJVSgDuO5TuDk9XHlZf53uz/
         oiRFAGtwpvQUToJZT2vCf6q9CRLBvZYovV+tAzX56Ht3AeFCra6svRyyHK1isGWVqrui
         E1nN5vy2Ci0FYrel0LxM/xvCYfAgdMuOGAOreYdZdwMOiUDn9fwhltaJ0DRU0N9uiPe2
         jCktAQifDj7zqC5yFmEX+xkbeVeYbcJ7IoxdxhWWC2MNksaOnH2NlZQpazCubxJhXyb4
         BgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=n4IKBWEW+sBvOA1rJmtuzs77KNsdO6Cnezaqu+v2iS4=;
        b=oj+SoUQvCA2irJQCWA5iPKZPe4EypKRnKJbj2pwQBby4iOpt2BLUTyOFvxiPRCdHl0
         NMv8IjnYKALQqdrepskInRCYQGR5BqfIH+hwXCieVUI1SVRwOQIwnCWQpprdId0JlJt7
         8jdhBzcXdUvZf+E+lCfLCrBGCWUuiQWsunYcbCktJrEBxw0i6g8fNMTsTYcPrqXDBMTg
         ar61z9aW0R/CCAEn6n8a2gFOSszRnXhZ828ewmCWYLPhQK+udcxql8OO2G0Wma3GMz3a
         prGGxGl/aFkIMz+9HYZqSfRlSSBe4wJ+X/9cynUf/ajjXUufdOQ2tpyueXF+7HV6Lyau
         8FRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of borntraeger@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=borntraeger@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of borntraeger@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=borntraeger@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v4 3/3] s390/setup : enable display support for KVM guest
To: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: thuth@redhat.com, cohuck@redhat.com, tomi.valkeinen@ti.com,
        b.zolnierkie@samsung.com, geert@linux-m68k.org
References: <cover.1519315352.git.alifm@linux.vnet.ibm.com>
 <e23b61f4f599ba23881727a1e8880e9d60cc6a48.1519315352.git.alifm@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 27 Feb 2018 10:23:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e23b61f4f599ba23881727a1e8880e9d60cc6a48.1519315352.git.alifm@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18022709-0008-0000-0000-000004D4F66E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022709-0009-0000-0000-00001E681580
Message-Id: <0b58aec3-7434-e059-386d-2dacebdf39aa@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802270114
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1593545507009882603?=
X-GMAIL-MSGID: =?utf-8?q?1593545507009882603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg FYI, I plan to carry this patch via the s390/kvm tree.
As it drivers/tty/Kconfig, can you give an ack for this part?


On 02/22/2018 05:22 PM, Farhan Ali wrote:
> The S390 architecture does not support any graphics hardware,
> but with the latest support for Virtio GPU in Linux and Virtio
> GPU emulation in QEMU, it's possible to enable graphics for
> S390 using the Virtio GPU device.
> 
> To enable display we need to enable the Linux Virtual Terminal (VT)
> layer for S390. But the VT subsystem initializes quite early
> at boot so we need a dummy console driver till the Virtio GPU
> driver is initialized and we can run the framebuffer console.
> 
> The framebuffer console over a Virtio GPU device can be run
> in combination with the serial SCLP console (default on S390).
> The SCLP console can still be accessed by management applications
> (eg: via Libvirt's virsh console).
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/s390/kernel/setup.c      | 2 ++
>  drivers/tty/Kconfig           | 2 +-
>  drivers/video/console/Kconfig | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index a6a91f0..f98a0f3 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -221,6 +221,8 @@ static void __init conmode_default(void)
>  		SET_CONSOLE_SCLP;
>  #endif
>  	}
> +	if (IS_ENABLED(CONFIG_VT) && IS_ENABLED(CONFIG_DUMMY_CONSOLE))
> +		conswitchp = &dummy_con;
>  }
> 
>  #ifdef CONFIG_CRASH_DUMP
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index b811442..5ca53fa 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -11,7 +11,7 @@ if TTY
> 
>  config VT
>  	bool "Virtual terminal" if EXPERT
> -	depends on !S390 && !UML
> +	depends on !UML
>  	select INPUT
>  	default y
>  	---help---
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index 9485857..b9c2c91 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -9,7 +9,7 @@ config VGA_CONSOLE
>  	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
>  		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
>  		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
> -		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && HAS_IOMEM
> +		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && HAS_IOMEM && !S390
>  	default y
>  	help
>  	  Saying Y here will allow you to use Linux in text mode through a
> 
