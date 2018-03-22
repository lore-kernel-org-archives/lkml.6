Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932248AbeCVOIG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:08:06 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34902 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755751AbeCVOIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:08:05 -0400
X-Google-Smtp-Source: AG47ELupjGRdo8m0861k9HpyJgy71Q13Talq0dGZ6lUm6MaIYWED3DNAghmuDsCzxHd+OwgTw9X3ow==
Date: Thu, 22 Mar 2018 23:07:59 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1] printk: change message to pr_info
Message-ID: <20180322140759.GB561@tigerII.localdomain>
References: <20180322135833.16602-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322135833.16602-1-tomeu.vizoso@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/22/18 14:58), Tomeu Vizoso wrote:
> To allow userspace to prevent this message from appearing in the
> console by changing the log priority.
> 
> This matches other informative messages that the power subsystem emits
> when the system changes power states.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Well, no objections,

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
