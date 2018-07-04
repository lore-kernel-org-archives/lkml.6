Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F91C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325AB20C10
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325AB20C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933879AbeGDKyA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:54:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35468 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932864AbeGDKx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:53:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABD8518A;
        Wed,  4 Jul 2018 03:53:58 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.211.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53C433F5AD;
        Wed,  4 Jul 2018 03:53:56 -0700 (PDT)
Date:   Wed, 4 Jul 2018 11:53:49 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        "Voss, Dr. Nikolaus" <Nikolaus.Dr.Voss@loewensteinmedical.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, nv@vosn.de
Subject: Re: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
Message-ID: <20180704105349.GA14665@e107155-lin>
References: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
 <CAHp75VfPvCD7xpp73jbya4ONN=wxpVGNpOfNeqZYjfyirms0PA@mail.gmail.com>
 <CABe79T7EeyzKS97zeQ5akoSaZX0=hMgHxw4XkLCQW15eRR=14Q@mail.gmail.com>
 <CAHp75Vef97XB-M=+xUxsGqzgPrADcUmLTLRdWE+PcVxtTQLN4g@mail.gmail.com>
 <8518137d-c859-657e-844f-51720f6ef8dd@arm.com>
 <alpine.DEB.2.20.1807041205290.8629@fox.voss.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1807041205290.8629@fox.voss.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 12:17:20PM +0200, Nikolaus Voss wrote:
> On Wed, 4 Jul 2018, Sudeep Holla wrote:
> >

[...]

> >+1 on NACK for this and anything else that abuse PRP0001 as a short cut
> >approach.
>
> This is no abuse but exactly what PRP0001 is meant for. The basic idea of
> PRP0001 is to reuse DT "compatible" strings in ACPI namespace, see
> Documentation/acpi/enumeration.txt. Reusing also means getting access to the
> of_device_id.
>

Sorry for not being descriptive. It has been discussed a lot in past and
I assume someone would had gone through them, so gave no information in
my response.

> Allocating an ACPI id for an already existing DT driver is redundant, isn't it?
>

I think Andy had provided the summary and the intentions. Rafael has also
confirmed, I have nothing else to add.

--
Regards,
Sudeep
