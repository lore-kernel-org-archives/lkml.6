Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753602AbeDPUIu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 16:08:50 -0400
Received: from ms.lwn.net ([45.79.88.28]:58712 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753323AbeDPUIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 16:08:48 -0400
Date: Mon, 16 Apr 2018 14:08:46 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Thymo van Beers <thymovanbeers@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kernel-parameters.txt: Fix whitespace
Message-ID: <20180416140846.0effe6ad@lwn.net>
In-Reply-To: <20180416154458.GA24716@thinkpad>
References: <20180416154458.GA24716@thinkpad>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2018 17:45:01 +0200
Thymo van Beers <thymovanbeers@gmail.com> wrote:

> Some lines used spaces instead of tabs at line start.
> This can cause mangled lines in editors due to inconsistency.
> 
> Replace spaces for tabs where appropriate.

Seems like a fine idea.  The patch doesn't apply, though; can you please
make a version against current docs-next?  (Or against 4.17-rc1 will work
too).

Also...

>  			domain
> -			  Isolate from the general SMP balancing and scheduling
> -			  algorithms. Note that performing domain isolation this way
> -			  is irreversible: it's not possible to bring back a CPU to
> -			  the domains once isolated through isolcpus. It's strongly
> -			  advised to use cpusets instead to disable scheduler load
> -			  balancing through the "cpuset.sched_load_balance" file.
> -			  It offers a much more flexible interface where CPUs can
> -			  move in and out of an isolated set anytime.
> -
> -			  You can move a process onto or off an "isolated" CPU via
> -			  the CPU affinity syscalls or cpuset.
> -			  <cpu number> begins at 0 and the maximum value is
> -			  "number of CPUs in system - 1".
> +				Isolate from the general SMP balancing and scheduling
> +				algorithms. Note that performing domain isolation this way
> +				is irreversible: it's not possible to bring back a CPU to
> +				the domains once isolated through isolcpus. It's strongly
> +				advised to use cpusets instead to disable scheduler load
> +				balancing through the "cpuset.sched_load_balance" file.
> +				It offers a much more flexible interface where CPUs can
> +				move in and out of an isolated set anytime.
> +
> +			You can move a process onto or off an "isolated" CPU via
> +			the CPU affinity syscalls or cpuset.
> +			<cpu number> begins at 0 and the maximum value is
> +			"number of CPUs in system - 1".

This would appear to have changed the indentation of some of the text?

Thanks,

jon
