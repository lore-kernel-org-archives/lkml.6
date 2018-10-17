Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C56ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86C5204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86C5204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeJQVTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:19:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:40114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727037AbeJQVTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:19:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5EA77AECF;
        Wed, 17 Oct 2018 13:23:20 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: Re: [PATCH 00/10] tools: Various build flags fixes
Date:   Wed, 17 Oct 2018 15:23:19 +0200
Message-ID: <1915425.8MElBxF9G6@house>
In-Reply-To: <20181016150614.21260-1-jolsa@kernel.org>
References: <20181016150614.21260-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 16, 2018 5:06:05 PM CEST Jiri Olsa wrote:
> hi,
> while hardening some of the tools rpm, we noticed we
> can't pass build flags to some of them.
> 
> Sending separate tools fixes for what we found. It's
> mostly override for CFLAGS and adding LDFLAGS to the
> build commands.

Looks fine for the cpupower patches 3/10 and 4/10.
(Feel free to add a Reviewed-by or Acked-by for them
if you have to resend).

Thanks,

       Thomas
