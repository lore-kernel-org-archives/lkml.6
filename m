Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5BEC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EF52087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EF52087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeJHRNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:13:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:11425 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeJHRNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:13:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 03:02:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,356,1534834800"; 
   d="scan'208";a="97058705"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 08 Oct 2018 03:02:12 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 08 Oct 2018 13:02:11 +0300
Date:   Mon, 8 Oct 2018 13:02:11 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: Fix copy/paste on typec_set_vconn_role()
 kerneldoc
Message-ID: <20181008100211.GA23604@kuha.fi.intel.com>
References: <20181007234612.94364-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181007234612.94364-1-swboyd@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 04:46:12PM -0700, Stephen Boyd wrote:
> This must have been copy pasted from the function above. Fix it.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 00141e05bc72..5db0593ca0bd 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1322,7 +1322,7 @@ void typec_set_pwr_role(struct typec_port *port, enum typec_role role)
>  EXPORT_SYMBOL_GPL(typec_set_pwr_role);
>  
>  /**
> - * typec_set_pwr_role - Report VCONN source change
> + * typec_set_vconn_role - Report VCONN source change
>   * @port: The USB Type-C Port which VCONN role changed
>   * @role: Source when @port is sourcing VCONN, or Sink when it's not
>   *
> -- 
> Sent by a computer through tubes

Thanks,

-- 
heikki
