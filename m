Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4316BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0171624088
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0171624088
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934122AbeF2Gnn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:43:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:12144 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753160AbeF2Gnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:43:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 23:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="53161596"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by orsmga008.jf.intel.com with ESMTP; 28 Jun 2018 23:43:37 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Daniel Mack <zonque@gmail.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Robert Baldyga <r.baldyga@samsung.com>,
        Peter Chen <peter.chen@nxp.com>,
        Christoph Hellwig <hch@lst.de>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Fix issues in UAC2 gadget driver
In-Reply-To: <20180628113930.GA8176@vmlxhi-102.adit-jv.com>
References: <20180621152252.8313-1-erosca@de.adit-jv.com> <20180628113930.GA8176@vmlxhi-102.adit-jv.com>
Date:   Fri, 29 Jun 2018 09:41:03 +0300
Message-ID: <87sh56dri8.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Eugeniu Rosca <erosca@de.adit-jv.com> writes:

> Hi Felipe,
>
> Friendly reminder. May I have some feedback on the shared USB fixes?

all except for patch 6 is in my queue for current -rc. Patch 6 will go
during merge window.

-- 
balbi
