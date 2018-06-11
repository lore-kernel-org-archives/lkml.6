Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LWM1IR44HlvDMgAAmS7hNA
	; Mon, 11 Jun 2018 08:51:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 786E0607A4; Mon, 11 Jun 2018 08:51:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 16F176074D;
	Mon, 11 Jun 2018 08:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16F176074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754199AbeFKIvk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:51:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:19867 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754024AbeFKIvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:51:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 01:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,501,1520924400";
   d="scan'208";a="63028025"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 11 Jun 2018 01:51:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 11 Jun 2018 11:51:34 +0300
Date: Mon, 11 Jun 2018 11:51:34 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/8] usb: pd: include kernel.h
Message-ID: <20180611085134.GF17155@kuha.fi.intel.com>
References: <20180608112941.26332-1-heikki.krogerus@linux.intel.com>
 <20180608112941.26332-2-heikki.krogerus@linux.intel.com>
 <20180611070859.GB9472@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611070859.GB9472@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 09:08:59AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 08, 2018 at 02:29:34PM +0300, Heikki Krogerus wrote:
> > Some of the macros use le16_to_cpu().
> 
> What macros?
> 
> Is this causing build errors today?  If so, why should it not be
> included now?

There are no build errors today.

I'll write a better commit message for this patch. I think I need to
improve the commit messages of some of the other patches in this
series as well.


Thanks,

-- 
heikki
