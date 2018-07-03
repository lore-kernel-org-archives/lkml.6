Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E79C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1CB23E33
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1CB23E33
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbeGCNGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:06:11 -0400
Received: from foss.arm.com ([217.140.101.70]:48888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752686AbeGCNGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:06:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B3BE80D;
        Tue,  3 Jul 2018 06:06:09 -0700 (PDT)
Received: from e107155-lin (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D9B73F5BA;
        Tue,  3 Jul 2018 06:06:07 -0700 (PDT)
Date:   Tue, 3 Jul 2018 14:06:01 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     rafael@kernel.org, lenb@kernel.org, andy.shevchenko@gmail.com,
        ray.jui@broadcom.com, vladimir.olovyannikov@broadcom.com,
        vikram.prakash@broadcom.com, scott.branden@broadcom.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
Message-ID: <20180703130601.GA1010@e107155-lin>
References: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 02:52:40PM +0530, Srinath Mannam wrote:
> This patch provides a function, to get of_device_id after
> matching with ACPI device _DSD object compatible property
> in the case driver does not contain acpi_device_id list
> and driver probe called for ACPI device ID PRP0001 with
> compatible property match with of_device_id compatible.
>

So, IIUC you are adding this to get of_device_id and then fetch data ptr
from it. Can we see the user in some driver ?

--
Regards,
Sudeep
