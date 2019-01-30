Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963EFC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716E420815
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbfA3Kdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:33:35 -0500
Received: from foss.arm.com ([217.140.101.70]:51932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbfA3Kde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:33:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 321C2A78;
        Wed, 30 Jan 2019 02:33:34 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF4483F59C;
        Wed, 30 Jan 2019 02:33:32 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:33:30 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ARM SoC Team <arm@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@linaro.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] firmware: arm_scmi: provide the mandatory device release
 callback
Message-ID: <20190130103330.GB27201@e107155-lin>
References: <20190122113525.13705-1-sudeep.holla@arm.com>
 <CAK8P3a09=Z6rfyeqZmSF8rZVuUHwHx0FM0PAA5kaukJFmv_GLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a09=Z6rfyeqZmSF8rZVuUHwHx0FM0PAA5kaukJFmv_GLQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 11:30:24AM +0100, Arnd Bergmann wrote:
> On Tue, Jan 22, 2019 at 12:35 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > The device/driver model clearly mandates that bus driver that discover
> > and allocate the device must set the release callback. This callback
> > will be used to free the device after all references have gone away.
> ...
> > Hi ARM-SoC team,
> >
> > Can you apply this one patch directly or I can send pull request if you
> > prefer ?
>
> I applied it to the arm/fixes branch now, and added a Cc:stable tag
> for backporting to 4.19 and 4.20.
>

Thanks for that.

--
Regards,
Sudeep
