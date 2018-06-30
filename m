Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2410CC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 03:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23FC20C0A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 03:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23FC20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936187AbeF3DVa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 23:21:30 -0400
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:57460 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935657AbeF3DV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 23:21:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 0A379180C5E0A;
        Sat, 30 Jun 2018 03:21:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: owner83_80fda68014f26
X-Filterd-Recvd-Size: 1820
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 Jun 2018 03:21:26 +0000 (UTC)
Message-ID: <2d0d235418958e8b60913b1e0d630b8c9213ea5b.camel@perches.com>
Subject: Re: [PATCH v7] drivers/staging: Gasket driver framework + Apex
 driver
From:   Joe Perches <joe@perches.com>
To:     Simon Que <sque@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Chan <benchan@chromium.org>,
        Chun-Ta Lin <itspeter@chromium.org>,
        Zhongze Hu <frankhu@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>
Date:   Fri, 29 Jun 2018 20:21:24 -0700
In-Reply-To: <20180630024938.107529-1-sque@chromium.org>
References: <20180630024938.107529-1-sque@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-29 at 22:49 -0400, Simon Que wrote:
> The Gasket (Google ASIC Software, Kernel Extensions, and Tools) kernel
> framework is a generic, flexible system that supports thin kernel
> drivers. Gasket kernel drivers are expected to handle opening and
> closing devices, mmap'ing BAR space as requested, a small selection of
> ioctls, and handling page table translation (covered below). Any other
> functions should be handled by userspace code.
[]
> [PATCH v4]
> - Deleted unused field "base" in struct gasket_coherent_buffer
> - Moved maintainer info to top-level MAINTAINERS file
> [PATCH v5]
> - Updated drivers/staging/Makefile change to apply to gregkh's staging
>   tree.

Why delete all the logging by adding if (false} tests
and then not mention it?

