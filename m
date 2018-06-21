Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC931C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A73216E6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A73216E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933622AbeFUQsZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:48:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:57895 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933391AbeFUQsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:48:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 09:48:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,252,1526367600"; 
   d="scan'208";a="66558219"
Received: from lmrad-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.46])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2018 09:48:19 -0700
Date:   Thu, 21 Jun 2018 19:48:19 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] tpm: Return the actual size when receiving an
 unsupported command
Message-ID: <20180621164819.GE11859@linux.intel.com>
References: <20180620095507.682-1-Ricardo.Schwarzmeier@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620095507.682-1-Ricardo.Schwarzmeier@infineon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:55:07AM +0200, Ricardo Schwarzmeier wrote:
> The command size is computed for the header anyway.
> It can as well indicate the correct number of bytes to read from the driver.
> Fixes: 095531f891e6 ("tpm: return a TPM_RC_COMMAND_CODE response if command is not implemented")
> 
> Signed-off-by: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>

Can you fix the kbuild error and send v3? Otherwise, LGMT.

/Jarkko
