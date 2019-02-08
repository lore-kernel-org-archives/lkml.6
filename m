Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294BCC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5312075C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfBHOJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:09:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:29654 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbfBHOJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:09:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 06:09:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,347,1544515200"; 
   d="scan'208";a="145243182"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.115])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2019 06:09:52 -0800
Date:   Fri, 8 Feb 2019 16:09:52 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v11 00/16] Remove nested TPM operations
Message-ID: <20190208140952.GB25255@linux.intel.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
 <20190206120634.GA4680@linux.intel.com>
 <3d6fdcc1-8221-2137-fc82-596377cc2fdc@infineon.com>
 <20190207212912.GD23906@linux.intel.com>
 <0af40351-91d5-d0a7-2965-0a9c6505af79@linux.ibm.com>
 <20190208003314.GB7202@linux.intel.com>
 <1fbd29ad-1005-8450-4c39-00974468183b@linux.ibm.com>
 <9cd734ad-ea9d-77f7-b657-3f0910a9d92f@linux.ibm.com>
 <515b6c56-59e9-468d-35e0-3ae183bcea8c@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <515b6c56-59e9-468d-35e0-3ae183bcea8c@infineon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 02:28:50PM +0100, Alexander Steffen wrote:
> Applying those changes fixes all the issues I saw, thanks. I'll retest
> Jarkko's tree without custom patches, once you've agreed on the rc question.

Just send a two patch patch set how I believe the regression should
be properly fixed.

Do not have right now dTPM at hand (the NUC that has one does not
respond SSH for some reason) so I need help with testing.

/Jarkko
