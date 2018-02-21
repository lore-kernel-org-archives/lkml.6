Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932950AbeBUKU4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:20:56 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43917 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932798AbeBUKUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:20:51 -0500
X-Google-Smtp-Source: AH8x227gs/Ko3qJi5kHL+0TiVktjH7JQIu27c4E3X58lhxxsnp65XPUs4iKjPoyo8KLjxxDOC/Vnsw==
Date: Wed, 21 Feb 2018 11:20:47 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC PATCH tip] x86/acpi: u64_x86_init_noop() can be static
Message-ID: <20180221102047.iw4rzczin6rydlic@gmail.com>
References: <201802202043.UzW7iu9d%fengguang.wu@intel.com>
 <20180220123819.GA20499@lkp-wsm-ep1>
 <20180221085148.rs3t7zad73wbpktm@gmail.com>
 <bad54214-f182-d1ed-9593-3ffc66aa33b4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad54214-f182-d1ed-9593-3ffc66aa33b4@suse.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Juergen Gross <jgross@suse.com> wrote:

> On 21/02/18 09:51, Ingo Molnar wrote:
> > 
> > * kbuild test robot <fengguang.wu@intel.com> wrote:
> > 
> >>
> >> Fixes: 62d8b7fba8d3 ("x86/acpi: Add a new x86_init_acpi structure to x86_init_ops")
> >> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> >> ---
> >>  0 files changed
> > 
> > -ENOPATCH?
> 
> I'll send a patch to add "static" to the noop functions of x86_init.c
> (not only the new one).

Thanks!

	Ingo
