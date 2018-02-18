Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbeBRMqy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 07:46:54 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:37434 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbeBRMqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 07:46:53 -0500
X-Google-Smtp-Source: AH8x226KTDcSgxF/jZSje+H+ioeyed6HoKmfQcRY58pyeSi337b/QHsthgA0i1h73y4V4XIvmG21Yw==
Date: Sun, 18 Feb 2018 13:46:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: bp@suse.de, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/microcode/intel: Check microcode revision before
 updating sibling threads
Message-ID: <20180218124649.lgaqfafskepsvup4@gmail.com>
References: <1518809669-3651-1-git-send-email-ashok.raj@intel.com>
 <20180217075053.2muugr2ioqvawfxv@gmail.com>
 <20180217121042.GA23981@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217121042.GA23981@araj-mobl1.jf.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Raj, Ashok <ashok.raj@intel.com> wrote:

> Hi Ingo
> 
> On Sat, Feb 17, 2018 at 08:50:53AM +0100, Ingo Molnar wrote:
> > 
> > Also, more fundamentally, during microcode early testing, isn't it possible for 
> > internal iterations of the microcode to have the same revision, but be different?
> 
> Atleast we don't do that here. Such debug microcode isn't OS loadable. 
> Anything that comes out ready for OS loading, the version will keep moving.

Ok.

Thanks,

	Ingo
