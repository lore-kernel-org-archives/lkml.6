Return-Path: <outreachy-kernel+bncBCFPF2XH6UDBB35WQDKQKGQEFQ5NC2I@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520442224; cv=pass;
        d=google.com; s=arc-20160816;
        b=Hx3XdQhS+am4UaZGU52KlpP7Ftu1wHeSA2ERB0ZyUWxGzoo3uk36ii/7+w/G3aiS9P
         LMfS2CD/KL4s1b25ZoODI/npd/yVayswtLXMAaFJVWdzCrSEHP5axwzEJi5VjpK8xq7I
         URBDlxbVYTkd6KlKHRiZa8AumagAjMIoTHJTVSJE10Zm2ygEGHvN9cgYRyVHqu7599qY
         1vvHVlgkoqSq6QEfYVf0FeFnzF2hgLgVjgElg0zB+audkl5o118EeWxXHlMni1wT/xAu
         BXCNPE69gitMWXivzKTEqfNoQa6GC+xhI5/kGT+FOqMPvM81q3xmlTB1nj7+T6I/eGOz
         Vs8w==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:from:subject:cc:to:message-id:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=kbNb5cmDCbJ3yd4wNa/ggfeSrJ5x2fEWCbLiCuHTTtk=;
        b=dtp6x5mIosAIjct8SW35acFRTmFpJpx4+N1DopxF1++qyos2Y7ra9dtKbdoKLPxD1Q
         cYNhP3EewNZpzCezuE4LVuq2AznHiy6sMeKihXAff0qHEuj4y7WyE66JDkNFf0dfM6wq
         RLWTND63l+cs7HNQPmI7hxzkSQzBRyptrOUi/7PqhU4bBhJGogh01xsyR/jJd3E1voJR
         WE0VuuZrwqrMZLCqDtzEmJktS86edxNTGgLk/1wCoTXt4iRDQeToBbtHpsFSWzGWu/va
         BzLJ+rVl5lfFd3RU7Vk7QaVGUUxPfIyj3hPxkdWSQ6GTbBM8LX0A229QfJwZhj1qWRpA
         vaHg==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=AvoWGTyL;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbcfpf2xh6udbb35wqdkqkgqefq5nc2i@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCFPF2XH6UDBB35WQDKQKGQEFQ5NC2I@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=AvoWGTyL;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbcfpf2xh6udbb35wqdkqkgqefq5nc2i@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCFPF2XH6UDBB35WQDKQKGQEFQ5NC2I@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1520442224; cv=pass;
        d=google.com; s=arc-20160816;
        b=iKTdPET6L0xhqp9sEZSgluX6odUI2I2XH7/tlxnOHFS4sucMJrTLP64+Wqw4GZm5m6
         o4xUq+CU44NGEGuVwVVC+7ehDkO3qAbhYVBu394s3pLZG96pbmPU3Ni0y2XX6WG7WG7r
         R9l2xpFpZq2tlaPkGEqzSFZK/71/gulvGghugAPTn0a/t/ifdRUMJnIrbfIr5pk9xPmd
         QNY6tbFtYzPd0dDyqqz5EXoOx4IxaOPm7UkzQNUJPNQSRmnX9nls7J+Rk8eVhWlJDolX
         0EMrCH9aXlUVldWkjoLnxDnf0jBycUZMS6WHw7gnTQwQwN5sUUeLNNpi2S9suL8Sp7V8
         XeIw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:content-transfer-encoding:mime-version
         :references:in-reply-to:from:subject:cc:to:message-id:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=kbNb5cmDCbJ3yd4wNa/ggfeSrJ5x2fEWCbLiCuHTTtk=;
        b=IL9WE2slgGXOYRunNp8k2DUxEhdNJu745++cnEX6tMzks7YlEIihVQUh9ojPExu7EM
         M1Y6XzpKkbxAKf4u9ijUmSvFYFe1kErHDBj8xranY1U+NqIzD0xdLnNSDeF/ORyZGC7L
         SSRPLoPxu768zAwayETvoKbJ9E6EscFHJd+QRM4f4pawhlx7XizF6pQJ5ifHssiQKNnC
         jlQo7r4lfMJ22+IF5D/q5PRmMiKImVs0JfKVolODbJNN6IeWBbDKpcxSUS/MRkVA8BIu
         jjaLs5IBg1okwc0MwuYmqp0tv31v0Odjvv3DfHUH/DtOnhDLS/k3Nml6unmv+MrN8xWw
         F69A==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELt+qVRaaM/bDvntASy85c55UAvtKmS/q79wblLX0VcWClRJMcLlW9XgH2HeKol2rNsRqqTQ9A==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520442110; cv=none;
        d=google.com; s=arc-20160816;
        b=ztTwrBPMDU+eoq/wj8aoVeois4Tv4O3VhacXC2S573x7fP5cmvwHKKiqvtrN2EBwb2
         wYWJ31amJE0e4qft92fdv4J6Oqsku7zPUvgrCiOBGteBVWkEjc7k0q/EqWztgI+ikbaQ
         XRctge5ngFfMwXciesPdTcfRgywPImrxxu8Bnc7OkM1OWu34Dhkor2qYGs5YqbR0xPt1
         EhZbIvjlTXWsxr70TaKmtKu6AczR0Af4cvQenRCBoAWC6/sBbrD27qO0v8ZVIHI08k1G
         TaIOwQWePvXPfqrt/ejBuRqHVPXpvI4SbGMkp1Msd2pP7paUhDTpMKX1jb/fi2/WpYnf
         bqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=kbNb5cmDCbJ3yd4wNa/ggfeSrJ5x2fEWCbLiCuHTTtk=;
        b=K4limaZh0swhKw1XP+DTWAHo91aaL+X9kEApB237DaQXR1K0Rr+7P5m6fz9lqHHWXA
         i0blh4PTYCRwqv767OwLjxbaS7Az/3BldlPnJb+cAoKhl+Wj8+hhyYaxPbZQpg9/4wm5
         Tf/n0qdobCEITKKZs44i6NqRAL1JcqlyLi17Br09nLTokHANl2fmHpqOtjzzLrGWpX6s
         KMxX9xSy1Do9xxPDZtCJnphtkEAZj4Cinh+Z9FkPrk41H7ep+LdLTg/seKi0e6GPyDux
         Rghi6W5kPtY46ZfuPW7YCOSr4e9JwFld4pSxcna+oq/cUF7PLRez/TA8aDTm1nN54E+Q
         9PZQ==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Wed, 07 Mar 2018 12:01:47 -0500 (EST)
Message-Id: <20180307.120147.195464731584241423.davem@davemloft.net>
To: arushisinghal19971997@gmail.com
Cc: jdmason@kudzu.us, jakub.kicinski@netronome.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oss-drivers@netronome.com,
 outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH v2] net: ethernet: Drop unnecessary continue
From: David Miller <davem@davemloft.net>
In-Reply-To: <CA+XqjF8_axeTnahPmokxmDnm4NmWo8QWSEmLejN4fO1nAiDaBA@mail.gmail.com>
References: <20180303161456.GA20194@seema-Inspiron-15-3567>
	<20180307.103901.1771176275743006915.davem@davemloft.net>
	<CA+XqjF8_axeTnahPmokxmDnm4NmWo8QWSEmLejN4fO1nAiDaBA@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Original-Sender: davem@davemloft.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 184.105.139.130 is neither permitted nor denied by best guess
 record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593933797410411478?=
X-GMAIL-MSGID: =?utf-8?q?1594299225901950822?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Wed, 7 Mar 2018 22:22:13 +0530

> Yes I know it's for the inner loop.
> But I am not able to find, where I am wrong here

You are making what is essentially a nop change to a piece of code,
which if you had instead read carefully would have instead inspired
you to fix a real genuine bug instead.
