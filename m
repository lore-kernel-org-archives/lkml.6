Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B55C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A423121872
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfBBD13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 22:27:29 -0500
Received: from smtprelay0020.hostedemail.com ([216.40.44.20]:33173 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726528AbfBBD12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 22:27:28 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 7356816E28;
        Sat,  2 Feb 2019 03:27:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: song38_6b343b192310
X-Filterd-Recvd-Size: 1227
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 Feb 2019 03:27:25 +0000 (UTC)
Message-ID: <089b1025c5e81410b6b608290becd6f609ca03b4.camel@perches.com>
Subject: Re: [PATCH] mm/slab: Increase width of first /proc/slabinfo column
From:   Joe Perches <joe@perches.com>
To:     "Tobin C. Harding" <tobin@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Fri, 01 Feb 2019 19:27:24 -0800
In-Reply-To: <20190201004242.7659-1-tobin@kernel.org>
References: <20190201004242.7659-1-tobin@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-01 at 11:42 +1100, Tobin C. Harding wrote:
> Increase the width of the first column (cache name) in the output of
> /proc/slabinfo from 17 to 30 characters.

Do you care if this breaks any parsing of /proc/slabinfo?

I don't but someone might.

