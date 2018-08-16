Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DF3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490C7208EB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1j4IEuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490C7208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391919AbeHPSWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:22:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387805AbeHPSWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:22:18 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B04E208EB;
        Thu, 16 Aug 2018 15:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534432989;
        bh=njYG/GVPvXQKr9JRHBWCXiWr9wFlXaRzL9iPxOQdwLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1j4IEucA/cfem7yWyI6SE3OtCDy2XPKrRDf0++bNbU+ZkxfqBqTidkVhv/h/T5bR
         YJVYhZQXeXs6vCl+n9ETecScnux/2pEqnvxW7OcF4j44oh5zVIG8yY4Stx4hR1L6zc
         meYgXfEEmcAgr4cXw2vdMleoDqDtKMcrMmxJWMno=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 4636E141C3A; Thu, 16 Aug 2018 12:23:07 -0300 (-03)
Date:   Thu, 16 Aug 2018 12:23:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Subject: Re: [PATCH] tools lib traceevent: Change to SPDX License format
Message-ID: <20180816152307.GA23157@kernel.org>
References: <20180816111015.125e0f25@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816111015.125e0f25@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 16, 2018 at 11:10:15AM -0400, Steven Rostedt escreveu:
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Replace the GPL text with SPDX tags in the tools/lib/traceevent files.

Thanks, applied.

- Arnaldo
