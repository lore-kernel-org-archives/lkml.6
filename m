Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A366ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4CF214C3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4CF214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeJSSdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:33:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56728 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSSc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:32:59 -0400
Received: from 79.184.253.168.ipv4.supernova.orange.pl (79.184.253.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 7989406d1f238ce8; Fri, 19 Oct 2018 12:27:30 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] ACPI / scan: Create platform device for INT33FE ACPI nodes
Date:   Fri, 19 Oct 2018 12:24:14 +0200
Message-ID: <2477276.ZfWzuKp1JK@aspire.rjw.lan>
In-Reply-To: <CAHp75VcxnGzKbOwEDu_MSKQ1D28=pESTVm+YSHQTjrMXUaKMoA@mail.gmail.com>
References: <20181017085928.13406-1-hdegoede@redhat.com> <CAHp75VcxnGzKbOwEDu_MSKQ1D28=pESTVm+YSHQTjrMXUaKMoA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 17, 2018 1:39:54 PM CEST Andy Shevchenko wrote:
> On Wed, Oct 17, 2018 at 11:59 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi Rafael, Andy,
> >
> > For the why and what of this patch see the (somewhat long) commit message.
> >
> > The single patch in this set both touches drivers/acpi/scan.c and
> > drivers/platform/x86/intel_cht_int33fe.c, this is done this way to avoid
> > regressions when bisecting.
> >
> > The main change here really is to ACPI change and intel_cht_int33fe.c is
> > modified to follow suit. Also I do not expect intel_cht_int33fe.c to see
> > much changes this cycle. As such I believe it would be best to merge this
> > patch through Rafael's tree (after review).
> >
> > Andy is that ok with you and we have your ack for this?
> 
> I love this patch!
> 
> Definitely,
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Patch applied, thanks!

