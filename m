Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E0FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3680326DA5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3680326DA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeFZQic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:38:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:6491 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752116AbeFZQi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:38:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 09:38:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,275,1526367600"; 
   d="scan'208";a="53060692"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 26 Jun 2018 09:38:25 -0700
Message-ID: <94677b02051f8d2ad2e3c16d690442134b693cf8.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/2] Add a property in at24.c
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Yeh, Andy" <andy.yeh@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "Chiang, AlanX" <alanx.chiang@intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 26 Jun 2018 19:38:24 +0300
In-Reply-To: <8E0971CCB6EA9D41AF58191A2D3978B61D6D9A20@PGSMSX111.gar.corp.intel.com>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
         <CAMRc=Me-Tm8Q5_hGu2r1uqeYFAvCM9ssr7o=w1KZUyXcAn_uCw@mail.gmail.com>
         <ff4c668d0807657940a4cddc6f7eb63d19be327c.camel@linux.intel.com>
         <CAMRc=Me511S4Qw_-SPNkpPXcby7rZApbgm9g2=W=irmy9Gsu3g@mail.gmail.com>
         <3a07d0d9fbe7178bbe9efa99fcb331df213a461f.camel@linux.intel.com>
         <CAMRc=MdvW_k3ZgrZAffD45r_zxOMWCyXoDx-YgXMQ2=-tSjyGw@mail.gmail.com>
         <94f847b50030a10c9dabd907a35c16a9f43e5af4.camel@linux.intel.com>
         <8E0971CCB6EA9D41AF58191A2D3978B61D6D9A20@PGSMSX111.gar.corp.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 16:21 +0000, Yeh, Andy wrote:

> > > Ok makes sense in that case. Could you just point me towards an
> > > example model which has the address width different than the
> > > default
> > > for its type?
> > 
> > AFAIK, it's a companion device inside the camera voice coil IC, i.e.
> > DONGWOON DW9714.
> > 
> 
> Nope, actually it is DW9807 instead, which is used on a Samsung
> Chromebook.

Ah, okay, good to know.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
