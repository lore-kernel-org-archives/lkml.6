Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbeAaMkC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 07:40:02 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:36536 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeAaMjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 07:39:33 -0500
Date: Wed, 31 Jan 2018 13:39:27 +0100
From: Simon Horman <horms@verge.net.au>
To: Dave Young <dyoung@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>, sergey.senozhatsky@gmail.com,
        akpm@linux-foundation.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] print kdump kernel loaded status in stack dump
Message-ID: <20180131123925.gr6hgxuoxflqipl5@verge.net.au>
References: <20180127041129.GA29016@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180127041129.GA29016@dhcp-128-65.nay.redhat.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27, 2018 at 12:11:29PM +0800, Dave Young wrote:
> It is useful to print kdump kernel loaded status in dump_stack() 
> especially when panic happens so that we can differenciate 
> kdump kernel early hang and a normal panic in a bug report.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
