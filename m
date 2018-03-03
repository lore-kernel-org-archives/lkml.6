Return-Path: <julia.lawall@lip6.fr>
X-Google-Smtp-Source: AG47ELsIeOG8zTQxy1vaMRWzo1yMhCpyeBCRZSueL8EISrluNCNITXUanbDFd59PPiBavB8TQEhw
ARC-Seal: i=1; a=rsa-sha256; t=1520105420; cv=none;
        d=google.com; s=arc-20160816;
        b=aov1hWk/iJm49KX/nTRmlVPsIwPI9e8+RU8wTWO2KW9zNx8DzlRp9r5g7DtnGNc/SU
         Z1JGJQs3ACX5Cc7hLdiVoTzU91awUW7T2gJN09uztUqsZau529o97Aii3ng0DMKfrylQ
         3rVrLTVVkIb/kCs8wwBAzzU+WS+xRRJfiuCMYdiNoP3fx5roXDyGcuSPHKrD+umCWuPj
         n8l60qqwMwFDsTovrIFqLe64aL4/kleIg7hXJWtKYyHl6We099asexr347P//sjjReWE
         FVfaTS6VloimCcM5qqlpJ1Hn9b+bZ2pE1ojsZR79R1mGszPf6arKDnJnuDy1Ew8GzFBP
         AnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=xAKOFJb3UCHqSkUxT6ctwp3EpXozvdmMERv12bvWtRY=;
        b=UwoLfacOnlnjy+UbNXyXTFFb/IPopu+DFKDb75Pq+Db0JnL26MiK40sChhb0T8dn8p
         AyijDnt0f6Pk4yeKpPXZXoXHLPI0NISs/+tOSbzbxRlTOOSrAJd2bTaHLbkq8etcCZ3d
         BtULkdJ1qqFinIM2vpF8VMxnwKm1+FDjwWaFYfPTmw6ccNqyyVMRIHQnVba2AzTXK0kP
         ESL63T4mlZTyCmtvlkOpG6errHXxscQUudfg00Rtm9A1dqgwWdXFYlWpTZO2HjPCeKoK
         cXiPQSfEU/e/+rjUqYnuCNjvV2WUfxM8XjR7M/wNp8J7HmxQUQKcQ5P5EniQfF6YZbfS
         +apA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
X-IronPort-AV: E=Sophos;i="5.47,419,1515452400";
   d="scan'208";a="316234643"
Date: Sat, 3 Mar 2018 20:30:19 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
    linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: rtlwifi: Remove nonessential
 semicolon
In-Reply-To: <20180303190913.GA4555@seema-Inspiron-15-3567>
Message-ID: <alpine.DEB.2.20.1803032029530.9544@hadrien>
References: <20180303190913.GA4555@seema-Inspiron-15-3567>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593944760113219077?=
X-GMAIL-MSGID: =?utf-8?q?1593946061383978615?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Sun, 4 Mar 2018, Arushi Singhal wrote:

> Remove non-essential semicolon after 'else' and 'switch' statements. Issue
> found using semicolon.cocci Coccinelle script.
>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

It seems strange that someone would write code like that...

julia

> ---
>  drivers/staging/rtlwifi/base.c               | 6 +++---
>  drivers/staging/rtlwifi/phydm/phydm_rainfo.c | 1 -
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/rtlwifi/base.c b/drivers/staging/rtlwifi/base.c
> index c947def..eea0003 100644
> --- a/drivers/staging/rtlwifi/base.c
> +++ b/drivers/staging/rtlwifi/base.c
> @@ -710,20 +710,20 @@ u8 rtl_mrate_idx_to_arfr_id(
>  			ret = RATEID_IDX_BGN_40M_1SS;
>  		else
>  			ret = RATEID_IDX_BGN_40M_2SS;
> -		; break;
> +		break;
>  	case RATR_INX_WIRELESS_N:
>  	case RATR_INX_WIRELESS_NG:
>  		if (rtlphy->rf_type == RF_1T1R)
>  			ret = RATEID_IDX_GN_N1SS;
>  		else
>  			ret = RATEID_IDX_GN_N2SS;
> -		; break;
> +		break;
>  	case RATR_INX_WIRELESS_NB:
>  		if (rtlphy->rf_type == RF_1T1R)
>  			ret = RATEID_IDX_BGN_20M_1SS_BN;
>  		else
>  			ret = RATEID_IDX_BGN_20M_2SS_BN;
> -		; break;
> +		break;
>  	case RATR_INX_WIRELESS_GB:
>  		ret = RATEID_IDX_BG;
>  		break;
> diff --git a/drivers/staging/rtlwifi/phydm/phydm_rainfo.c b/drivers/staging/rtlwifi/phydm/phydm_rainfo.c
> index 8c08c76..e10a91a 100644
> --- a/drivers/staging/rtlwifi/phydm/phydm_rainfo.c
> +++ b/drivers/staging/rtlwifi/phydm/phydm_rainfo.c
> @@ -142,7 +142,6 @@ void odm_c2h_ra_para_report_handler(void *dm_void, u8 *cmd_buf, u8 cmd_len)
>  				     "SGI_support =", cmd_buf[7]);
>  			ODM_RT_TRACE(dm, ODM_FW_DEBUG_TRACE, "%5s  %d\n",
>  				     "Rate_ID =", cmd_buf[8]);
> -			;
>  		}
>  		ODM_RT_TRACE(dm, ODM_FW_DEBUG_TRACE,
>  			     "-------------------------------\n");
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180303190913.GA4555%40seema-Inspiron-15-3567.
> For more options, visit https://groups.google.com/d/optout.
>
