Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48Dwbtk9zYN3166/OGn9B16CSSjGePEhhxAgZFNiGUd2Tw5fIFcnFZuDZu4pCbtDivGWL9P
ARC-Seal: i=1; a=rsa-sha256; t=1522425106; cv=none;
        d=google.com; s=arc-20160816;
        b=fkfUJQJNmv/bjroEEYM86AVTjZrTs87M9Y5J8VoC/Ob50GeKnYt2rlL3RMqq8MG/0I
         GkGNQznoTA+SP9dMWw1Ry2BwACNmZqSM4xspYeQ5MgnXA/QqeV8yLNQFfEO5UHmYeuAA
         97xx1jAOZbtAf7KqKW6Tb3CgOQMB1F8engz/DDQg2snpvfE0HzdjYyEnkO6cbW6UYaII
         3PsfqK7JAHbBuMRv4BzLSTXU6NOJ+WTNmKVPLola1Vt07br9V9PvUs5PuicfS3Q/k0ll
         i5/dGV7/8T3EYwok1VhybeJ87+ZXyuSpdZJ4B1h8QSZVsYgXoXER8RdxorTN8W6paYgL
         JpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=X3tPSc18cOy0vNl8w/Sw93Hh4h6wM5hT8Jyj+D1mt7c=;
        b=eOTATww874SXXRKulg9cbtj7PzLP+wrhoK+HNWMzizpfR2ewADob0YqbmKVzlWlAjA
         sYsdUc31yuWrlGSxjTctlYEN7Co4n7GONKJdBWuUxZbswQEoaYrDVcL7uSRSC2DnSk6s
         Re2xaGJNHeLcZIdqR/atDmNjeEPdq7VuYWX+AIOpzJuJtd5NDcHbs0ttfkopGEtPYyY1
         fvsIbTAT+9uglKofVVVSp3SeiWbKw6RrSZvI1eQEUB01Kh1jBWejNmbc1h6M09aPCN3m
         icSb+QeoTIyTH4OYo3XjPou1o/+u+zgeqyut7J3+YVZWq92vEDgRhupNZC3g7Cmw3uAg
         40wg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeC3Pvq (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 30 Mar 2018 11:51:46 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:48883 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeC3Pvp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Mar 2018 11:51:45 -0400
Subject: Re: [PATCH] selftests/ftrace: fix spelling mistake: "tiggers" ->
 "triggers"
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Colin Ian King <colin.king@canonical.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180329172431.8171-1-colin.king@canonical.com>
 <20180329133102.6061ba66@gandalf.local.home>
 <48be730c-2a15-d3ad-d1aa-7d57fe7db6ca@canonical.com>
 <56713d51-0954-e7a8-cf7a-7a6bfedf58f3@kernel.org>
 <20180329140409.1311baac@gandalf.local.home>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <583c21dd-2ffc-4375-af8a-aa721ffb4594@kernel.org>
Date: Fri, 30 Mar 2018 09:51:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180329140409.1311baac@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596293672950856020?=
X-GMAIL-MSGID: =?utf-8?q?1596378428711877595?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/29/2018 12:04 PM, Steven Rostedt wrote:
> On Thu, 29 Mar 2018 11:54:28 -0600
> Shuah Khan <shuah@kernel.org> wrote:
> 
>> I will pick this up with your Ack Steve, unless you want include
>> it in your pull request.
> 
> You or Janitors can take it.
> 

Okay we can leave it to the Janitors then.

thanks,
-- Shuah
