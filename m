Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0E1160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCAF20890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCAF20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeG3QvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:51:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:32640 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbeG3QvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:51:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 08:15:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="76762237"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jul 2018 08:15:48 -0700
Message-ID: <9712316ab62bef25953c523bce02e260a9ea40fe.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] ata: libahci: devslp fixes
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     tj@kernel.org, hdegoede@redhat.com
Cc:     rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 30 Jul 2018 08:15:47 -0700
In-Reply-To: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejan,

On Mon, 2018-07-02 at 12:01 -0700, Srinivas Pandruvada wrote:
> Some minor fixes to be able to correctly set devslp register
> to optimize power.
> 
> Srinivas Pandruvada (2):
>   ata: libahci: Correct setting of DEVSLP register
>   ata: libahci: Allow reconfigure of DEVSLP register
> 
Are you applying this series?

Thanks,
Srinivas

>  drivers/ata/libahci.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
