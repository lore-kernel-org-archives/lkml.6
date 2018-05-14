Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeENIrq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:47:46 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:41728 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeENIrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:47:45 -0400
X-Google-Smtp-Source: AB8JxZq+4qgFWKvv+YGGyvS000gbfEv0ID/Vi0EteDUErbi4JzdZor2KsXJigUV8nVMbgCnz6zpH/g==
Date: Mon, 14 May 2018 10:47:41 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxram@us.ibm.com,
        tglx@linutronix.de, dave.hansen@intel.com, mpe@ellerman.id.au,
        akpm@linux-foundation.org, shuah@kernel.org, shakeelb@google.com
Subject: Re: [PATCH 00/13] [v4] x86, pkeys: two protection keys bug fixes
Message-ID: <20180514084741.GA7094@gmail.com>
References: <20180509171336.76636D88@viggo.jf.intel.com>
 <20180514082918.GA21574@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514082918.GA21574@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> So this series is looking good to me in principle, but trying to build it I got 
> warnings and errors - see the build log below.
> 
> Note that this is on a box with "Ubuntu 18.04 LTS (Bionic Beaver)".

So it turns out that the build errors already exist without the series applied, so 
it must be some interaction between the pkeys self-tests and latest Ubuntu.

Thanks,

	Ingo
