Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+2Fsd2Mm3SOA7FF7VU7gN09J4hJaggAV50vJh8osCRGLEgziJjAqCh/FwTJGD/4ycqjLAE
ARC-Seal: i=1; a=rsa-sha256; t=1522756789; cv=none;
        d=google.com; s=arc-20160816;
        b=sBsVNlDnrHI6QbwuAXN/JiATsUOJ/qrIetGiHMUeHKc9q+B9vWTY0u2/+C1/grdvby
         sFJsYYKBFsVFX04mTmJLMy691QY1cHLYEaBTD9sM9Wa6MUKakCLha7roCBM885jk+6jC
         paem+hmhuG+5vyz1hJJmbb0UXJ9B6S8x5o+mBwZwt1S+sgS9B8NYPIUDBedi2W2xE8hz
         kQgqhmuZSFMR39zBcH5tlie9oUIH6FcznGIff05hEWzVAK5V/7wtN13WvrFVvgwFhMNP
         gTff3QU1OfpHJxjpePZbIlEpkylD53UeI/kyzkWC2jj11pDrbp+GbdbIsp1NvmZ5Zhv1
         bX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=7u4oB4HqAdi3k8C6HARdZ8TwkmPtplGAA+HWVOA/lik=;
        b=KagQdvbfrYHRYuHIEdpYQ5Km5cZdRZYYgkywob1RdzgEHS2TTln0td9UIBTgm8Wez9
         6c1gqztG+OuFwo6Mz/VoYmkkSSuVHC+UaCaMF13GQOqsuBcN+wcxLUeVGUmpHePRri20
         9eAiWjWP9G4Z1euovHYau9yUeeQNXyfHemH61oC7ttUTU7KwdoG4Dg1rPeB+JAESJeG8
         df+ERox4IRGbEXqPcZiwGuOkqecoMVjGiRVYLejxGM3Y1I/2Gl5M6SfZ862qQQLjLmXk
         7SF9XcGTktriMHzx2mOfwObKHByF6APtzYvloj6DED0Qq6H3eMnY4OQMpJOFWCNL07Jf
         +77Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755496AbeDCL7s (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 3 Apr 2018 07:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755490AbeDCL7r (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Apr 2018 07:59:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FD320CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 3 Apr 2018 07:59:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>,
        trivial@kernel.org
Subject: Re: [PATCH] selftests/ftrace: fix spelling mistake: "tiggers" ->
 "triggers"
Message-ID: <20180403075944.0fd44f82@gandalf.local.home>
In-Reply-To: <20180403100704.hwdugt2piatcngqw@mwanda>
References: <20180329172431.8171-1-colin.king@canonical.com>
        <20180329133102.6061ba66@gandalf.local.home>
        <48be730c-2a15-d3ad-d1aa-7d57fe7db6ca@canonical.com>
        <56713d51-0954-e7a8-cf7a-7a6bfedf58f3@kernel.org>
        <20180329140409.1311baac@gandalf.local.home>
        <583c21dd-2ffc-4375-af8a-aa721ffb4594@kernel.org>
        <20180403100704.hwdugt2piatcngqw@mwanda>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596293672950856020?=
X-GMAIL-MSGID: =?utf-8?q?1596726223377533039?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 3 Apr 2018 13:07:05 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Fri, Mar 30, 2018 at 09:51:21AM -0600, Shuah Khan wrote:
> > On 03/29/2018 12:04 PM, Steven Rostedt wrote:  
> > > On Thu, 29 Mar 2018 11:54:28 -0600
> > > Shuah Khan <shuah@kernel.org> wrote:
> > >   
> > >> I will pick this up with your Ack Steve, unless you want include
> > >> it in your pull request.  
> > > 
> > > You or Janitors can take it.
> > >   
> > 
> > Okay we can leave it to the Janitors then.
> >  
> 
> There isn't a Janitor tree...
> 

But there is a trivial tree. I guess the confusion was that
kernel-janitors@vger.kernel.org was Cc'd. Where do their work go?

-- Steve
