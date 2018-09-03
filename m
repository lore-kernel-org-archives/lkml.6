Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19C9C4321E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6378420856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6378420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeICLjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:39:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:14151 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeICLjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:39:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 00:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,324,1531810800"; 
   d="scan'208";a="86694482"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 03 Sep 2018 00:20:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 03 Sep 2018 10:20:58 +0300
Date:   Mon, 3 Sep 2018 10:20:58 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: typec: fix kernel-doc parameter warning
Message-ID: <20180903072058.GC18767@kuha.fi.intel.com>
References: <0b58da39-55af-b00c-95d2-14fb26fb70b8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b58da39-55af-b00c-95d2-14fb26fb70b8@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2018 at 07:30:48PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warning (13 times):
> 
> ../drivers/usb/typec/class.c:1497: warning: Excess function parameter 'drvdata' description in 'typec_port_register_altmode'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- lnx-419-rc2.orig/drivers/usb/typec/class.c
> +++ lnx-419-rc2/drivers/usb/typec/class.c
> @@ -1484,7 +1484,6 @@ EXPORT_SYMBOL_GPL(typec_set_mode);
>   * typec_port_register_altmode - Register USB Type-C Port Alternate Mode
>   * @port: USB Type-C Port that supports the alternate mode
>   * @desc: Description of the alternate mode
> - * @drvdata: Private pointer to driver specific info
>   *
>   * This routine is used to register an alternate mode that @port is capable of
>   * supporting.
> 

Thanks,

-- 
heikki
