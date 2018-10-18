Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1739ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDF32145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDF32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeJSElP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:41:15 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:53822 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSElP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:41:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 04BBDC1B4B;
        Thu, 18 Oct 2018 20:38:30 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Cb2wxvqljYfv; Thu, 18 Oct 2018 20:38:29 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id E077ABFDF6;
        Thu, 18 Oct 2018 20:38:23 +0000 (UTC)
Subject: Re: [PATCH v2 3/3] selftests: ftrace: Add synthetic event syntax
 testcase
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <153986829702.18251.1286066460999338772.stgit@devbox>
 <153986838264.18251.16627517536956299922.stgit@devbox>
 <20181018163427.6e0f823d@gandalf.local.home>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <7cf20a84-841b-de35-939c-03314e0ac0d3@kernel.org>
Date:   Thu, 18 Oct 2018 14:38:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018163427.6e0f823d@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2018 02:34 PM, Steven Rostedt wrote:
> 
> Hi Masami,
> 
> Thanks! I pulled this into my urgent queue and will be running tests on
> it over night.
> 
> Shuah, can you ack this patch, as I want to add it to this release,
> along with the other changes.
> 

Acked-by: Shuah Khan <shuah@kernel.org>

thanks,
-- Shuah

