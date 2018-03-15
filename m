Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeCOJR0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:17:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52862 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeCOJRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:17:25 -0400
Date: Thu, 15 Mar 2018 10:17:08 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 2/3] x86/cpufeatures: Add WBNOINVD cpufeature
In-Reply-To: <20180119121821.77018-3-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1803151015330.1525@nanos.tec.linutronix.de>
References: <20180119121821.77018-1-kirill.shutemov@linux.intel.com> <20180119121821.77018-3-kirill.shutemov@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-335942310-1521105429=:1525"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-335942310-1521105429=:1525
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 19 Jan 2018, Kirill A. Shutemov wrote:

> CPUID.0x80000008:EBX[9] indicates whether CPU supports WBNOINVD
> instruction.
> 
> The WBNOINVD instruction writes back all modified cache lines in the
> processor’s internal cache to main memory and does not invalidate
> (flush) the internal caches.

That's describing what that instruction does. Could you please explain why
this is useful and what kind of usage you envision for that.

Thanks,

	tglx

--8323329-335942310-1521105429=:1525--
