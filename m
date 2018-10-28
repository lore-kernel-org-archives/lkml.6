Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A963C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 18:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4507C2082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 18:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+LV/sMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4507C2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeJ2Czm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 22:55:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeJ2Czl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 22:55:41 -0400
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C578B2082D;
        Sun, 28 Oct 2018 18:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540750218;
        bh=foO19T/fSbZjxoHGAyNkXGp9S6Vma90ER/NMDoGP71U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=E+LV/sMaSbNALXu/YpRv69zxf/h6lEA8/kF5k1hWpVUlmAalJ38Jyw/AulaVesQ4d
         2OXou6xs4r5gDe5LGlVADvIpJ8gbm7GbDaRKTGL1KToEAdjscgHcALUuQgONzk4cfQ
         Hwi1ABk6VHv85mzNXvVE6bKdCkFftkEXYBd5ebfY=
Subject: Re: [PATCH 0/2] tracing: Fix synthetic event parser
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Rajvi Jingar <rajvi.jingar@intel.com>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <154013446976.25576.14780785912268176178.stgit@devbox>
 <20181028040135.717a7b5d@vmware.local.home>
 <20181028040924.1eca8002@vmware.local.home>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <c160ec5e-debd-74dd-43e8-a7792a63f06e@kernel.org>
Date:   Sun, 28 Oct 2018 12:10:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181028040924.1eca8002@vmware.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/2018 02:09 AM, Steven Rostedt wrote:
> On Sun, 28 Oct 2018 04:01:35 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> I'll add them on top of my linux-next code, and include them in the
>> pull request I'm hoping to do on Tuesday.
> 
> Bah, I think this is on a different branch, and that will make it go as
> a separate pull. Anyway, it probably will still be on Tuesday where I
> push it to Linus.
> 
> -- Steve
> 

Here it is

Acked-by: Shuah Khan <shuah@kernel.org>

thanks,
-- Shuah
