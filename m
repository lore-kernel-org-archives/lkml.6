Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6590AC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3369821479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3369821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeLFJ3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:29:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:53083 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLFJ3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:29:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 01:28:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,321,1539673200"; 
   d="scan'208";a="116473262"
Received: from xdu1-mobl.sh.intel.com (HELO xdu1-mobl) ([10.239.200.26])
  by orsmga001.jf.intel.com with ESMTP; 06 Dec 2018 01:28:54 -0800
Date:   Thu, 6 Dec 2018 17:28:53 +0800
From:   "Du, Alek" <alek.du@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 rebase] mmc: sdhci: fix the timeout check window for
 clock and reset
Message-ID: <20181206172853.644e62ff@xdu1-mobl>
In-Reply-To: <CAPDyKFoVXCfyRMFgQ6LLmNyQKTdnbBuCC1FSZXKdAQy4zvWCyQ@mail.gmail.com>
References: <20181130150028.732896d8@xdu1-mobl>
        <81ba3745-8277-d16e-3aad-48324f51dc8a@intel.com>
        <20181130221300.4ef2956c@xdu1-mobl>
        <c580be57-8a49-59f3-791e-c605d892266b@intel.com>
        <20181201134251.26573207@xdu1-mobl>
        <20181204090120.63b5f0a4@xdu1-mobl>
        <229dc468-1155-b81f-9fda-b71402387e3f@intel.com>
        <20181205111450.300e0478@xdu1-mobl>
        <CAPDyKFot12Fc83R5wNsHYSu1-5mopNauYusu0RTQ9bjcUere5w@mail.gmail.com>
        <20181206073318.049065a8@xdu1-desk>
        <CAPDyKFoVXCfyRMFgQ6LLmNyQKTdnbBuCC1FSZXKdAQy4zvWCyQ@mail.gmail.com>
Organization: Intel APAC R&D
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 08:55:04 +0100
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Could you check at your side and see what can be wrong? If there is
> too much hazzle I can manually fixup the patch next week, as one time
> thing.

Sorry for the confusion, I just resent with git send-email to avoid any
thing unexpected. Please try again.



> 
> Kind regards
> Uffe
> 
