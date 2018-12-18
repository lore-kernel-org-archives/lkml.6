Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2799C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2646214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 01:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="qU22kILk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbeLRBDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 20:03:06 -0500
Received: from ozlabs.org ([203.11.71.1]:37877 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbeLRBDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 20:03:04 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 43Jfs147N3z9s7W; Tue, 18 Dec 2018 12:03:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1545094981; bh=XhohdHKKbKkb/2eKVljolsNzOjbM67+ahwmW5UFd0LY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qU22kILkLDoh10MHgAygbsBwUiO0Bpdkn6Gole4szSdHSxPYoT3XdANwS+ja3Ph3/
         pwG0IUtW7psnsFcd+Rbp8XgbpJF9J30fWwYGAtoOi9fCu7mOH4UH25J7mBxyNsrZCk
         uniCKm3VI635v+e/2lomZ1JCtcaqzwxVv0+TAbLzucTlNizKq7D8vtAOofh9O9toYt
         s+p6K1EDq/ThHdAS2DIMT5FgBMzU+eMAhPJsrgdJ9X64Hn35NKSVPHsedczbz3RW3V
         5Ri+sB6ig33eqgLSDTjDNanl0p0QkXlv39pGUbc5ZVcqcdBAZLx1tD0bKDppxVfShg
         H20vJJ6vvs/6A==
Date:   Tue, 18 Dec 2018 12:00:14 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     benh@kernel.crashing.org, mpe@ellerman.id.au,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
Message-ID: <20181218010014.GB25748@blackberry>
References: <20181105144717.6233-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105144717.6233-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 09:47:17AM -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Thanks, patch applied to my kvm-ppc-next branch.

Paul.
