Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeC2ToF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 15:44:05 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:39357
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751082AbeC2ToE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 15:44:04 -0400
X-IronPort-AV: E=Sophos;i="5.48,378,1517871600";
   d="scan'208";a="260327958"
Date: Thu, 29 Mar 2018 21:44:02 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Fabio Estevam <festevam@gmail.com>
cc: Francisco Jerez <currojerez@riseup.net>, linux-pm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, kbuild-all@01.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        0day robot <fengguang.wu@intel.com>, Len Brown <lenb@kernel.org>,
        Nicolai Stange <nstange@suse.de>
Subject: Re: [kbuild-all] [PATCH] OPTIONAL: cpufreq/intel_pstate: fix
 debugfs_simple_attr.cocci warnings
In-Reply-To: <CAOMZO5CLpW+2yCYRwAJTPWtXgXkaPGyPQrB3cbBGYvV1fryUQw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1803292140340.2750@hadrien>
References: <alpine.DEB.2.20.1803292109180.2750@hadrien> <CAOMZO5CLpW+2yCYRwAJTPWtXgXkaPGyPQrB3cbBGYvV1fryUQw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Mar 2018, Fabio Estevam wrote:

> Hi Julia,
>
> On Thu, Mar 29, 2018 at 4:12 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >  Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
> >  for debugfs files.
> >
> > Semantic patch information:
> >  Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
> >  imposes some significant overhead as compared to
> >  DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
>
> Just curious: could you please expand on what "imposes some
> significant overhead" means?

I don't know.  I didn't write this rule.  Nicolai, can you explain?

thanks,
julia
