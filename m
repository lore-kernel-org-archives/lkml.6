Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966654AbeCAI5t (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:57:49 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50515 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966635AbeCAI5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:57:47 -0500
Date: Thu, 1 Mar 2018 09:57:44 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ivan Gorinov <ivan.gorinov@intel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: [PATCH v2 1/3] x86: devicetree: call early_init_dt_verify()
In-Reply-To: <1519872327.58658.187.camel@intel.com>
Message-ID: <alpine.DEB.2.21.1803010950280.1396@nanos.tec.linutronix.de>
References: <1519872327.58658.187.camel@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-526270464-1519894665=:1396"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-526270464-1519894665=:1396
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 28 Feb 2018, Ivan Gorinov wrote:

> Call to early_init_dt_verify() is required to prepare DTB data.
> It was called from arch/arm and arch/powerpc, but not arch/x86.
> 
> Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
> ---
>  arch/x86/kernel/devicetree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
> index 25de5f6..44189ee 100644
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -278,6 +278,7 @@ static void __init x86_flattree_get_config(void)
>  		map_len = size;

  ^
  ^
  Your patches are still whitespace damaged and fail to apply

patching file arch/x86/kernel/devicetree.c
patch: **** malformed patch at line 23:  		map_len = size;

Please fix your mail setup and please make the patch series properly
threaded. There is plenty of documentation and your coworkers surely can
help you with that.

Thanks,

	tglx


--8323329-526270464-1519894665=:1396--
