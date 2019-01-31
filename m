Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917E7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1D5218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733181AbfAaQy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:54:57 -0500
Received: from smtprelay0200.hostedemail.com ([216.40.44.200]:50770 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728091AbfAaQy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:54:57 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 660A318224B9D;
        Thu, 31 Jan 2019 16:54:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crack80_653bcef1f2063
X-Filterd-Recvd-Size: 1220
Received: from XPS-9350 (unknown [149.142.244.94])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 31 Jan 2019 16:54:55 +0000 (UTC)
Message-ID: <511a36863af02aec12fd77657b0ca199e023f319.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Properly detect /* */ style SPDX header.
From:   Joe Perches <joe@perches.com>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 31 Jan 2019 08:54:52 -0800
In-Reply-To: <20190131095625.261755-1-pihsun@chromium.org>
References: <20190131095625.261755-1-pihsun@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-31 at 17:56 +0800, Pi-Hsun Shih wrote:
> Currently for a header line "/* SPDX-License-Identifier: GPL-2.0 */",
> only the part starting from "SPDX-" is passed to spdxcheck.py, and cause
> false warning. Fix this by passing the whole line to spdxcheck.py
> instead.

Thanks but I submitted a different patch:

https://lore.kernel.org/lkml/8b02899853247a2c67669561761f354dd3bd110e.camel@perches.com/


