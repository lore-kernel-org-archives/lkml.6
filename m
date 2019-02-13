Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978E1C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715AE222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388758AbfBMHoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:44:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:38921 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728713AbfBMHoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:44:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 23:44:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="124098807"
Received: from sorenthe-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Feb 2019 23:44:24 -0800
Date:   Wed, 13 Feb 2019 09:44:23 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tpm: Unify the send callback behaviour
Message-ID: <20190213074423.GA3950@linux.intel.com>
References: <20190208180857.12330-1-jarkko.sakkinen@linux.intel.com>
 <20190208180857.12330-2-jarkko.sakkinen@linux.intel.com>
 <4072b2b6-0f95-be50-0772-7e2869c2c24e@linux.ibm.com>
 <20190208190057.GA3439@linux.intel.com>
 <2849751f-ff26-193e-f15e-4d7d5f8525a7@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2849751f-ff26-193e-f15e-4d7d5f8525a7@infineon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 04:05:39PM +0100, Alexander Steffen wrote:
> Tested-by: Alexander Steffen <Alexander.Steffen@infineon.com>

Thank you!

/Jarkko
