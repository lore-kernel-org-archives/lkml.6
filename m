Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B7FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A90225DD5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A90225DD5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932507AbeFYQHe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:07:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:27138 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752658AbeFYQHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:07:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 09:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,270,1526367600"; 
   d="scan'208";a="67556824"
Received: from mstribae-mobl.ger.corp.intel.com ([10.249.254.44])
  by orsmga001.jf.intel.com with ESMTP; 25 Jun 2018 09:07:24 -0700
Message-ID: <09e36b0d97b5f01ea5925b5a3031198049714ce8.camel@linux.intel.com>
Subject: Re: [PATCH v4] tpm: Return the actual size when receiving an
 unsupported command
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org
Date:   Mon, 25 Jun 2018 19:07:23 +0300
In-Reply-To: <20180622065000.31139-1-Ricardo.Schwarzmeier@infineon.com>
References: <20180622065000.31139-1-Ricardo.Schwarzmeier@infineon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-22 at 08:50 +0200, Ricardo Schwarzmeier wrote:
> The userpace expects to read the number of bytes stated in the header.
> Returning the size of the buffer instead would be unexpected.
> Fixes: 095531f891e6 ("tpm: return a TPM_RC_COMMAND_CODE response if command is
> not implemented")
> 
> Signed-off-by: Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
> ---

Do you have a changelog?

/Jarkko
