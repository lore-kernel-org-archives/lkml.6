Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZpSPx5RGMTO+brepXdci1Qh3TVLoPeNZdbjN1tCgKOx4ApVGo0ylol41DeCw0tgqFYGVrKL
ARC-Seal: i=1; a=rsa-sha256; t=1525079715; cv=none;
        d=google.com; s=arc-20160816;
        b=FDDEBBxLLEa6qKiIHjQsKKgp38VvOafxLcel0FsyUF6N1Ce9qMn4F9wnHnTh9nbGMk
         c3urBz9Dj88ySo8e+xGyKXpVlgusw9MBOs3R+miTnOnCLfIC8HNk6UR9Q+RuKwCwjXWv
         T0eDVBxNiJyxyZNxIxmMAlZ/ZGFAWoz0m/+uClqsLsfyhQTKJo7dMhiocg96miz7i4WX
         bCSFWVSQcdBUXF+mOsgFlJ0cInaE+QriLUHPy03B1L8rwHY0gYYqcXO4h8wq6P2X6mr8
         zydOII9oRRONSM9q2YRACwjVDkF5KPGzXd2m9VQ3PNauoyFmtPDHTicg1D4+cjC3C3RN
         70ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:to:subject:arc-authentication-results;
        bh=2WXr2XvIVd/MFhf+6JN0i1SR0TuiPb7K/BxTZ43eGY4=;
        b=bijG+UIftXobe34sDoA44wVXUTUnb7942h9HJxX7lhutvyLqTxTUiBG4PGevL7YZJn
         AN1QUtg5f6KG1yFT3//SgwH4D5oKXZRGs/TYdZc2wbZ3MYMTsxJPdlxLlfz3Wma+3FnX
         W9eR0/LRfpMqCAbiIj3hdUBbOZ62YeNr5nuNcS62eU4Ci5B/094EG/R4yOWJ+xdKT9ns
         dU8IStEQhn8oKqSYALX6g2b2jrdV3h2nflIuzLHqIYDr9iNo2WChkrI+yszarlcKs2EC
         eY1BrvyYyg7EFKru0+03GBNS7H37DLOfXtZRcNBiscVFh86BdC8EANIEQPMW5SS3WR82
         9DCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbeD3JPN (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 30 Apr 2018 05:15:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753029AbeD3JPM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Apr 2018 05:15:12 -0400
Subject: Re: kselftest archives etc.
To: Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <958d61ac-f70a-80b1-a657-59fe1fd1d369@infradead.org>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <a407c7a0-add1-f9d2-95d4-bb80ff44d90a@redhat.com>
Date: Mon, 30 Apr 2018 11:15:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <958d61ac-f70a-80b1-a657-59fe1fd1d369@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598946970016814291?=
X-GMAIL-MSGID: =?utf-8?q?1599161987973780210?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/28/2018 02:17 AM, Randy Dunlap wrote:
> (2) for this patch:http://www.spinics.net/lists/linux-kselftest/msg03136.html
> 
> [PATCH] selftests/x86: Detect -no-pie availability
> 
> Acked-by: Randy Dunlap<rdunlap@infradead.org>
> Tested-by: Randy Dunlap<rdunlap@infradead.org>
> 
> What is the status of this patch?

Yours is the first reaction to it.  Shall I resubmit it, with your ack 
added?

Thanks,
Florian
