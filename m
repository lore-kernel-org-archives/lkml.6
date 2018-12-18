Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DB9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC9E218A6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeLRWHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:07:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:58256 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbeLRWHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:07:00 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 14:07:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="108412058"
Received: from kohnenth-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.59.25])
  by fmsmga007.fm.intel.com with ESMTP; 18 Dec 2018 14:06:58 -0800
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 9E64421D0A; Wed, 19 Dec 2018 00:06:55 +0200 (EET)
Date:   Wed, 19 Dec 2018 00:06:55 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     m.felsch@pengutronix.de,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH] device property: fix fwnode_graph_get_next_endpoint
 documentation
Message-ID: <20181218220654.6jgrjhrawotinfrh@kekkonen.localdomain>
References: <20181218155239.3643-1-m.felsch@pengutronix.de>
 <CAJZ5v0j-yi3jSQM64zc4uQte0UToH-KWhxAtDjq5SoOimeyX1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j-yi3jSQM64zc4uQte0UToH-KWhxAtDjq5SoOimeyX1g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 10:33:07PM +0100, Rafael J. Wysocki wrote:
> On Tue, Dec 18, 2018 at 4:52 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> >
> > Sync documentation with code.
> >
> > Fixes: 07bb80d40b0e ("device property: Add support for remote endpoints")
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> I'll pick up this one if that's fine by everyone.

Please add:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> 
> > ---
> >  drivers/base/property.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 240ab5230ff6..e5a58614f8e0 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -1341,7 +1341,7 @@ int fwnode_irq_get(struct fwnode_handle *fwnode, unsigned int index)
> >  EXPORT_SYMBOL(fwnode_irq_get);
> >
> >  /**
> > - * device_graph_get_next_endpoint - Get next endpoint firmware node
> > + * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
> >   * @fwnode: Pointer to the parent firmware node
> >   * @prev: Previous endpoint node or %NULL to get the first
> >   *
> > --
> > 2.19.1
> >

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
