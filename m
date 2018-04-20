Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754612AbeDTKl3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:41:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42352 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeDTKl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:41:28 -0400
Date: Fri, 20 Apr 2018 03:41:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        private@roeck-us.net
Subject: Re: [PATCH 6/9] nds32: Fix the symbols undefined issue by exporting
 them.
Message-ID: <20180420104126.GA20680@infradead.org>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
 <b80a4634cf77694dd90d510175a6633a93ea639d.1524143428.git.greentime@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b80a4634cf77694dd90d510175a6633a93ea639d.1524143428.git.greentime@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/arch/nds32/kernel/stacktrace.c
> @@ -9,6 +9,7 @@ void save_stack_trace(struct stack_trace *trace)
>  {
>  	save_stack_trace_tsk(current, trace);
>  }
> +EXPORT_SYMBOL(save_stack_trace);

All other architectures use EXPORT_SYMBOL_GPL here.
