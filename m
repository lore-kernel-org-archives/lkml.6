Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4658C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94970204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94970204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeJONcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:32:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:26039 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeJONcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:32:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2018 22:49:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,383,1534834800"; 
   d="scan'208";a="78785163"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by fmsmga008.fm.intel.com with ESMTP; 14 Oct 2018 22:49:06 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Da Shi Cao <dscao999@gmail.com>, linux-usb@vger.kernel.org,
        linux-terminal@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add support of TI ICDI to USB simple serial device
In-Reply-To: <CAG3POB=BYJ_+iYy-xNygzp2RVOaUY2qEhRn9kTSNXYUo=9a5Og@mail.gmail.com>
References: <CAG3POB=BYJ_+iYy-xNygzp2RVOaUY2qEhRn9kTSNXYUo=9a5Og@mail.gmail.com>
Date:   Mon, 15 Oct 2018 08:49:05 +0300
Message-ID: <87murfkbe6.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Da Shi Cao <dscao999@gmail.com> writes:

> In-Circuit Debug Interface is a debugging interface for TI ARM
> microcontrollers. It has three USB interfaces and two of them are
> presented as standard ACM serial device. The 3rd interface is the
> debugging interface and it can be driven as a Linux USB simple
> terminal. With it, debugging session and firmware up/down loading are
> supported on Linux.
>
> Signed-off-by: Dashi Cao <dscao999@hotmail.com, dscao999@gmail.com>

Just to make sure: did you test to verify that this doesn't regress OpenOCD?

-- 
balbi
