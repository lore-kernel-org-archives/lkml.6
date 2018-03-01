Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161013AbeCASho (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:37:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43312 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033985AbeCAShl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:37:41 -0500
Date: Thu, 1 Mar 2018 18:37:32 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64/efi: Make strrchr() available to the EFI namespace
Message-ID: <20180301183732.52ntz5trt26vpuhh@armageddon.cambridge.arm.com>
References: <20180301162803.5490-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301162803.5490-1-robh@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 10:28:03AM -0600, Rob Herring wrote:
> libfdt gained a new dependency on strrchr, so make it available to the
> EFI namespace before we update libfdt.
> 
> Thanks to Ard for providing this fix.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack. This is a dependency on a dtc upstream sync.

So I assume you'll merge this patch via the DT tree and we don't need to
pick it up through the arm64 tree.

-- 
Catalin
