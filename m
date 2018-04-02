Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeDBQSS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:18:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40064 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751647AbeDBQSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:18:14 -0400
Date: Mon, 2 Apr 2018 18:17:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: Khan M Rashedun-Naby <naby88@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        thomas.lendacky@amd.com, jgross@suse.com, r.marek@assembler.cz,
        qianyue.zj@alibaba-inc.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed some style warnings and errors
Message-ID: <20180402161708.GA22516@pd.tnic>
References: <1522682263-11935-1-git-send-email-naby88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1522682263-11935-1-git-send-email-naby88@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 09:17:43PM +0600, Khan M Rashedun-Naby wrote:
> @@ -820,14 +821,22 @@ static void init_amd(struct cpuinfo_x86 *c)
>  		clear_cpu_cap(c, X86_FEATURE_MCE);
>  
>  	switch (c->x86) {
> -	case 4:    init_amd_k5(c); break;
> -	case 5:    init_amd_k6(c); break;
> -	case 6:	   init_amd_k7(c); break;
> -	case 0xf:  init_amd_k8(c); break;
> -	case 0x10: init_amd_gh(c); break;
> -	case 0x12: init_amd_ln(c); break;
> -	case 0x15: init_amd_bd(c); break;
> -	case 0x17: init_amd_zn(c); break;
> +	case 4:
> +	  init_amd_k5(c); break;
> +	case 5:
> +	  init_amd_k6(c); break;
> +	case 6:
> +	  init_amd_k7(c); break;
> +	case 0xf:
> +	  init_amd_k8(c); break;
> +	case 0x10:
> +	  init_amd_gh(c); break;
> +	case 0x12:
> +	  init_amd_ln(c); break;
> +	case 0x15:
> +	  init_amd_bd(c); break;
> +	case 0x17:
> +	  init_amd_zn(c); break;

No, it was compact and more readable before.

In general, I'd very much advise *not* to do checkpatch-only patches.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
