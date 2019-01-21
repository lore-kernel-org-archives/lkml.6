Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0E1C2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C648620879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbfAUOP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:15:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:3664 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729953AbfAUNvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:51:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 05:51:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="140038747"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 21 Jan 2019 05:51:36 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 21 Jan 2019 15:51:35 +0200
Date:   Mon, 21 Jan 2019 15:51:35 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Chen Yu <chenyu56@huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        liuyu712@hisilicon.com, USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v1 07/12] usb: roles: Find the usb role switch by also
 matching against the device node
Message-ID: <20190121135135.GA22960@kuha.fi.intel.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-8-chenyu56@huawei.com>
 <CAHp75VfUKAQ+Q0cQz-4-=i2JL9uACBX1bVvCeNjZLL1HStDGKQ@mail.gmail.com>
 <20181203122534.GD24338@kuha.fi.intel.com>
 <e9a8f745-6211-d6d2-24f0-ac86f82924f0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9a8f745-6211-d6d2-24f0-ac86f82924f0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 21, 2019 at 04:36:13PM +0800, Chen Yu wrote:
> Have the fwnode_get_name() patches been accepted?

No, I didn't have a user for the function anymore:
https://lkml.org/lkml/2018/12/17/284

> And I will be grateful if you can tell me your plan about the
> https://lkml.org/lkml/2018/10/24/619 patches.

The plan is to send a new version of them together with the
fwnode_get_name() patch. I can send them this week.


thanks,

-- 
heikki
