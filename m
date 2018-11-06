Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44914C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AE720862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AE720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbeKFSfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:35:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:34495 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbeKFSfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:35:04 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 01:10:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,471,1534834800"; 
   d="scan'208";a="105657688"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 06 Nov 2018 01:10:45 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 06 Nov 2018 11:10:45 +0200
Date:   Tue, 6 Nov 2018 11:10:45 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        cw00.choi@samsung.com, a.hajda@samsung.com, jun.li@nxp.com,
        Guenter Roeck <linux@roeck-us.net>, jackp@codeaurora.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] usb: typec: tcpm: charge current handling for
 sink during hard reset
Message-ID: <20181106091045.GB13048@kuha.fi.intel.com>
References: <20181001194501.58338-1-badhri@google.com>
 <20181001194501.58338-3-badhri@google.com>
 <20181102132847.GC6543@kuha.fi.intel.com>
 <CAPTae5K7o31eFJxaW=_6UCyLgiagSz45O6iDhgfqh2vu3QMQsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTae5K7o31eFJxaW=_6UCyLgiagSz45O6iDhgfqh2vu3QMQsg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 04:15:24PM -0800, Badhri Jagan Sridharan wrote:
> Hi Heikki, Rob,
> 
> Thanks for reviewing !
> Should I update the patchset with the Reviewed-by tag and bumpup the
> patchset version ?
> Or is that not necessary?

No it's not necessary. Greg will eventually pick these to his queue
(assuming there are no other comments before that), and he'll take
care of adding the tags.


thanks,

-- 
heikki
