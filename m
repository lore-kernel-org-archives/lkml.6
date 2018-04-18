Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeDRRJI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:09:08 -0400
Received: from muru.com ([72.249.23.125]:37112 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752336AbeDRRJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:09:07 -0400
Date: Wed, 18 Apr 2018 10:09:03 -0700
From: Tony Lindgren <tony@atomide.com>
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] ARM: omap2: Fix build when using split object directories
Message-ID: <20180418170903.GG5671@atomide.com>
References: <20180411211543.7923-1-d-gerlach@ti.com>
 <20180412082157.GB4002@localhost.localdomain>
 <CAK7LNAQiq-4daX2K4dPyzN7zr+yfkQWSJ-yy9JHgacPpYFp94w@mail.gmail.com>
 <4343a047-18b1-409d-ccda-94e72ea63e2a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4343a047-18b1-409d-ccda-94e72ea63e2a@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [180413 14:08]:
> This is the version of this patch that we want to use, will this go through you?

Sorry for the delay, I just noticed this. Somehow I thought Santosh
would queue it, but as the regression was introduced by a commit in
my tree I'll pick this patch into omap-for-v4.17/fixes.

Thanks,

Tony
