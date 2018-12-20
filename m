Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1837DC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40DE21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbeLTIvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:51:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:25205 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbeLTIvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:51:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2018 00:51:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,376,1539673200"; 
   d="scan'208";a="103263645"
Received: from apaszkie-desk.igk.intel.com (HELO [10.102.11.138]) ([10.102.11.138])
  by orsmga008.jf.intel.com with ESMTP; 20 Dec 2018 00:51:41 -0800
Subject: Re: [PATCH 18/41] scsi: isci: remote_device: Mark expected switch
 fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        intel-linux-scu <intel-linux-scu@intel.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <5636e6aa6c0c42089949391b04d2529b@fmsmsx155.amr.corp.intel.com>
From:   Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Message-ID: <84102f94-e8c7-ff71-455e-d35acab7a259@intel.com>
Date:   Thu, 20 Dec 2018 09:51:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <5636e6aa6c0c42089949391b04d2529b@fmsmsx155.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/18 5:30 AM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that, in this particular case, a dash is added as a token in
> order to separate the "fall through" annotations from the rest of
> the comment on the same line, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
