Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56723C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1572086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1572086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeIKTe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:34:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:2764 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbeIKTe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:34:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 07:34:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,360,1531810800"; 
   d="scan'208";a="89051317"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 11 Sep 2018 07:34:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 11 Sep 2018 17:34:46 +0300
Date:   Tue, 11 Sep 2018 17:34:46 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>, Li Jun <jun.li@nxp.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH v2 1/3] dt-bindings: connector: Add support for USB-PD
 PPS APDOs to bindings
Message-ID: <20180911143446.GC22723@kuha.fi.intel.com>
References: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
 <b98c58ca3681d18f44359431a1ccec2fa34023d1.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b98c58ca3681d18f44359431a1ccec2fa34023d1.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Mon, Sep 10, 2018 at 01:24:26PM +0100, Adam Thomson wrote:
> Add support for PPS APDOs to connector bindings so a port controller
> can specify support for PPS, as per existing FIXED/BATT/VAR PDOs.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

I've applied this patch to my tree:
https://github.com/krohei/linux/commit/adae44a671f47e94d6aa0fba8fb51b78d40c505d

I will resend it to Greg together with all the other Type-C patches
that are ready next week after v4.19-rc4 unless Greg has picked it
himself before that.


Thanks,

-- 
heikki
