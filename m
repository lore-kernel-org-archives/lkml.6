Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeBIIQO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 03:16:14 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:46035 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeBIIQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:16:10 -0500
X-Google-Smtp-Source: AH8x226HIY31Wzg5CQjJazGAjFISxlbiraBD5zAh9omtVn65KzKAAD4ElUkFqoI9yz29/yU0feu2Vw==
Date: Fri, 9 Feb 2018 17:16:04 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Dave Young <dyoung@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] printk: move dump stack related code to lib/dump_stack.c
Message-ID: <20180209081604.GE689@jagdpanzerIV>
References: <20180209080624.GA2607@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209080624.GA2607@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (02/09/18 16:06), Dave Young wrote:
[..]
> +void __init dump_stack_set_arch_desc(const char *fmt, ...)
..
> +void dump_stack_print_info(const char *log_lvl)
..
> +void show_regs_print_info(const char *log_lvl)
..

Seems that those functions are still defined in printk header.
Did you test !CONFIG_PRINTK build?

	-ss
