Return-Path: <dvhart@infradead.org>
X-Google-Smtp-Source: AH8x225sou2+/0xc/2+Khyl5rqI10e3nffqMMuSMbnbiEb0pcXX06W9rc/8fSYeUZLXs/S4E3ae2
ARC-Seal: i=1; a=rsa-sha256; t=1518142961; cv=none;
        d=google.com; s=arc-20160816;
        b=c5HDxvnaPl/ibFdpN+MPebwE5NXysCxC/L9IRhxqfEWOFh+JE3+7phX/B2+Vxiu5/I
         4UB41OGgi/18liOQJnq4qLcIoDK/5OGr4yqIUc6e5a69fjT32XPWpWaqmVuOWGKQQ3iR
         Gw2TO8HvzuCiE/veC2ZsWRvDvDKhkfCU/rASgl34hbahs+7YvLP+ld4DD3C+jJcEVf6s
         XD471dOKJ2ES44ymw7ngcmVuen16MFkVb53nvxqBPAXsUYcK+AvxEQqlpNYJqVbc1tWs
         514r3WFqmJroPznyNWXCOEkr1XIxrM+uagPpp60jFzmHjO8lNL9Up8B3UHpc4fgLoUHR
         3H5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=mTI2yZ3N/Ns9u5LUbjVd/soed7crJZSlm1xZsapnx8I=;
        b=Jy7pcaAJveHLXf138XJ6ECPKCdgBFqsOn+UwwDDx7iaYd/uDDVc5/DW6ygxNek3sjO
         xD1tx96Xx9JLHdpuPqRrhaq00jz7KujvXVd5VLdma0OGemDgReM9xRlYiJQn/HYJgDs8
         Ax5OmCxCepsFDh9hcHEroekmmQ6uw1FZpTM7B4vmoCxXl43F9CmE7OM/WsLkHNPi5GY2
         m/ZDbeuIsuUIlRYr9HJ3K3iaBDxhlLIRIMcxpCA3vZM0Sv41Xy8R1KeNRrfCtL66cPOz
         EWiHgHlbbErA9haIN5hlv9LoWNg9NPrBqr/IooJ9egDA40y3EioDW2v33pJzqpJdw3LC
         nJFw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=ha4b/7H8;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=ha4b/7H8;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 65.50.211.133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Date: Thu, 8 Feb 2018 18:22:39 -0800
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	jiri@resnulli.us
Subject: Re: [patch v1 0/4] mlx-platform: Add support for new Mellanox
 systems, code improvement, fixes for msn21xx system
Message-ID: <20180209022239.GB25898@fury>
References: <1517561148-38587-1-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517561148-38587-1-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591270875340200693?=
X-GMAIL-MSGID: =?utf-8?q?1591888273660272028?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 08:45:44AM +0000, Vadim Pasternak wrote:
> The patchset:
> - adds defines for bus numbers, used for system topology description;
> - fixes definition for power cables for system family msn21xx;
> - introduces support for new Mellanox systems;
> 
> Vadim Pasternak (4):
>   platform/x86: mlx-platform: Use defines for bus assignment
>   platform/x86: mlx-platform: Add define for the negative bus
>   platform/x86: mlx-platform: Fix power cable setting for systems from
>     msn21xx family

I've queued 1,2,3 and will try to include these in one final PR to Linus during
the Merge Window. (Andy, FYI)

>   platform/x86: mlx-platform: Add support for new Mellanox systems
> 

This one needs to be broken up into smaller patches.

>  drivers/platform/x86/mlx-platform.c | 345 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 335 insertions(+), 10 deletions(-)
> 
> -- 
> 2.1.4
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
