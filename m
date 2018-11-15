Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14455C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F2B223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F2B223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbeKOWly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:41:54 -0500
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:58943 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728950AbeKOWlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:41:53 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D7BF5837F243;
        Thu, 15 Nov 2018 12:34:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: join81_2498b768c8d25
X-Filterd-Recvd-Size: 1203
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu, 15 Nov 2018 12:34:11 +0000 (UTC)
Message-ID: <484c6e88e1899cf7f0b373a8bf12b55f19f7fd8c.camel@perches.com>
Subject: Re: [PATCH v2 0/5] libsas: Some logging tidy-up
From:   Joe Perches <joe@perches.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     hare@suse.com, yanaijie@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Date:   Thu, 15 Nov 2018 04:34:10 -0800
In-Reply-To: <1542277232-135789-1-git-send-email-john.garry@huawei.com>
References: <1542277232-135789-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-15 at 18:20 +0800, John Garry wrote:
> This patchset presents some logging tidy-up, namely removing the printk
> wrappers and using pr_XXX() instead.
> 
> In addition, some log levels are revised, as previous levels (generally
> debug) were too low.

Seems sensible, thanks.


