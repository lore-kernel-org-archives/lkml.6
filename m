Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeA3IvB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 03:51:01 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38994 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeA3Iu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 03:50:59 -0500
X-Google-Smtp-Source: AH8x225afoLwEXv4MIp1M4Paw6vMDiixHpzTKpgCY5X0fMD8HVTFxXbszwNsLFP76JZ/eiLamvKEHw==
Date: Tue, 30 Jan 2018 17:50:55 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Dave Young <dyoung@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH V2] print kdump kernel loaded status in stack dump
Message-ID: <20180130085055.GA569@jagdpanzerIV>
References: <20180127041129.GA29016@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180127041129.GA29016@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/27/18 12:11), Dave Young wrote:
> It is useful to print kdump kernel loaded status in dump_stack() 
> especially when panic happens so that we can differenciate 
> kdump kernel early hang and a normal panic in a bug report.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Looks OK to me.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>


I agree with Steven, would be better to move the whole thing
to lib/dump_stack.c

	-ss
