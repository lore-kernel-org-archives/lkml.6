Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeBADkf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 22:40:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:3356 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751296AbeBADkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 22:40:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,443,1511856000";
   d="scan'208";a="16060319"
Date: Thu, 1 Feb 2018 09:15:08 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Yang Shunyong <shunyong.yang@hxt-semitech.com>,
        Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: dmatest: change symbolic permissions to
 octal values
Message-ID: <20180201034507.GZ18649@localhost>
References: <1516617881-30044-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <20180129044801.GL18649@localhost>
 <CAOh2x=naBBc-Os=+yFocc3fTri2pebMqdR4=qN+vpHrD0gvunQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOh2x=naBBc-Os=+yFocc3fTri2pebMqdR4=qN+vpHrD0gvunQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 03:31:48PM +0530, Viresh Kumar wrote:
> On Mon, Jan 29, 2018 at 10:18 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Mon, Jan 22, 2018 at 06:44:40PM +0800, Yang Shunyong wrote:
> >> Current coding style prefers octal permissions values. This patch
> >> changes symbolic permissions to octal values.
> >
> > Is this preference documented anywhere?
> 
> This is where it started.
> 
> lkml.kernel.org/r/CA+55aFzu59sXo7qA8CoCo+tSJgEkW7fWDjkt_tsTzPWZ7gxj1A@mail.gmail.com

Right but lets no go changing to octals everywhere, new code sure :)
I don't see plans to remove representations entirely from kernel yet.

-- 
~Vinod
