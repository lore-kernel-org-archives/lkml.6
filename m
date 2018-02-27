Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeB0RFZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:05:25 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38748 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbeB0RFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:05:24 -0500
Date: Tue, 27 Feb 2018 17:05:19 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Jonathan Toppins <jtoppins@redhat.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, Jonathan Masters <jcm@redhat.com>,
        rafael.j.wysocki@intel.com, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, astone@redhat.com,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        andriy.shevchenko@linux.intel.com, Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64/acpi: make ACPI boot preference configurable
Message-ID: <20180227170518.56tvxkdh5fiochdd@lakrids.cambridge.arm.com>
References: <85047448dc1d2d3c725b6b78d5ef2a89fc81b83b.1519659254.git.jtoppins@redhat.com>
 <CACi5LpM9hn17o7i7R3GUjQYy=6DFtCFKSbDUN7A7MGBTuf7=xw@mail.gmail.com>
 <1b5a55bd-5bc7-ecd0-99f0-71dd05119743@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b5a55bd-5bc7-ecd0-99f0-71dd05119743@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 09:44:09AM -0500, Jonathan Toppins wrote:
> For arm64 DT is suppose to *not* be the preferred method, 

This has never been the upstream position.

DT has been the default since day one, and changing this would be a
regression, as has been stated several times in the past.

If *the system vendor* intends that the system only uses ACPI, they
would not provide a DT.

If *you* prefer to use ACPI, feel free to alter your kernel command
line.

Thanks,
Mark.
