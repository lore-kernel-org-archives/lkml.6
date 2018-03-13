Return-Path: <Ajay.Kathat@microchip.com>
X-Google-Smtp-Source: AG47ELs/tiBNCyandd0G7N1I8j/2IsPArTyO7uPkIgYlPZm10tYQoGMtDWfBzxaDTNxTRqx76pZ/
ARC-Seal: i=1; a=rsa-sha256; t=1520926750; cv=none;
        d=google.com; s=arc-20160816;
        b=RDf6qmgQwYSiWmT9swAyI2emZsWKdnar25fLu0jE3Mvh3/xM+UFZlOdLTljfJ9QmKm
         N0954an12S90MH4MJ31bhy8YYmfLsn5v8P/PMP4xdk5EuRo7og4eQkyM6SNlSSuB6uzd
         UeJiDf8ULbLA/T4ZXF+Flb/8d9RCG+fLn0gWey5SkF9sdPcfRoQWv/Utpxw368fH7CAU
         AZgW2RfG1eQOl+9q9g8HclY0rCBKzftqfPwRJtunIbLOINTPTH2Y4YcrTl/3ZFcE1/7E
         9K+tMgnwqwTatAQkXZe1sYaONjoGZtkOX4e0XVNPJ3iq8TjDzTrznyInHefkdFafthYv
         WXdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=/nT54IlRxwpv2BnvEa3VLfNvRqy37S93xJTLlgzCILI=;
        b=ZTvE1LpTM+qt4eBXZHzN0g+8NfCx8JXA6CcpjcWYVqMI8O/SwlnpQQdJTjn08TzuWq
         qCwZaECCB4QKLRwyWZOaIQgz7RiQC1/2B1wo42qU549P9MmCi/n1UkXLRql7dU1bTS8C
         zf+EkEE8DQtHvkd8grC89kkF2/3wDEVyqtGfGZeo3NVIWLe5gpznQ4SLdnX70GKz31xA
         Hcp+EMNsNFT09UO8STMwzks6v0FSBxlnHLv1alF4sdl+Ih826Y5JQ813JV5A1vSZjfAy
         a9pOr5gdgILgMCbLGFfUCiX8sTKw3j7dA08xXg/Gc5gQ8vu4gkrdAoZtgCqUrHL0iSZa
         BPoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ajay.kathat@microchip.com designates 68.232.147.91 as permitted sender) smtp.mailfrom=Ajay.Kathat@microchip.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ajay.kathat@microchip.com designates 68.232.147.91 as permitted sender) smtp.mailfrom=Ajay.Kathat@microchip.com
X-IronPort-AV: E=Sophos;i="5.47,464,1515481200";
   d="scan'208";a="12878090"
Date: Tue, 13 Mar 2018 13:09:03 +0530
From: Ajay Singh <ajay.kathat@microchip.com>
To: <hariprasath.elango@gmail.com>, <linux-kernel@vger.kernel.org>
CC: <aditya.shankar@microchip.com>, Ganesh Krishna
	<ganesh.krishna@microchip.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-wireless@vger.kernel.org>,
	<devel@driverdev.osuosl.org>
Subject: Re: [PATCH] staging: wilc1000: Fix code block alignment
Message-ID: <20180313130903.5d9c45a9@ajaysk-VirtualBox>
In-Reply-To: <20180312130044.11815-1-hariprasath.elango@gmail.com>
References: <20180312130044.11815-1-hariprasath.elango@gmail.com>
Organization: Microchip Techonology
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594736945700023271?=
X-GMAIL-MSGID: =?utf-8?q?1594807288249882574?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 12 Mar 2018 18:30:44 +0530
<hariprasath.elango@gmail.com> wrote:

> From: HariPrasath Elango <hariprasath.elango@gmail.com>
> 
> Fix the code alignment for a block of code to adhere to coding
> guidelines
> 
> Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>

Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>

Regards,
Ajay
