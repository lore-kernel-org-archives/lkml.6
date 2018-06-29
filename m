Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B7FC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D72D23D93
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D72D23D93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755357AbeF2OVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:21:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:26381 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752260AbeF2OVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:21:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 07:21:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="68364621"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 29 Jun 2018 07:21:28 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 29 Jun 2018 17:21:27 +0300
Date:   Fri, 29 Jun 2018 17:21:27 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] usb: typec: Support for Alternate Modes
Message-ID: <20180629142127.GB21104@kuha.fi.intel.com>
References: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On Wed, Jun 27, 2018 at 06:19:45PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> Since we now have an implementation for an actual alternate mode (DisplayPort),
> I guess there is no reason to send another RFC. This series is the same as the
> last RFC proposal [1] with only minor changes. There were only a few comments.
> 
> [1] https://lkml.org/lkml/2018/6/8/225
> 
> I've tested these with a platform that has fusb302, and also with UCSI
> platforms. The UCSI driver will need separate support for alternate modes that
> I'm not including to this series. I'm still working on it. I've used various
> DisplayPort to Type-C adapters for testing, both DisplayPort receptacles and
> connectors.

I'm travelling next week so there may be some delay in my replies.
I'm actually also on vacation, so I may not answer immediately also
because of that.


Cheers,

-- 
heikki
