Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932369AbeDWTnm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 15:43:42 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:49512 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932244AbeDWTnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 15:43:41 -0400
From: Richard Weinberger <richard@nod.at>
To: Alexander Pateenok <pateenoc@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] um: remove uml initcalls
Date: Mon, 23 Apr 2018 21:43:32 +0200
Message-ID: <63526108.WSV0FGAsac@blindfold>
In-Reply-To: <20180423182017.oxlfhnsrekk34q3b@K55DR>
References: <20180423182017.oxlfhnsrekk34q3b@K55DR>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander,

Am Montag, 23. April 2018, 20:20:17 CEST schrieb Alexander Pateenok:
> __uml_initcall() is not used and .uml.initcall.init section is empty:
> 
> $ grep -r '__uml_initcall('
> arch/um/include/shared/init.h:#define __uml_initcall(fn)	\
> $ readelf -s ../umobj/linux | grep __uml_initcall
>  23214: 00000000603b75d8     0 NOTYPE  GLOBAL DEFAULT   32 __uml_initcall_start
>  25337: 00000000603b75d8     0 NOTYPE  GLOBAL DEFAULT   32 __uml_initcall_end
> 
> So it is unnecessary.

Right. The last user was removed almost 10 years ago by:
d2efa6d5ce14 ("uml: remove the dead TTY_LOG code")

Thanks,
//richard
