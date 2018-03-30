Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AIpwx49HJ0EZF3xBUNUkjYsA9uT0UC9y+STiT81zkDZeTm7lvq7WERFC9RFPYzplB5KKo4RAnbOx
ARC-Seal: i=1; a=rsa-sha256; t=1522436232; cv=none;
        d=google.com; s=arc-20160816;
        b=04zqPpnfkVq6FR9jqeX7Xdhe/OUGDonqnoSBW2KoSG+rS1tDUHhQXSlFKXav+Jwc7m
         0zjJyZJESXEiI6AXT7n5x7HoqJQVBv/nKrdHBOCak+/tcTWNzpWOy+8nJuf5LExo7bzf
         bxIxAKS/nz6BpkgRwrCEMeiSg8W1cd9V4yYkBj4m4fiZT17SI5EsGOSJGtMjuLIH9MWh
         BDufl1BCe7mcOBMTruEXmt/+zTJQnvDgu5z3hOnjcqKGcbtbNZVmPyStr9sXjaVXh/NZ
         i1mQ0jhNexkmSyW97GRIK1w6LU3VLidsUxfVsAo+GpMI0f/Cj8XiYv9QoWPGb66HFXzC
         lopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=ILHVzD4ZCBLOy5WdgXgZbylwzydDbgJpVx/36prDHpM=;
        b=wJqIfn9PSj48puwBTmbbcFghqXZ+z4mC8Gwk/dANDG3txFbolmc21E3rgvP/qPLTOI
         9qZTiCR0Gd52gHS7byH6dtmurKKZ4492H1OldPLzBRbqgKP/2Uv1q3hPtJaGq7A7gl4h
         8r8BhNlnv2Hl036fIeprDZ6vQa8+IImjdpdMvtyoCi3FIbZS0wiNMlAFVA1G/+jBeORh
         hL+xj0gJ4nuwvTZAMB2+wji4us2N7Nh3OVcLDo8XqURoc0284NtX/9aKuDTfTMzvl1A1
         I6BqXbrWiImTYmstFu2uVzpLPYbQ03n24zkpfsihEPdjeHVjrI2fW2jkDDuLZ0GqOKnv
         IXbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=OojnkfcD;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=OojnkfcD;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Fri, 30 Mar 2018 19:57:08 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
cc: Oleg Drokin <oleg.drokin@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Andreas Dilger <andreas.dilger@intel.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 02/17] staging: lustre: remove unused
 ldlm_completion_ast_async()
In-Reply-To: <152229760829.27689.12680083968318847851.stgit@noble>
Message-ID: <alpine.LFD.2.21.1803301957010.9681@casper.infradead.org>
References: <152229732768.27689.4800156943561963977.stgit@noble> <152229760829.27689.12680083968318847851.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180330_195708_258543_19E9A22E 
X-CRM114-Status: GOOD (  13.14  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244774179791010?=
X-GMAIL-MSGID: =?utf-8?q?1596390094144194438?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> This function is unused.

Reviewed-by: James Simmons <jsimmons@infradead.org>
 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  drivers/staging/lustre/lustre/include/lustre_dlm.h |    1 -
>  drivers/staging/lustre/lustre/ldlm/ldlm_request.c  |   23 --------------------
>  2 files changed, 24 deletions(-)
> 
> diff --git a/drivers/staging/lustre/lustre/include/lustre_dlm.h b/drivers/staging/lustre/lustre/include/lustre_dlm.h
> index 239aa2b1268f..7407acf60cf8 100644
> --- a/drivers/staging/lustre/lustre/include/lustre_dlm.h
> +++ b/drivers/staging/lustre/lustre/include/lustre_dlm.h
> @@ -1227,7 +1227,6 @@ int ldlm_lock_change_resource(struct ldlm_namespace *, struct ldlm_lock *,
>   * processing.
>   * @{
>   */
> -int ldlm_completion_ast_async(struct ldlm_lock *lock, __u64 flags, void *data);
>  int ldlm_completion_ast(struct ldlm_lock *lock, __u64 flags, void *data);
>  /** @} ldlm_local_ast */
>  
> diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c b/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
> index c3c9186b74ce..be43958e4090 100644
> --- a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
> +++ b/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
> @@ -191,29 +191,6 @@ static int ldlm_completion_tail(struct ldlm_lock *lock, void *data)
>  	return result;
>  }
>  
> -/**
> - * Implementation of ->l_completion_ast() for a client, that doesn't wait
> - * until lock is granted. Suitable for locks enqueued through ptlrpcd, of
> - * other threads that cannot block for long.
> - */
> -int ldlm_completion_ast_async(struct ldlm_lock *lock, __u64 flags, void *data)
> -{
> -	if (flags == LDLM_FL_WAIT_NOREPROC) {
> -		LDLM_DEBUG(lock, "client-side enqueue waiting on pending lock");
> -		return 0;
> -	}
> -
> -	if (!(flags & LDLM_FL_BLOCKED_MASK)) {
> -		wake_up(&lock->l_waitq);
> -		return ldlm_completion_tail(lock, data);
> -	}
> -
> -	LDLM_DEBUG(lock,
> -		   "client-side enqueue returned a blocked lock, going forward");
> -	return 0;
> -}
> -EXPORT_SYMBOL(ldlm_completion_ast_async);
> -
>  /**
>   * Generic LDLM "completion" AST. This is called in several cases:
>   *
> 
> 
> 
