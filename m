Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6A8C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA02E245D8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA02E245D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755399AbeF2LbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:31:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:46221 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752804AbeF2LbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:31:14 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 04:31:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="52845898"
Received: from egur-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.49])
  by orsmga007.jf.intel.com with ESMTP; 29 Jun 2018 04:31:08 -0700
Date:   Fri, 29 Jun 2018 14:31:07 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v5] tpm: Return the actual size when receiving an
 unsupported command
Message-ID: <20180629113107.GA10894@linux.intel.com>
References: <20180626153145.7408-1-Ricardo.Schwarzmeier@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626153145.7408-1-Ricardo.Schwarzmeier@infineon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 05:31:45PM +0200, Ricardo Schwarzmeier wrote:
> The userpace expects to read the number of bytes stated in the header.
> Returning the size of the buffer instead would be unexpected.
> Fixes: 095531f891e6 ("tpm: return a TPM_RC_COMMAND_CODE response if command is not implemented")
> 
> Signed-off-by: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
