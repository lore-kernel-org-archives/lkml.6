Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZqCdWdmzEXOxVjfp1PP69qXh9ABVqyZuYsGAARYdOMY57in0BN7elZmhZeLW9rtjhajTWyD
ARC-Seal: i=1; a=rsa-sha256; t=1524874658; cv=none;
        d=google.com; s=arc-20160816;
        b=LenVJ0HKzgvLoTo0yX1nVQ9vTbUEgLJSPxcZezgDYj7L3fa2kRP3ekFyIr4hYZHsGV
         9+JajHK4fjllm1PFc5NoXOojB3SyMi7et4wVjp1hvu000hqBZWrtU37FhIJXY2D4f46y
         mDX+T3cnb/PO7NQ7WGU42L3V5kgey9a6yki483z6+7rLhZZFRHK9vUOhrn1LWfljd4tM
         2Hu3a90Q8V33rMKqKVY3KcDQL/4PY2ZwY19WiYuLhnEW0ghjEVNlfv1ql73TmHgFBqfU
         dJfh4TfLztEsq1uRxJGmJoOKaAqv0sK3C61ly+b+xR8ispAh6QOTpBmR9ZKogt6Iqjva
         SSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:mime-version:user-agent:date:message-id:cc:subject
         :from:to:dkim-signature:arc-authentication-results;
        bh=JmetDTZiSsQMOUeuv4ddnnNzCb7D5hsHSabMPPf87JQ=;
        b=nQzg0x1ZukK8C6Xf11xBa4jxpm0XI8mP7/nL7Mh+Q9EuRw4EKZjM8tTamDFZf1Pd8T
         qZE3ObXITZggwwYfKjIYLuN8N5AQICyeWl37Vdh53+f0d1kh4tKgva1M+Oqz2exa6XXW
         nJrEHQ6QAvTNHx+5KfQAfeBjq3wMre9FCmfYeFSizE5m3fJ0EUUdejxvKUjcdaXLsJat
         e6qCjEv0DLqqcmwk58IzahAk2Ugc6WEW0Y5DD5hBcc9cHA/l6kFmEiHMwewt1wXylV6G
         /0vERbwHsKUUQ7Dk68QUqG9qxnIu4//+CJit9I+BTyV76sJO9maL4PUUGe/7egYZAK4y
         XauQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@infradead.org header.s=merlin.20170209 header.b=dtA6JrVQ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@infradead.org header.s=merlin.20170209 header.b=dtA6JrVQ;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933146AbeD1ARh (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 27 Apr 2018 20:17:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47550 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933115AbeD1ARh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Apr 2018 20:17:37 -0400
To: LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: kselftest archives etc.
Cc: fweimer@redhat.com
Message-ID: <958d61ac-f70a-80b1-a657-59fe1fd1d369@infradead.org>
Date: Fri, 27 Apr 2018 17:17:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598946970016814291?=
X-GMAIL-MSGID: =?utf-8?q?1598946970016814291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

I was having trouble with the use of the gcc -no-pie option in
tools/testing/selftests/x86: (option not supported)

CFLAGS := -O2 -g -std=gnu99 -pthread -Wall -no-pie

so I looked for an archive of linux-kselftest@vger.kernel.org.

http://vger.kernel.org/vger-lists.html lists all mailing lists and
(some of) their archives, but none for linux-kselftest.

Anyway, I checked www.spinics.net for an archive and there it was.


(1) Is it OK to ask DaveM to list http://www.spinics.net/lists/linux-kselftest/
at http://vger.kernel.org/vger-lists.html#linux-kselftest ?

(2) for this patch:  http://www.spinics.net/lists/linux-kselftest/msg03136.html

[PATCH] selftests/x86: Detect -no-pie availability

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

What is the status of this patch?

thanks,
-- 
~Randy
