Return-Path: <mchehab+samsung@kernel.org>
X-Google-Smtp-Source: AB8JxZqM2NmyJ0k7TpXQdoNgj5dTZyfBCt8Lok5a+9oJtzciGIB7diM5l8Qznk7vdA67jK0UR2R+
ARC-Seal: i=1; a=rsa-sha256; t=1524736334; cv=none;
        d=google.com; s=arc-20160816;
        b=yNvtLRNTcZ7lk+nOC2JCXPNQTIFJyfoVLjou/G85CvaPbbkhBYRODjrawXuSxknt/o
         qMFNFT6w/ujqI8kt9PrbMd8z/pyH+nHYwXi2UBLNQDQ4joAxOEZXOjru1ka0RtcBu0oc
         YVLIC7X0mYwcTOCNC8uc15Gjnwm1/ziuq3P1gs4sC9uMQuyZMyAIyoDslZ99NJhwTLUf
         jX+9e0XKH5cJy6artgqVQy3B1nrpNkQqIeP6fYvfoSRyzKsIwPb/7RgKwuZDg/FK7RqJ
         +ek4E3lGKDhixPuFzPtUZIOtFe8IPxf26WDtxwl/Thr58Wyn6NTn5c1tV2QGgqs+LKUi
         9oAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=0ZQ/HnxlUXlfoGpx6mU5Hir5CQLoNtmEZJBJYmoIiIc=;
        b=XQjzlgM10xO5fPtceCGtEIviwCcZBQSzYEpfmqyWnxvjtTVXlzfOcFl6wmTxYGSd8q
         exsI4qj0oc5IHsPhc6REmP9eAYweBRLbJRUfhooUdH5++sMLFzwuxTMxm+w15vcJDubE
         2+g1pF9uijUiSyphQIM8p2WCpR3iHedFMXuNGjSVHtGEMvgWBfF+k8EojJYaB9Nk1bJd
         2R4eZqSPAmm+hgC84KyUcq6U6DAkPtdDvC29oMjR82uQ2QLVTpYGAa3p5cA1j6ntgGZd
         c/srWENlehZvamsA2hAGsUoNMB9obAsXsjruZcxTP4XavFgH5zP9o4u56dbyC8FLipzl
         YZLA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=bggI4FCh;
       spf=neutral (google.com: 2607:7c80:54:e::133 is neither permitted nor denied by best guess record for domain of mchehab+samsung@kernel.org) smtp.mailfrom=mchehab+samsung@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=bggI4FCh;
       spf=neutral (google.com: 2607:7c80:54:e::133 is neither permitted nor denied by best guess record for domain of mchehab+samsung@kernel.org) smtp.mailfrom=mchehab+samsung@kernel.org
Date: Thu, 26 Apr 2018 06:52:01 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Philippe Ombredanne
 <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet
 <corbet@lwn.net>, Hans Verkuil <hans.verkuil@cisco.com>, Christoph Hellwig
 <hch@lst.de>
Subject: Re: [patch V2 1/7] LICENSES/GPL2.0: Add GPL-2.0-only/or-later as
 valid identifiers
Message-ID: <20180426065201.36782cf2@vento.lan>
In-Reply-To: <20180425203703.137893509@linutronix.de>
References: <20180425203020.594959448@linutronix.de>
	<20180425203703.137893509@linutronix.de>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598752949280430563?=
X-GMAIL-MSGID: =?utf-8?q?1598801926752518452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Wed, 25 Apr 2018 22:30:21 +0200
Thomas Gleixner <tglx@linutronix.de> escreveu:

> From: Thomas Gleixner tglx@linutronix.de
> 
> Quite some files have been flagged with the new GPL-2.0-only and
> GPL-2.0-or-later identifiers which replace the original GPL-2.0 and
> GPL-2.0+ identifiers in the SPDX license identifier specification, but the
> identifiers are not mentioned as valid in the GPL-2.0 license file.
> 
> Add them to the license file and to the Linux-syscall-note exception to
> make everything consistent again.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> 
> diff --git a/LICENSES/exceptions/Linux-syscall-note b/LICENSES/exceptions/Linux-syscall-note
> index 6b60b61be4e9..9abdad71fafd 100644
> --- a/LICENSES/exceptions/Linux-syscall-note
> +++ b/LICENSES/exceptions/Linux-syscall-note
> @@ -1,6 +1,6 @@
>  SPDX-Exception-Identifier: Linux-syscall-note
>  SPDX-URL: https://spdx.org/licenses/Linux-syscall-note.html
> -SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+, LGPL-2.1, LGPL-2.1+
> +SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+, LGPL-2.1, LGPL-2.1+, GPL-2.0-only, GPL-2.0-or-later
>  Usage-Guide:
>    This exception is used together with one of the above SPDX-Licenses
>    to mark user space API (uapi) header files so they can be included
> diff --git a/LICENSES/preferred/GPL-2.0 b/LICENSES/preferred/GPL-2.0
> index b8db91d3a1cb..ff0812fd89cc 100644
> --- a/LICENSES/preferred/GPL-2.0
> +++ b/LICENSES/preferred/GPL-2.0
> @@ -1,5 +1,7 @@
>  Valid-License-Identifier: GPL-2.0
> +Valid-License-Identifier: GPL-2.0-only
>  Valid-License-Identifier: GPL-2.0+
> +Valid-License-Identifier: GPL-2.0-or-later
>  SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
>  Usage-Guide:
>    To use this license in source code, put one of the following SPDX
> @@ -7,8 +9,12 @@ Usage-Guide:
>    guidelines in the licensing rules documentation.
>    For 'GNU General Public License (GPL) version 2 only' use:
>      SPDX-License-Identifier: GPL-2.0
> +  or
> +    SPDX-License-Identifier: GPL-2.0-only
>    For 'GNU General Public License (GPL) version 2 or any later version' use:
>      SPDX-License-Identifier: GPL-2.0+
> +  or
> +    SPDX-License-Identifier: GPL-2.0-or-later
>  License-Text:
>  
>  		    GNU GENERAL PUBLIC LICENSE
> 
> 



Thanks,
Mauro
