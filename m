Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C492EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952F12089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952F12089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeJBVML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:12:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60237 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:12:10 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7Lec-0005jn-3q; Tue, 02 Oct 2018 16:28:02 +0200
Date:   Tue, 2 Oct 2018 16:28:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Travis, Mike" <mike.travis@hpe.com>
cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Hedi Berriche <hedi@sgi.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ram Pai <linuxram@us.ibm.com>,
        "Gross, Juergen" <JGross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Sinan Kaya <okaya@codeaurora.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Fix community TSC ADJUST breakage causing TSC
 failure
In-Reply-To: <3351341c-6288-ac68-b4f6-b5794078f63c@hpe.com>
Message-ID: <alpine.DEB.2.21.1810021627180.12704@nanos.tec.linutronix.de>
References: <20181002012204.297193336@stormcage.americas.sgi.com> <alpine.DEB.2.21.1810020823550.32062@nanos.tec.linutronix.de> <3351341c-6288-ac68-b4f6-b5794078f63c@hpe.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2018, Travis, Mike wrote:
> On 10/1/2018 11:24 PM, Thomas Gleixner wrote:
> > On Mon, 1 Oct 2018, Mike Travis wrote:
> > 
> > I'm not sure what a 'community TSC adjust breakage' means.
> > 
> 
> I probably should have cleaned that up.  The title is from our internal 
> bug report and we target where the earliest place where the fix should 
> be applied.  "Community" is shorthand for the Linux Community Kernel (as 
> opposed to internal or distro specific problems).

That was my guess. I just found the subject line amusing.

Thanks,

	tglx

