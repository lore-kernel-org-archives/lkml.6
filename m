Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F09C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BBB2802A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BBB2802A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936368AbeF2PCW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:02:22 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:48191 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755552AbeF2PCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:02:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id EB29218036BC7;
        Fri, 29 Jun 2018 15:02:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: earth88_4db0e986eb055
X-Filterd-Recvd-Size: 1552
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 29 Jun 2018 15:02:13 +0000 (UTC)
Message-ID: <dd97033978ee266b236487668061db7025d39c15.camel@perches.com>
Subject: Re: [PATCH] spelling.txt: add more spellings to spelling.txt
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 Jun 2018 08:02:12 -0700
In-Reply-To: <20180629084511.29221-1-colin.king@canonical.com>
References: <20180629084511.29221-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-29 at 09:45 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Here are some of the more common spelling mistakes and typos that I've
> found while fixing up spelling mistakes in the kernel over the past 6
> months.

Super, thanks.  One correction:

> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
[]
> @@ -829,6 +881,7 @@ parametes||parameters
>  parametised||parametrised
>  paramter||parameter
>  paramters||parameters
> +parmaters||paramaters

Misspelled correction correction

parameters

> @@ -1143,11 +1219,14 @@ thresold||threshold
>  throught||through
>  troughput||throughput
>  thses||these
> +tiggers||triggers

Milne might object
