Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx49zixEoZJGjduxsVi9Q0cin5MlM2ZzMd7GZkMrLSrejC3/SDhJE4JLya5rq4CyrEMp13j5B
ARC-Seal: i=1; a=rsa-sha256; t=1522344667; cv=none;
        d=google.com; s=arc-20160816;
        b=YskhK/6L3dM1PSI0IhBDJn7N0Ze6LKmX4rNmLc/p7QX042dqHV87M7lbIqK1Hu2OlV
         rsfWxcdQeNKKIbSmZ6eDRMG5PNMj0OC6yxjGwRxPTT36JTZJveMG7HkN3YaQAAI6kC+M
         M9AHY51QM5rXbHqPCgPY/oHYhEvyuadw49QmGtyy2SWuj9TODJMspWKvIq5z+628Ucra
         Bz/9YPq7JvEphspJ6segS2G44aCiklFDz10nW3GpCieuiSKF5DfUcHqhg7yDphH7w+ad
         +KP2IyfQSMXfaCB9cIa37IyCKUoGtXtT+k0CqYwXu5Gh23bk/pq3z6wW7hSiVDBcKHTe
         4ilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=4CZW1+lj4Fjs3oQ2WJ+AHOX4D0mvfFlZQEGfWkr0fXA=;
        b=wFoqJGoIm3BIQG9E++oHsq4ffmQwWloq8c1xHzyE3Wn79ElvTBo6xZxX8ea0XYvsmA
         BFctunob7kCdddVlclxQRwF7y9AvWjaCgJInX+PvhZpSxlopwLKGOoPRnH0VUTIDaH96
         ylQ2dPOMtMW3Wl33my9pLlxVvuwLPLtNJFCzTtnGk2DTOK7FDw0yuPJZBca3jzTIGXED
         8Khf3Upxt7RZOuFaHFaqVzqZZS07yn5VrjAJv9apAsX0yJV8quFgpB6kx+5ovzJMYEMG
         +kkKqeymlX8wUtrUBa/EJxRKqjqA+o3ghiMoQWNbeKwHZyKm1B6TcBfQAfZpV+fSPhq7
         vjlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeC2RbG (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 29 Mar 2018 13:31:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751249AbeC2RbF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Mar 2018 13:31:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DC021777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 29 Mar 2018 13:31:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Colin King <colin.king@canonical.com>
Cc: Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: fix spelling mistake: "tiggers" ->
 "triggers"
Message-ID: <20180329133102.6061ba66@gandalf.local.home>
In-Reply-To: <20180329172431.8171-1-colin.king@canonical.com>
References: <20180329172431.8171-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596293672950856020?=
X-GMAIL-MSGID: =?utf-8?q?1596294081492257714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 29 Mar 2018 18:24:31 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in message text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
> index c5ef8b9d02b3..1b8faf4c318c 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-multihist.tc
> @@ -35,7 +35,7 @@ do_reset
>  
>  reset_trigger
>  
> -echo "Test histogram multiple tiggers"

Oh Pooh! (/me wonders who gets that)

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> +echo "Test histogram multiple triggers"
>  
>  echo 'hist:keys=parent_pid:vals=child_pid' > events/sched/sched_process_fork/trigger
>  echo 'hist:keys=parent_comm:vals=child_pid' >> events/sched/sched_process_fork/trigger

