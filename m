Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B08C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9988221855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548351797;
	bh=a2GNKsir2hYy7E59meGXI2coRpR6UcrzWX7dKNwG2XA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=qRDo+yQ3RPj3y6F9s33smx/SVL6FA7u4mrqjKUqUhdKbl5N6Va43eRzg1+fV7eydB
	 GNMljshhlZirJrbd4IGyOBbXcCSdkbRo/7iFeUJd6KYBOwEIfFYMqGss3bKrG6QbUp
	 uT++0YC9rnce757R5pBXlYw55bhs/0PmBywA21qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfAXRnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:43:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbfAXRnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:43:15 -0500
Received: from [10.84.151.11] (unknown [167.220.148.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE0D21855;
        Thu, 24 Jan 2019 17:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548351794;
        bh=a2GNKsir2hYy7E59meGXI2coRpR6UcrzWX7dKNwG2XA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fB9pgYBxCPMy/JOxnnaVjBnjzdZVLN7Hq7/baoXYJj+A+UxCjZJ+iqo9EcgsbPfYS
         Yzb4xdkhTG/9IhWE1nfPuBD1a+baOf4WLaU4enSrerLJ0k1OrAYizZqqdzMU7w5aaj
         QkYvv9t3IkU/aqb8T9HUWSD7lK8WjjL0cLI8nmpY=
Subject: Re: [for next][PATCH 1/2] mfd: Fix unmet dependency warning for
 MFD_TPS68470
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-next@vger.kernel.org, linux-acpi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190121231958.28255-1-okaya@kernel.org>
 <2222147.2pZxjFhHIY@aspire.rjw.lan>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <f4bc6037-7c0f-f053-a150-8ae6f683b1bc@kernel.org>
Date:   Thu, 24 Jan 2019 12:43:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2222147.2pZxjFhHIY@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/2019 5:51 AM, Rafael J. Wysocki wrote:
> Is anyone taking this or should I?

Nobody replied to this yet. I was hoping this series to go through acpi
tree like the rest of the other fixes.
