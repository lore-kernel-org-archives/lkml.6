Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeBTMia (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:38:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:21116 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbeBTMi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:38:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,539,1511856000";
   d="scan'208";a="205528743"
Date: Tue, 20 Feb 2018 20:38:19 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Juergen Gross <jgross@suse.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Ingo Molnar <mingo@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [RFC PATCH tip] x86/acpi: u64_x86_init_noop() can be static
Message-ID: <20180220123819.GA20499@lkp-wsm-ep1>
References: <201802202043.UzW7iu9d%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201802202043.UzW7iu9d%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 62d8b7fba8d3 ("x86/acpi: Add a new x86_init_acpi structure to x86_init_ops")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 0 files changed
