Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03638C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 04:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C1124DCB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 04:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C1124DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbeFXEOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 00:14:45 -0400
Received: from smtprelay0154.hostedemail.com ([216.40.44.154]:39844 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750769AbeFXEOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 00:14:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 3896D182CED28;
        Sun, 24 Jun 2018 04:14:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dock11_635d3fd11f92f
X-Filterd-Recvd-Size: 1558
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun, 24 Jun 2018 04:14:42 +0000 (UTC)
Message-ID: <6acef3fb67071cdf524b7071d19fece0a9a8275d.camel@perches.com>
Subject: Re: [PATCH v4] drivers/staging: Gasket driver framework + Apex
 driver
From:   Joe Perches <joe@perches.com>
To:     Simon Que <sque@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Chan <benchan@chromium.org>,
        Chun-Ta Lin <itspeter@chromium.org>,
        Zhongze Hu <frankhu@chromium.org>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>
Date:   Sat, 23 Jun 2018 21:14:41 -0700
In-Reply-To: <20180620232441.204171-1-sque@chromium.org>
References: <20180620232441.204171-1-sque@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-20 at 19:24 -0400, Simon Que wrote:
> The Gasket (Google ASIC Software, Kernel Extensions, and Tools) kernel
> framework is a generic, flexible system that supports thin kernel
> drivers. Gasket kernel drivers are expected to handle opening and
> closing devices, mmap'ing BAR space as requested, a small selection of
> ioctls, and handling page table translation (covered below). Any other
> functions should be handled by userspace code.

Perhps this should be resubmited with changes appropriate for
the staging-next tree as this does not compile there.

