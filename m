Return-Path: <gpiccoli@canonical.com>
X-Google-Smtp-Source: AH8x225byfpevckeEEt6DlQjp8tt/AvcuNtMFtsvS5SxjdxwoARdMhYjtEp8QvbhjvboGDslTWyg
ARC-Seal: i=1; a=rsa-sha256; t=1517836435; cv=none;
        d=google.com; s=arc-20160816;
        b=iPY6+LoVPm9EyM+D9i0bYhFZmdHYcDk5wLxYQOVuFVfCKP4mWYdi2I09dsozzVxjsA
         ZxKoEorDKA9y+y3FIHRwq2AocRviZoSnLLjsPNuQipINidxlpmKDkgLgBWe5Y/9qh8/v
         DZ455WT10wmWfMfw1I3G7KX9rprQ2t92N7KJLNbNv7m9eevsLNl2MMoc/Nv0Q4/qWg5R
         UdUZOSIGFRv/MsLx2MuUG1RyjF7130v7JTBrk33aOzOrCoGrm9+l96lw/Y03SPpYyUKB
         91KZJVHH4u0lSa/r/BX8H9td2Q28ajdPyL1lx1tpfkHikjCtgWaw+7XlNQhXH6V2E4Ce
         cFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=358XB3fgKBrB2/KCeU2Aj7WVwghlT8H+ik4XnluA4Jg=;
        b=zGG9aoSIK0qhnGjtiSP0g54dCjwaXlA+G6GhDoZ/g/igKhRI5o1X/7ts2bY/rc2Y4V
         uiBMgf6MrY5+LwO7wncVOkhajSO/nOz7XEuygX1n1oas7ADn6/JuyC02PqXX1b4MzyDa
         fEF7mEhMLZw87eVdUNzhRrs+2n+rV4lguF7+k9e6Kk80AkCZUZ+YDtbulEuMo+c12rJX
         pTt6jW/LOdgpGKLSt/wzpyFkzhZBNKVI4x5jCR9mD3QZNOFT31c45+Cy5+7FGOsXmtG3
         CjED84xSPdxVaOBvlGcNHg1ET0Nts8NHkyRcV1/zIYm7XSAmjQU467w9AEn+KMmIXtEP
         b5UA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of gpiccoli@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=gpiccoli@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of gpiccoli@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=gpiccoli@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Subject: Re: [PATCH] MAINTAINERS: Change maintainer of genwqe
To: "Mauro S. M. Rodrigues" <maurosr@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
Cc: haver@linux.vnet.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 brking@linux.vnet.ibm.com
References: <1517836201-19362-1-git-send-email-maurosr@linux.vnet.ibm.com>
From: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Message-ID: <a90ca2a5-5d64-bb3a-babc-dc654725a062@canonical.com>
Date: Mon, 5 Feb 2018 11:13:47 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1517836201-19362-1-git-send-email-maurosr@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591566619699456002?=
X-GMAIL-MSGID: =?utf-8?q?1591566857956057424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/02/2018 11:10, Mauro S. M. Rodrigues wrote:
> Guilherme is no longer available to maintain the driver. I'll assume his
> position for now on.
> 
> Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>

Thanks a lot Mauro!

Acked-by: Guilherme G. Piccoli <gpiccoli@canonical.com>


> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b59a8cd..21ab6b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5968,7 +5968,7 @@ F:	drivers/uio/uio_pci_generic.c
>  
>  GENWQE (IBM Generic Workqueue Card)
>  M:	Frank Haverkamp <haver@linux.vnet.ibm.com>
> -M:	Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> +M:	Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
>  S:	Supported
>  F:	drivers/misc/genwqe/
>  
> 
