Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx49FwTFf6xizemc3168uYv+GoaaRl9UAxD8M8WQ+S3XQ5ZRfavV5rJKdRYgXQXPD5GOoWuZO
ARC-Seal: i=1; a=rsa-sha256; t=1522348219; cv=none;
        d=google.com; s=arc-20160816;
        b=I3q0gzj9otMTJaaHmDog5oaaj5aHzYJ2Kmm0Y5scckFGu5Ot2cxCWl7cS6kaKZvJOu
         k8jJCdpBurku6RJLcwJJoLc65stfxwN5db71gxcyycWpag2zu6luZ2z1o7N/QrMPeA8B
         r2zQZ6gtneFqR7TpwGPtPHMRCL2l0vLfundPwdnzoto0NouEs0Wgmb8sMoj+YpSG0wPO
         KLCh4wd4DLcEZ3p9P7LsK7T/GfRwl2K4R0WjnLj2QrixTR1IZsu2smhRWTlvFZthbGC4
         b8FJsfqD83w7590u0vsuFHkg7uxhCA+ajDjnxkajlku5rcCvRySXTJALxgc2axuuGyK2
         WJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=3qnonua08ZbEP5POqfN50oFJpYKGJErJEWaI27Ng5SU=;
        b=NJmxgKepz/q664HBv7qlnrViem2VXUIixfIQ1DcyCdfRtHwCww/I7a8cPvotkFY9Ff
         p+NcRMXIk3Saek3KgALPLdyTlKu+xK31yt6mb53F7e66RUGS7ctogFCclFR0WBOySGX6
         1NR9K8QZhYY2iwGtz38ehW3MxMWv7O53k23oQyGIW4mEzqs1oCpoA5V1oPQWDOUdIa+5
         sn7yyfTMZOxF2xFg+FqRaiDzqOY/igEkLPJdGCOJ4qc3cdtjV8wXFqbW5M6VdC1IzbiJ
         PPiDlDTn6rX930s0qTBx53eNS1RYrDVwVzMdwUoxgaxUSc6iAFBYqxTgfKsuQ9q0I6OY
         lu2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeC2SEO (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 29 Mar 2018 14:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752943AbeC2SEN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Mar 2018 14:04:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D0421777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 29 Mar 2018 14:04:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Colin Ian King <colin.king@canonical.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH] selftests/ftrace: fix spelling mistake: "tiggers" ->
 "triggers"
Message-ID: <20180329140409.1311baac@gandalf.local.home>
In-Reply-To: <56713d51-0954-e7a8-cf7a-7a6bfedf58f3@kernel.org>
References: <20180329172431.8171-1-colin.king@canonical.com>
        <20180329133102.6061ba66@gandalf.local.home>
        <48be730c-2a15-d3ad-d1aa-7d57fe7db6ca@canonical.com>
        <56713d51-0954-e7a8-cf7a-7a6bfedf58f3@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596293672950856020?=
X-GMAIL-MSGID: =?utf-8?q?1596297806495944617?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 29 Mar 2018 11:54:28 -0600
Shuah Khan <shuah@kernel.org> wrote:

> I will pick this up with your Ack Steve, unless you want include
> it in your pull request.

You or Janitors can take it.

Thanks!

-- Steve
