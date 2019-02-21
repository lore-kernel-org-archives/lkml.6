Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AA9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB592084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfBUN4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:56:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:40946 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfBUN4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:56:45 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 05:56:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="148692988"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 21 Feb 2019 05:56:42 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Feb 2019 15:56:41 +0200
Date:   Thu, 21 Feb 2019 15:56:41 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] platform/x86: intel_cht_int33fe: Provide fwnode for
 the USB connector
Message-ID: <20190221135641.GG5054@kuha.fi.intel.com>
References: <20190219115959.55553-1-heikki.krogerus@linux.intel.com>
 <20190219115959.55553-2-heikki.krogerus@linux.intel.com>
 <CAHp75Vca+yNuNJaAuB_2_5Vgq8+0FvrBWS1VbvqhAr0nq1UYPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vca+yNuNJaAuB_2_5Vgq8+0FvrBWS1VbvqhAr0nq1UYPw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:46:46PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 19, 2019 at 2:00 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > In ACPI, and now also in DT, the USB connectors usually have
> > their own device nodes. In case of USB Type-C, those
> > connector (port) nodes are child nodes of the controller or
> > PHY device, in our case the fusb302. The software fwnodes
> > allow us to create a similar child node for fusb302 that
> > represents the connector also on Intel CHT.
> >
> > This makes it possible replace the fusb302 specific device
> > properties which were deprecated with the common USB
> > connector properties that tcpm.c is able to use directly.
> >
> 
> This doesn't apply to our for-next branch.

Please read the cover-letter ;-)


thanks,

-- 
heikki
