Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbeBQNmx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 08:42:53 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50945 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751050AbeBQNmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 08:42:52 -0500
X-ME-Sender: <xms:WzGIWrHYN_e-P9_y5Z4d1bspSHg0tTDPfVUTEHuN8FNsHG7hD3v-Mw>
Date: Sat, 17 Feb 2018 11:42:48 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Ashok Raj <ashok.raj@intel.com>
Cc: bp@suse.de, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/microcode: Check microcode revision before updating
 sibling threads
Message-ID: <20180217134247.sccdynjiqnk2mjby@khazad-dum.debian.net>
References: <1518806808-4074-1-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518806808-4074-1-git-send-email-ashok.raj@intel.com>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018, Ashok Raj wrote:
> After updating microcode on one of the threads in the core, the
> thread sibling automatically gets the update since the microcode
> resources are shared. Check the ucode revision on the cpu before
> performing a ucode update.

I wonder when this broke, because it used to do that just fine.

I even had to explain to a couple Debian users that no, nothing was
broken and yes, while it looked like the kernel was skipping some
"CPUs", it was actually updating all of them...

-- 
  Henrique Holschuh
