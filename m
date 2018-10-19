Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06378C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE3320C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKPcs+gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE3320C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeJSIl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:41:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbeJSIl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:41:57 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D3CE20C0E;
        Fri, 19 Oct 2018 00:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539909501;
        bh=g61BBgBWo79G+YVqglAehrGDBWdB4dJV26ruZ4AP67c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FKPcs+greOqGmsn7JGtyso3wAd3NLyqNKyTGymGiQ6khj/alnnt1jg7XcxMrKYQTT
         i/Lp/w6G8fSq+b0/tWQ9f/uwG44JnhWJxKqF7/1veq51Fmf6/+AA2Vu+CM85bElSoA
         tycFGJr8+MTWd2g/ahrTbe2rdouAcyCMjv0CPzzU=
Date:   Fri, 19 Oct 2018 09:38:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, Tom Zanussi <zanussi@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] selftests: ftrace: Add synthetic event syntax
 testcase
Message-Id: <20181019093818.06682ac64b02d2f41a61adf6@kernel.org>
In-Reply-To: <20181018163427.6e0f823d@gandalf.local.home>
References: <153986829702.18251.1286066460999338772.stgit@devbox>
        <153986838264.18251.16627517536956299922.stgit@devbox>
        <20181018163427.6e0f823d@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 16:34:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Hi Masami,
> 
> Thanks! I pulled this into my urgent queue and will be running tests on
> it over night.

Thanks!
I hope to pass the test :)

> Shuah, can you ack this patch, as I want to add it to this release,
> along with the other changes.

Shuah, just a note that this test case must fail unless these fixes are applied.

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
