Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbeBQMKq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 07:10:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:13387 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750984AbeBQMKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 07:10:45 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,524,1511856000";
   d="scan'208";a="32208822"
Date: Sat, 17 Feb 2018 04:10:43 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: bp@suse.de, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/microcode/intel: Check microcode revision before
 updating sibling threads
Message-ID: <20180217121042.GA23981@araj-mobl1.jf.intel.com>
References: <1518809669-3651-1-git-send-email-ashok.raj@intel.com>
 <20180217075053.2muugr2ioqvawfxv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217075053.2muugr2ioqvawfxv@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo

On Sat, Feb 17, 2018 at 08:50:53AM +0100, Ingo Molnar wrote:
> 
> Also, more fundamentally, during microcode early testing, isn't it possible for 
> internal iterations of the microcode to have the same revision, but be different?

Atleast we don't do that here. Such debug microcode isn't OS loadable. 
Anything that comes out ready for OS loading, the version will keep moving.

> This patch would prevent re-loading it - for a seemingly minimal benefit.

Cheers,
Ashok
