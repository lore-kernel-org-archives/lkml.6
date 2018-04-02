Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/NEb6X3HWiDt5FEJgyrFB3QnCsuT+o26OeE8f+rDt+EW2KhT7zVmoLq5NmTIZoer2hBOy6
ARC-Seal: i=1; a=rsa-sha256; t=1522652334; cv=none;
        d=google.com; s=arc-20160816;
        b=fatUKt65CZvCu6EcYXis8vzfmJXzFE29hEmN7l2zJ+DgVGU3kMiro3VcfjjLkhaRcu
         i09vueQcJRE/Q+ZnfIzoqZLeqapK/26fkEMjGqELgTirJgR5KVps7oeYFXLVZH9OEzIg
         iouCJvYbXvxjHvyFt6cGg5DMSMEOdtr1K2xTtp06RuIreFqHdNMykvrgYhNSOIWQEQNb
         gIrCU/D59fCdIuprSwvSzFI25F6DsS0vjFxUtDYFT2Jgnq19B147fR70tDb/tg2JINI1
         /CSkXtQ3x5+896xMsV7qnawyCUquv/RjtSWs4tqIHTyj1PlRaC024+qZn24EnrVnR//1
         Evog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=2ZVOzmndJaybX+cZkhkYS3wh29vwIwnBqTjXkfoirDk=;
        b=nbx1YmfJwSz0DVES86/I1ib1Ufo8TuemELrKavcCDYGkxDvgFmk2uJqYc0B3eYDw13
         hqmKaNHz0HBJtxoa1rZ21E60Iz9N/GWjLaDCuL8T5v/4FlTcniISN4suDLGv0aMFwMmS
         RRMBq2R3LxjnDzWwozg/whjVY7+jmz9K8DLn3E5iwz2gNqZzvjBODo5OzdhmQzW5GUKN
         GH550908H+DIH1Df0Fdr5nWCmVGht0949zFWxuaEDXQ04WDqj97H1IDZyoIy/hIisvEK
         7tOAA8FilJSKYnPEZ+YswuQ7kK7svTYRCHjsr64/u3iM2kKZ++6P9fEZa8EGK4wmY/lP
         pfkg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbeDBG6x (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 2 Apr 2018 02:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754132AbeDBG6w (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Apr 2018 02:58:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE40217A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Mon, 2 Apr 2018 15:58:49 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: fix spelling mistake: "tiggers" ->
 "triggers"
Message-Id: <20180402155849.109fcb9c5d4653fc7adcddf1@kernel.org>
In-Reply-To: <20180329172431.8171-1-colin.king@canonical.com>
References: <20180329172431.8171-1-colin.king@canonical.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596293672950856020?=
X-GMAIL-MSGID: =?utf-8?q?1596616693953283540?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 29 Mar 2018 18:24:31 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in message text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Oops, thanks!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

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
> +echo "Test histogram multiple triggers"
>  
>  echo 'hist:keys=parent_pid:vals=child_pid' > events/sched/sched_process_fork/trigger
>  echo 'hist:keys=parent_comm:vals=child_pid' >> events/sched/sched_process_fork/trigger
> -- 
> 2.15.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
