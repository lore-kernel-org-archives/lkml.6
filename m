Return-Path: <SRS0=+d69=IK=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AB8JxZr8JeZyUkjO7l8AQd+RrqwGYCU2ZqIHLhkbAtvUWb4F3ifTzCf/hVzVhWrtkDvpnVktMOMP
ARC-Seal: i=1; a=rsa-sha256; t=1527036960; cv=none;
        d=google.com; s=arc-20160816;
        b=P/yHDqiqx0RSrTd1nKZ/kvfbrKV1t+Dq1jc8pxGqPgVTRTJlS/DpIGF+8bh7MzJLcI
         gXV1rJrvVT4vl0RLbHuJiuk4ofPI6Xvd1YbrYXnCdG9sOlOfAETo1E+K0VSmuE+iykPm
         VNN3PSrUUtFemyyycC8qzV3+pwAcwEWZTYTW0RqCC6gmtAkeDMmnMBpnGuJx7arkxukv
         yrubV1w4cfunK2Hr9aJwdmv2//i3aFH+dHil7pOkcnU8w4cb7PQHG/AEnuoIBzjKK3z1
         9GUjDxRNIjdBSflXZqYwAzxs98ZEviTBGAJvphdZl7ASY4uY5xL1wPBlWQwu9D/nhIj+
         BHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=+e2kdVcz1uJeVdS+35QRfmoLG/qq1sx1+ptU6tbvVYU=;
        b=lT81kn29gYfp3aLS1svMH1x9ZqkWpKlj5DIGkoIRX+zekK5mOQlnkose9vgINY8MKk
         TDhJaUxj1NKaM+qKgffMi65/QYL2lxpQEDoPC5FCHDEVaZ64+DwkkkaEop9Xzaxu+2LT
         +BawdQiwC/GPLEiEnbEmVqgCfrGQdiTz760ia+ILhXVF/EQRvN5iPBrH6Nkmf1KTrQAY
         IsqaPZcEflo8JI8TeE1Ye5/w723y8xkkGYisNHoJG/8A9AS6BLXT6Ctmo/dlXkgx3Cwj
         EiX3v16U+6uJ6vmRq958z5CqmMCduxHdifvp+edGzMUydUYsLEqm4g9EcTnKqzjRMtC9
         vIvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srs0=+d69=ik=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=+d69=IK=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srs0=+d69=ik=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=+d69=IK=goodmis.org=rostedt@kernel.org
Date: Tue, 22 May 2018 20:55:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vasyl Gomonovych <gomonovych@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Philippe
 Ombredanne <pombredanne@nexb.com>, Al Viro <viro@zeniv.linux.org.uk>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Levin, Alexander (Sasha
 Levin)" <alexander.levin@verizon.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH] ring-buffer: Fix typo in comment
Message-ID: <20180522205557.4cfa3c3f@gandalf.local.home>
In-Reply-To: <20180518203130.2011-1-gomonovych@gmail.com>
References: <20180518203130.2011-1-gomonovych@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600835335190642114?=
X-GMAIL-MSGID: =?utf-8?q?1601214308432102966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 18 May 2018 22:31:28 +0200
Vasyl Gomonovych <gomonovych@gmail.com> wrote:

> Fix typo in the words 'reserved', 'been'

Thanks, but someone sent me a bunch of spelling fixes for that file
which included these. I'll be pushing that to linux-next soon.

-- Steve

> 
> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
> ---
>  include/linux/ring_buffer.h | 2 +-
>  kernel/trace/ring_buffer.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index 7d9eb39fa76a..aa500da87f2a 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -63,7 +63,7 @@ void *ring_buffer_event_data(struct ring_buffer_event *event);
>  
>  /*
>   * ring_buffer_discard_commit will remove an event that has not
> - *   ben committed yet. If this is used, then ring_buffer_unlock_commit
> + *   been committed yet. If this is used, then ring_buffer_unlock_commit
>   *   must not be called on the discarded event. This function
>   *   will try to remove the event from the ring buffer completely
>   *   if another event has not been written after it.
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index dcf1c4dd3efe..a8a8eb23c489 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2776,7 +2776,7 @@ rb_reserve_next_event(struct ring_buffer *buffer,
>   * @buffer: the ring buffer to reserve from
>   * @length: the length of the data to reserve (excluding event header)
>   *
> - * Returns a reseverd event on the ring buffer to copy directly to.
> + * Returns a reserved event on the ring buffer to copy directly to.
>   * The user of this interface will need to get the body to write into
>   * and can use the ring_buffer_event_data() interface.
>   *
