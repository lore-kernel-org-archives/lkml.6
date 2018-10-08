Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C43C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3BF20858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3BF20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJHSu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:50:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:23803 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeJHSu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:50:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 04:39:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,356,1534834800"; 
   d="scan'208";a="86621603"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Oct 2018 04:39:36 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 11/16] stm class: Document the MIPI SyS-T protocol usage
In-Reply-To: <5e7d8200-d357-4105-b00a-3ca36d375aac@infradead.org>
References: <20181005124306.54870-1-alexander.shishkin@linux.intel.com> <20181005124306.54870-12-alexander.shishkin@linux.intel.com> <5e7d8200-d357-4105-b00a-3ca36d375aac@infradead.org>
Date:   Mon, 08 Oct 2018 14:39:35 +0300
Message-ID: <87r2h0651k.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Hi,
> one small typo/spello below...
>
>> +If the protocol name is omitted, the STM class will chose whichever
>
> s/chose/choose/

Aw shucks, me can has spelling good. Do you mind if I fix it in later
rcs?

Thanks,
--
Alex

