Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /8cUHP03GFuBXwAAmS7hNA
	; Wed, 06 Jun 2018 19:38:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F3591607E4; Wed,  6 Jun 2018 19:38:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 989CA60861;
	Wed,  6 Jun 2018 19:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 989CA60861
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeFFTib (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:38:31 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:34410 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbeFFTi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:38:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id F027841E7E;
        Wed,  6 Jun 2018 19:38:27 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AJA3Ljv5NyZs; Wed,  6 Jun 2018 19:38:27 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 5E1A340D79;
        Wed,  6 Jun 2018 19:38:20 +0000 (UTC)
Subject: Re: [PATCH] selftests/ftrace: Add ppc support for kprobe args tests
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuah@kernel.org>
References: <20180606093154.10408-1-naveen.n.rao@linux.vnet.ibm.com>
 <20180606203752.7768487691f4a85a56f82978@kernel.org>
 <20180606132006.7bcd1d38@vmware.local.home>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <2b5669b5-8b97-8de1-fe85-00d5cd307ac3@kernel.org>
Date: Wed, 6 Jun 2018 13:38:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606132006.7bcd1d38@vmware.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 11:20 AM, Steven Rostedt wrote:
> 
> Shuah,
> 
> Can you take this in your tree?
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> -- Steve
> 
> 
> On Wed, 6 Jun 2018 20:37:52 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>> On Wed,  6 Jun 2018 15:01:54 +0530
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>>
>>> Add powerpc support for the recently added kprobe args tests.  
>>
>> Thank you for adding powerpc support!
>>
>> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
>>
> 

Yes. I will get this in.

thanks,
-- Shuah
