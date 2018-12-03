Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249A6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FFD20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FFD20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbeLCMoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:44:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:64967 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeLCMoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:44:23 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 04:43:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,310,1539673200"; 
   d="scan'208";a="126617844"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 03 Dec 2018 04:43:25 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 03 Dec 2018 14:43:25 +0200
Date:   Mon, 3 Dec 2018 14:43:25 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Yu Chen <chenyu56@huawei.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 09/12] usb: dwc3: Registering a role switch in the DRD
 code.
Message-ID: <20181203124325.GF24338@kuha.fi.intel.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-10-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203034515.91412-10-chenyu56@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:45:12AM +0800, Yu Chen wrote:
> The Type-C drivers use USB role switch API to inform the
> system about the negotiated data role, so registering a role
> switch in the DRD code in order to support platforms with
> USB Type-C connectors.
> 
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> --
> v0:
> The patch is provided by Heikki Krogerus. I modified and test it
> on Hikey960 platform.

Either make me as the original author by adding a "from" line with my
address, or just use that "Suggested-by" tag with this patch as well.


thanks,

-- 
heikki
