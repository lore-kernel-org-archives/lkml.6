Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753801AbeBGLKV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:10:21 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:53692 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753720AbeBGLKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:10:19 -0500
X-Google-Smtp-Source: AH8x226pFgqoV2b80Z/R837FymJdtgaBUHq7/cR4eIFqhShv8hhNoaAHWF+UGSb3T+3BnZUGY0B6xA==
Date: Wed, 7 Feb 2018 14:10:16 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Kai Huang <kai.huang@linux.intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/tme: Detect if TME and MKTME is activated by BIOS
Message-ID: <20180207111016.st365i56w67gmjbj@node.shutemov.name>
References: <20180131091509.26531-1-kirill.shutemov@linux.intel.com>
 <20180131091509.26531-3-kirill.shutemov@linux.intel.com>
 <1517978050.23889.23.camel@linux.intel.com>
 <20180207081627.eomxuyqw74eew756@node.shutemov.name>
 <1518001244.23889.32.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518001244.23889.32.camel@linux.intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 12:00:44AM +1300, Kai Huang wrote:
> > Suggestions?
> 
> I would go with 'tme_cryto_alg', and 'mktme_supported_crypto_algs' for
> the two variables, and TME_CRYPTO_ALG(x), TME_CRYPTO_ALG_AES_XTS_128, 
> MKTME_SUPPORTED_CRYPTO_ALGS(x), and MKTME_CRYPTO_ALG_AES_XTS_128 for
> the macros, but it's up to you and other guys.

I'll leave it as is for now.

> Btw I do think AES_XTS should be AES_XTS_128, even you go with current
> names, as AES cipher can also take 256-bit key.

Good point.

-- 
 Kirill A. Shutemov
