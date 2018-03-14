Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeCNVdg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 17:33:36 -0400
Received: from h2.hallyn.com ([78.46.35.8]:45234 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeCNVde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 17:33:34 -0400
Date: Wed, 14 Mar 2018 16:33:32 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH 1/4] integrity: Remove unused macro IMA_ACTION_RULE_FLAGS
Message-ID: <20180314213332.GB14289@mail.hallyn.com>
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
 <20180314202020.3794-2-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314202020.3794-2-bauerman@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thiago Jung Bauermann (bauerman@linux.vnet.ibm.com):
> This macro isn't used anymore since commit 0d73a55208e9 ("ima: re-introduce
> own integrity cache lock"), so remove it.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/integrity/integrity.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 8224880935e0..5e58e02ba8dc 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -30,7 +30,6 @@
>  
>  /* iint cache flags */
>  #define IMA_ACTION_FLAGS	0xff000000
> -#define IMA_ACTION_RULE_FLAGS	0x06000000
>  #define IMA_DIGSIG_REQUIRED	0x01000000
>  #define IMA_PERMIT_DIRECTIO	0x02000000
>  #define IMA_NEW_FILE		0x04000000
