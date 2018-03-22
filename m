Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeCVUMV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:12:21 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43359 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751765AbeCVUMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:12:19 -0400
X-ME-Sender: <xms:Ig60WvRKsGjuALTFAFrDLpOcUKu5315IrTOtogjOffDw1LFn32v53A>
Date: Fri, 23 Mar 2018 07:12:14 +1100
From: "Tobin C . Harding" <me@tobin.cc>
To: Joel Stanley <joel@jms.id.au>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Mention why %p prints ptrval
Message-ID: <20180322201214.GE3305@eros>
References: <20180322052336.1001-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322052336.1001-1-joel@jms.id.au>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 03:53:36PM +1030, Joel Stanley wrote:
> When debugging recent kernels, people will see '(ptrval)' but there
> isn't much information as to what that means. Briefly describe why it's
> there.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/core-api/printk-formats.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index 934559b3c130..eb30efdd2e78 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -60,8 +60,8 @@ Plain Pointers
>  Pointers printed without a specifier extension (i.e unadorned %p) are
>  hashed to prevent leaking information about the kernel memory layout. This
>  has the added benefit of providing a unique identifier. On 64-bit machines
> -the first 32 bits are zeroed. If you *really* want the address see %px
> -below.
> +the first 32 bits are zeroed. The kernel will print ``(ptrval)`` until it
> +gathers enough entropy. If you *really* want the address see %px below.

Acked-by: Tobin C. Harding <me@tobin.cc>

thanks,
Tobin.
