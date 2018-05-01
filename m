Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AB8JxZoxcGPglPXlqq5RRrtuEw7DV138L2r15IzgsV1EQZOAiD1zhMc10eCOQMTXLwhuLBeSbYy+
ARC-Seal: i=1; a=rsa-sha256; t=1525184600; cv=none;
        d=google.com; s=arc-20160816;
        b=mcpq8HHcZCXhD+PgQL6jllYn1yUXIxryEJBeOqhAhLrXqNcQiAwDAi4dXcuPP2gpYj
         XOwLct+8P09606yix2sVQGqH+0nQJptYufYv8PVRc4CUQGPouzyQyItUK13laVqcjSlf
         ditA0yTij32a5k8x0JRHHRBuKmEF6PnTPIr41wcw2IucLKznunfkJr/b8yimgvl/HLex
         reSGQGDH64qVK0gENejmgP4mPGVvxka2xYGcCEnU44O7WDA9Lq4GHp45p2lG6GXn7VQq
         fF3yONzHbS8CrAh00fI4VsiiTRE798annN+udhqbdWnqeqrZuAOCiLcQk4pA2y+wUyas
         KsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=vz1cu9WUkyPaIOk/ilYLQhRR9iTm/biqK/KVeYzZnq0=;
        b=f3GBZ/OFzX5ivgWNOWDljuvTIY+39hpS20AYORfa9JtwGd36v4Qi3Z+yNa2iMCdeek
         eCysE1w/w5KvY2VB8v9DyLlRuqUxeaVGFVmXs2vxlXsIui6z/J2qoCWfuMXK1f2MflzS
         cxKnEgALdoOpme+2t0TYfamtPftD4GYMKHqmz7QqDYfc0E6+I2Fr+0ITU2SXhN+9quN4
         txnbqqvETP/Zbde2YiTJ8LYIj0nGge27BwhOMaKcgxGUnoSFO8IBm7jronAVEA2gT3E1
         msVwHawMTfDXKN328T8l9d9KU3AvqKOpMDH/JCPJvbQgImngnL+4c+LrBfoZGe6x369C
         sXjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Tue, 01 May 2018 10:23:17 -0400 (EDT)
Message-Id: <20180501.102317.2272802053999668772.davem@davemloft.net>
To: ebiederm@xmission.com
Cc: christian.brauner@ubuntu.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, avagin@virtuozzo.com, ktkhai@virtuozzo.com,
 serge@hallyn.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next 0/2 v5] netns: uevent filtering
From: David Miller <davem@davemloft.net>
In-Reply-To: <87fu3cbsdw.fsf@xmission.com>
References: <20180429104412.22445-1-christian.brauner@ubuntu.com>
	<87fu3cbsdw.fsf@xmission.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599077004828533491?=
X-GMAIL-MSGID: =?utf-8?q?1599271967165511695?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 30 Apr 2018 10:55:55 -0500

> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
>> Hey everyone,
>>
>> This is the new approach to uevent filtering as discussed (see the
>> threads in [1], [2], and [3]). It only contains *non-functional
>> changes*.
 ...
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Series applied, thanks everyone.
