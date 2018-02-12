Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932503AbeBLCOS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 21:14:18 -0500
Received: from ozlabs.org ([103.22.144.67]:33901 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932237AbeBLCOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 21:14:17 -0500
Date: Mon, 12 Feb 2018 13:14:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ley Foon Tan <ley.foon.tan@intel.com>
Cc: Ley Foon Tan <lftan@altera.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the nios2 tree
Message-ID: <20180212131414.0ca70c63@canb.auug.org.au>
In-Reply-To: <1518398629.49408.4.camel@intel.com>
References: <20180212092043.33045460@canb.auug.org.au>
        <1518398629.49408.4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1C2ENix024469

Hi Ley,

On Mon, 12 Feb 2018 09:23:49 +0800 Ley Foon Tan <ley.foon.tan@intel.com> wrote:
>
> On Mon, 2018-02-12 at 09:20 +1100, Stephen Rothwell wrote:
> > 
> > Commits
> > 
> >   5d13c7317998 ("nios2: dts: Remove leading 0x and 0s from bindings
> > notation")
> >   e0691ebb33c1 ("nios2: defconfig: Cleanup from old Kconfig options")
> > 
> > are missing a Signed-off-by from their committer.
> 
> There are Signed-off-by in the commits.
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

They are the authors of the patches, but you are the committer i.e. you
are on the path form the authors to Linus, so you need to add a
Signed-off-by tag as well.  I see Linus has merged theses commits now,
so there is nothing to be done for them, but in the future please add a
Signed-off-by tag for anything that you commit.

See section 11 of Documentation/process/submitting-patches.rst
-- 
Cheers,
Stephen Rothwell
