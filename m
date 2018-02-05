Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeBEEsj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 23:48:39 -0500
Received: from ozlabs.org ([103.22.144.67]:37257 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752199AbeBEEs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 23:48:28 -0500
Date: Mon, 5 Feb 2018 15:48:21 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com,
        egtvedt@samfundet.no, linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, will.deacon@arm.com,
        tony@atomide.com, npiggin@gmail.com, yamada.masahiro@socionext.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/20] KVM: PPC: Book3S PR: Fix broken select due to
 misspelling
Message-ID: <20180205044821.3zvs7cfhdr3eu2qa@oak.ozlabs.ibm.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
 <20180205012146.23981-3-ulfalizer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205012146.23981-3-ulfalizer@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 02:21:14AM +0100, Ulf Magnusson wrote:
> Commit 76d837a4c0f9 ("KVM: PPC: Book3S PR: Don't include SPAPR TCE code
> on non-pseries platforms") added a reference to the globally undefined
> symbol PPC_SERIES. Looking at the rest of the commit, PPC_PSERIES was
> probably intended.
> 
> Change PPC_SERIES to PPC_PSERIES.
> 
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
> 
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>

Acked-by: Paul Mackerras <paulus@ozlabs.org>

Which tree is this series going into?

Paul.
