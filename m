Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeBZSFY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:05:24 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53886 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751558AbeBZSFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:05:20 -0500
Date: Mon, 26 Feb 2018 18:05:21 +0000
From: Will Deacon <will.deacon@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, james.morse@arm.com
Subject: Re: [PATCH v2 2/2] arm64: Expose Arm v8.4 features
Message-ID: <20180226180521.GH26147@arm.com>
References: <20180207142106.10716-1-suzuki.poulose@arm.com>
 <20180207142106.10716-2-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207142106.10716-2-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 02:21:06PM +0000, Suzuki K Poulose wrote:
> Expose the new features introduced by Arm v8.4 extensions to
> Arm v8-A profile.
> 
> These include :
> 
>  1) Data indpendent timing of instructions. (DIT, exposed as HWCAP_DIT)
>  2) Unaligned atomic instructions and Single-copy atomicity of loads
>     and stores. (AT, expose as HWCAP_USCAT)
>  3) LDAPR and STLR instructions with immediate offsets (extension to
>     LRCPC, exposed as HWCAP_ILRCPC)
>  4) Flag manipulation instructions (TS, exposed as HWCAP_FLAGM).

Please resend this but continuing with the default of FTR_STRICT, as we
currently have. That way this can be merged while we work out what we want
to do there.

> While at it get rid of the RES0 entries in the cpu-feature-registers.txt
> documentation, as:
>  1) We care only about the user visible fields.
>  2) The field may not be up-to-date
>  3) We already explain the rules of the fields if it is not visible.

Please spin this part as a separate patch.

Will
