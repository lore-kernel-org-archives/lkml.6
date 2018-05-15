Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753843AbeEOOKs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752491AbeEOOKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:10:47 -0400
Date: Tue, 15 May 2018 11:10:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Holger Freyther <automatic+kernel@freyther.de>,
        linux-kernel@vger.kernel.org,
        Holger Hans Peter Freyther <holgar+kernel@google.com>
Subject: Re: [RFC 0/6] perf probe: Attempt to improve C++ probing
Message-ID: <20180515141043.GG2917@kernel.org>
References: <20180514041940.96126-1-automatic+kernel@freyther.de>
 <20180514223107.3ff9d8249ef41b8dd2957591@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514223107.3ff9d8249ef41b8dd2957591@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 14, 2018 at 10:31:07PM +0900, Masami Hiramatsu escreveu:
> On Mon, 14 May 2018 12:19:34 +0800 Holger Freyther <automatic+kernel@freyther.de> wrote:
> >  ./perf probe -x . -V "std::vector<int, std::allocator<int> >::size%return"
 
> OK, this series looks good to me :)
 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> for this series.
 
> Arnaldo, could you pull this series?

Sure, I'm just waiting for Holger to comment on Namhyung points,

Thanks,

- Arnaldo
