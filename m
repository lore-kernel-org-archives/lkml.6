Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2B3C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCF42086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCF42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeIKTfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:35:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:10413 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbeIKTfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:35:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 07:36:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,360,1531810800"; 
   d="scan'208";a="89051671"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 11 Sep 2018 07:36:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 11 Sep 2018 17:36:06 +0300
Date:   Tue, 11 Sep 2018 17:36:06 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>, Li Jun <jun.li@nxp.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH v2 2/3] dt-bindings: usb: fusb302: Use usb-connector
 bindings for configuration
Message-ID: <20180911143606.GD22723@kuha.fi.intel.com>
References: <cover.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
 <552e94b9a1cf89069be7d36d6476d5df26970406.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552e94b9a1cf89069be7d36d6476d5df26970406.1536580772.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Mon, Sep 10, 2018 at 01:24:27PM +0100, Adam Thomson wrote:
> There are now generic usb-connector bindings which can be used
> to define a port controllers configuration for USB-PD, so device
> specific bindings are no longer necessary.
> 
> This update deprecates 'fcs,operating-sink-microwatt', and references
> the 'usb-connector' bindings instead to achieve the required port
> config.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

I've applied this patch to my tree:
https://github.com/krohei/linux/commit/2b486e5939148f1623ecbc8dbe20432e12460e16

I will resend it to Greg together with all the other Type-C patches
that are ready next week after v4.19-rc4 unless Greg has picked it
himself before that.


Thanks,

-- 
heikki
