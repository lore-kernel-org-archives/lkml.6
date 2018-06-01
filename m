Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753032AbeFAQhh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:37:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751777AbeFAQhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:37:34 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Zhang Rui <rui.zhang@intel.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1527845302-12159-2-git-send-email-geert+renesas@glider.be>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
 <1527845302-12159-2-git-send-email-geert+renesas@glider.be>
Message-ID: <152787105335.144038.419639779875099925@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/4] clk: renesas: cpg-mssr: Stop using printk format %pCr
Date: Fri, 01 Jun 2018 09:37:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51GchLi015863

Quoting Geert Uytterhoeven (2018-06-01 02:28:19)
> Printk format "%pCr" will be removed soon, as clk_get_rate() must not be
> called in atomic context.
> 
> Replace it by open-coding the operation.  This is safe here, as the code
> runs in task context.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
