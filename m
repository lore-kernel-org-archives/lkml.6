Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C1CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B94A20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfARPAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:00:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:42049 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfARPAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:00:17 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 07:00:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; 
   d="scan'208";a="115700132"
Received: from unknown (HELO localhost) ([10.249.254.249])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jan 2019 07:00:14 -0800
Date:   Fri, 18 Jan 2019 17:00:11 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Safford, David (GE Global Research)" <david.safford@ge.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] Extend TPM PPI interface to support revision 1.3
Message-ID: <20190118150011.GF4080@linux.intel.com>
References: <20190109221103.1897677-1-stefanb@linux.vnet.ibm.com>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C0151A3125@ALPMBAPA12.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BCA04D5D9A3B764C9B7405BBA4D4A3C0151A3125@ALPMBAPA12.e2k.ad.ge.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 08:28:00PM +0000, Safford, David (GE Global Research) wrote:
> You might mention that this is an important feature, as on at least some
> systems, ppi function 23 is the only way to enable/disable PCR banks.
> 
> I have tested this patch set on my HP Spectre laptop, and I am finally
> able to turn the sha-1 bank on and off. Much appreciated!
> 
> Tested-by: David Safford <david.safford@ge.com>

Great thanks David.

/Jarkko
