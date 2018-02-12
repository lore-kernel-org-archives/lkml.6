Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932539AbeBLCQL convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 21:16:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:37745 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932483AbeBLCQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 21:16:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,499,1511856000";
   d="scan'208";a="17374263"
Message-ID: <1518401767.49408.6.camel@intel.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the nios2 tree
From: Ley Foon Tan <ley.foon.tan@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Ley Foon Tan <lftan@altera.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 12 Feb 2018 10:16:07 +0800
In-Reply-To: <20180212131414.0ca70c63@canb.auug.org.au>
References: <20180212092043.33045460@canb.auug.org.au>
         <1518398629.49408.4.camel@intel.com>
         <20180212131414.0ca70c63@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-12 at 13:14 +1100, Stephen Rothwell wrote:
> Hi Ley,
> 
> On Mon, 12 Feb 2018 09:23:49 +0800 Ley Foon Tan <ley.foon.tan@intel.c
> om> wrote:
> > 
> > 
> > On Mon, 2018-02-12 at 09:20 +1100, Stephen Rothwell wrote:
> > > 
> > > 
> > > Commits
> > > 
> > >   5d13c7317998 ("nios2: dts: Remove leading 0x and 0s from
> > > bindings
> > > notation")
> > >   e0691ebb33c1 ("nios2: defconfig: Cleanup from old Kconfig
> > > options")
> > > 
> > > are missing a Signed-off-by from their committer.
> > There are Signed-off-by in the commits.
> > 
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> They are the authors of the patches, but you are the committer i.e.
> you
> are on the path form the authors to Linus, so you need to add a
> Signed-off-by tag as well.  I see Linus has merged theses commits
> now,
> so there is nothing to be done for them, but in the future please add
> a
> Signed-off-by tag for anything that you commit.
> 
> See section 11 of Documentation/process/submitting-patches.rst
> --
Noted. Thanks.

Regards
Ley Foon
