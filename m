Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54140C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDFB2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfBDReQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:34:16 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:55965 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDReQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:34:16 -0500
Received: from [176.12.107.132] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gqi8H-0002mS-OX; Mon, 04 Feb 2019 18:34:10 +0100
Date:   Mon, 4 Feb 2019 17:34:08 +0000 (GMT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
cc:     platform-driver-x86@vger.kernel.org, dvhart@infradead.org,
        andy@infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 06/10] x86/cpu: Add Icelake to Intel family
In-Reply-To: <20190201073234.13280-7-rajneesh.bhardwaj@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1902041731500.3006@nanos.tec.linutronix.de>
References: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com> <20190201073234.13280-7-rajneesh.bhardwaj@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019, Rajneesh Bhardwaj wrote:

> Add CPUID of Icelake (ICL) mobile processors to Intel family list. The
> Information related to ICL CPUID is referenced from below Coreboot
> project link.
> 
> https://github.com/coreboot/coreboot/blob/5ebcea3aaaa3cd358bc5bccaa156b13a6ef25df6/src/soc/intel/common/block/include/intelblocks/mp_init.h

Coreboot files are hardly authoritive information about CPUIDs.

> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 0dd6b0f4000e..12b65bdb3d80 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -52,6 +52,8 @@
>  
>  #define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
>  
> +#define INTEL_FAM6_ICELAKE_MOBILE       0x7E

Please use TABs instead of a random number of spaces.

Thanks,

	tglx
