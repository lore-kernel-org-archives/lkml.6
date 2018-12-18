Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A847C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F2321841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeLRQHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:07:52 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49058 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbeLRQHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:07:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3588315AB;
        Tue, 18 Dec 2018 08:07:52 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 467393F5C0;
        Tue, 18 Dec 2018 08:07:51 -0800 (PST)
Date:   Tue, 18 Dec 2018 16:07:48 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 02/19] mailbox: arm-mhu: Use device-managed
 registration API
Message-ID: <20181218160748.GB32237@e107155-lin>
References: <20181217150217.32435-1-thierry.reding@gmail.com>
 <20181217150217.32435-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217150217.32435-3-thierry.reding@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 04:02:00PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Get rid of some boilerplate driver removal code by using the newly added
> device-managed registration API.
>

Since the platform I have uses MHU differently and the mainline driver
doesn't work as is, I can't test the change easily.

But the changes looks fine to me. Feel free to all:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
