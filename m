Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753452AbeA3Wjl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:39:41 -0500
Received: from foss.arm.com ([217.140.101.70]:59786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752163AbeA3Wjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:39:40 -0500
Date: Tue, 30 Jan 2018 22:39:36 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [GIT PULL] arm64 updates for 4.16
Message-ID: <20180130223935.rabtqvlvtqps53fg@armageddon.cambridge.arm.com>
References: <20180130192636.sctfdnedffxv7vmv@armageddon.cambridge.arm.com>
 <CA+55aFxwU54sa=b=kE0pCromBJAQRhYqCwkJZXy9vDqY2D=kJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxwU54sa=b=kE0pCromBJAQRhYqCwkJZXy9vDqY2D=kJw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 02:02:45PM -0800, Linus Torvalds wrote:
> On Tue, Jan 30, 2018 at 11:26 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
> 
> I got some fairly trivial conflicts on the merge, and I expect them to
> be fine but since I don't do a build/boot test on arm64 somebody
> should verify that.

Sorry, I forgot to include my merge resolution with the pull request.
Mainline looks fine.

Thanks.

-- 
Catalin
