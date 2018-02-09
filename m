Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbeBIXA4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:00:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:32315 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752521AbeBIXAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:00:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,485,1511856000";
   d="scan'208";a="16668572"
Date: Fri, 9 Feb 2018 15:00:41 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        Nicolas Pitre <nico@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] x86 bugfixes for LTO
Message-ID: <20180209230041.GI10945@tassilo.jf.intel.com>
References: <20180202145434.100626-1-arnd@arndb.de>
 <151821507347.9954.4785393248908071074@mail.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151821507347.9954.4785393248908071074@mail.alporthouse.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 10:24:33PM +0000, Chris Wilson wrote:
> Quoting Arnd Bergmann (2018-02-02 14:54:28)
> > Here are three bugfixes for x86 that I needed to get LTO-enabled
> > kernels to build reliably. I'm not sure abouto that first one
> > though.
> 
> Is there a howto on how to build LTO kernels? I tried Andi's lto-415-2
> branch, but linking fails with lots of arcane PIE-vs-PIC errors. We are
> wanting to investigate how we can use LTO to reduce our (i915.ko) module
> size (by e.g. supporting a subset of chipsets).

What are the errors? Kernel shouldn't use PIE or PIC

-Andi
