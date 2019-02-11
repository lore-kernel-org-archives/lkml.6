Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E199C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36075222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbfBKPgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:36:02 -0500
Received: from foss.arm.com ([217.140.101.70]:52046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbfBKPf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:35:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEFB980D;
        Mon, 11 Feb 2019 07:35:57 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A735A3F589;
        Mon, 11 Feb 2019 07:35:55 -0800 (PST)
Date:   Mon, 11 Feb 2019 15:35:53 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, rafael.j.wysocki@intel.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        robert.moore@intel.com, linux-acpi@vger.kernel.org,
        lenb@kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        erik.schmauss@intel.com, devel@acpica.org
Subject: Re: [RFC 3/3] perf: arm_spe: Enable ACPI/Platform automatic module
 loading
Message-ID: <20190211153553.GB4792@e107155-lin>
References: <20190209004718.3292087-1-jeremy.linton@arm.com>
 <20190209004718.3292087-4-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209004718.3292087-4-jeremy.linton@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 06:47:18PM -0600, Jeremy Linton wrote:
> Lets add the MODULE_TABLE and platform id_table entries so that
> the SPE driver can attach to the ACPI platform device created by
> the core pmu code.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
