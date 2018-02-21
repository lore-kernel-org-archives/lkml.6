Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeBUIvx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:51:53 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33387 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeBUIvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:51:52 -0500
X-Google-Smtp-Source: AH8x224anRSkHKupUMglolyXolWPhnqt7X1BAx1ROn7guPS0CUUMV1oTqTE3qK21YYgZVQGin5nNrw==
Date: Wed, 21 Feb 2018 09:51:48 +0100
From: Ingo Molnar <mingo@kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Juergen Gross <jgross@suse.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC PATCH tip] x86/acpi: u64_x86_init_noop() can be static
Message-ID: <20180221085148.rs3t7zad73wbpktm@gmail.com>
References: <201802202043.UzW7iu9d%fengguang.wu@intel.com>
 <20180220123819.GA20499@lkp-wsm-ep1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220123819.GA20499@lkp-wsm-ep1>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* kbuild test robot <fengguang.wu@intel.com> wrote:

> 
> Fixes: 62d8b7fba8d3 ("x86/acpi: Add a new x86_init_acpi structure to x86_init_ops")
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
>  0 files changed

-ENOPATCH?

Thanks,

	Ingo
