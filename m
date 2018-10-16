Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085B2C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED8820645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED8820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeJQBfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:35:13 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:60395 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbeJQBfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:35:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id C5F16C1489;
        Tue, 16 Oct 2018 17:43:40 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EGizF1UDnLc2; Tue, 16 Oct 2018 17:43:40 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 0C1DDC0781;
        Tue, 16 Oct 2018 17:43:30 +0000 (UTC)
Subject: Re: [PATCH] selftests/ftrace: Use colored output when available
To:     =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        linux-kselftest@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <20181016170220.31156-1-daniel.diaz@linaro.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <037e072a-5695-1343-35d1-37b9450581d4@kernel.org>
Date:   Tue, 16 Oct 2018 11:43:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016170220.31156-1-daniel.diaz@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 11:02 AM, Daniel Díaz wrote:
> If test is being directly executed (with stdout opened on the
> terminal) and the terminal capabilities indicate enough
> colors, then use the existing scheme of green, red, and blue
> to show when tests pass, fail or end in a different way.
> 
> When running the tests redirecting the stdout, for instance,
> to a file, then colors are not shown, thus producing a more
> readable output.
> 
> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
> ---

Hi Daniel,

Thanks for the patch. Steve is working on adding this functionality. Please
see the latest linux-kselftest next for the patch.

Steve just sent an update to the patch to fix an issue. Please test and see
if that solves the problem you are trying address with this patch.

thanks,
-- Shuah
