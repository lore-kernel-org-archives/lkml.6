Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79045C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E112089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E112089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeJOWv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:51:59 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:39880 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeJOWv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:51:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 03235C076A;
        Mon, 15 Oct 2018 15:06:20 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0zaQAv9WTsmt; Mon, 15 Oct 2018 15:06:19 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id DB65BC0748;
        Mon, 15 Oct 2018 15:06:12 +0000 (UTC)
Subject: Re: [PATCH] selftests/ftrace: Add color to the PASS / FAIL results
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <CGME20181013022112epcas3p239547464b27b1d750b5628900a89f857@epcas3p2.samsung.com>
 <20181012222106.7f38b667@vmware.local.home>
 <b7525282-b27a-a34c-d503-61fe99673c9f@kernel.org>
 <20181015104700.1d530944@gandalf.local.home>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <ae20f738-d133-86ab-40bd-589ec9b4d1ca@kernel.org>
Date:   Mon, 15 Oct 2018 09:06:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015104700.1d530944@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/2018 08:47 AM, Steven Rostedt wrote:
> On Mon, 15 Oct 2018 07:39:13 -0600
> Shuah Khan <shuah@kernel.org> wrote:
> 
>  
>> FYI. Please don't use shuah@kernel.org address for sending patches.
>> shuahkh@osg.samsung.com will become absolete due Samsung IT changes.
> 
> I think you meant "please use shuah@kernel.org".

Yes. Thanks for catching this. 

Please use shuah@kernel.org which is in the address in MAINTAINERS file.

thanks,
-- Shuah
