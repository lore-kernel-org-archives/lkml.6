Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeDPF7g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 01:59:36 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49101 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752310AbeDPF7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 01:59:35 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="38908436"
Subject: Re: [PATCH] x86/tools/relocs: comments cleanup
From: Cao jin <caoj.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>
References: <20180305071534.43448-1-caoj.fnst@cn.fujitsu.com>
Message-ID: <5e3179f3-9f94-6368-8a91-8f8bca94d333@cn.fujitsu.com>
Date: Mon, 16 Apr 2018 13:59:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305071534.43448-1-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: BE88548AE921.A86B7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On 03/05/2018 03:15 PM, Cao jin wrote:
> 1. typo fix: there -> their
> 2. remove superfluous "by"
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  arch/x86/tools/relocs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index 5d73c443e778..fcf3fad01b08 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -37,7 +37,7 @@ static struct section *secs;
>  
>  static const char * const sym_regex_kernel[S_NSYMTYPES] = {
>  /*
> - * Following symbols have been audited. There values are constant and do
> + * Following symbols have been audited. Their values are constant and do
>   * not change if bzImage is loaded at a different physical address than
>   * the address for which it has been compiled. Don't warn user about
>   * absolute relocations present w.r.t these symbols.
> @@ -690,7 +690,7 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
>   *	to the start of the per_cpu area that does not change).
>   *
>   *	Relocations that apply to the per_cpu area need to have their
> - *	offset adjusted by by the value of __per_cpu_load to make them
> + *	offset adjusted by the value of __per_cpu_load to make them
>   *	point to the correct place in the loaded image (because the
>   *	virtual address of .data..percpu is 0).
>   *
> 

-- 
Sincerely,
Cao jin
