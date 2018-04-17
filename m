Return-Path: <cwahbong@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523963421; cv=none;
        d=google.com; s=arc-20160816;
        b=fLvBcwS4MpN3nfqgOn4aIxdvN4IkDYjX3PdPG4EU0QhwWpgs3ndY24YkX85Wc1w1rE
         OFiyjtiNXK8CaPLIZpQp4tFYCys/I6Uxn2pD3+UrUlGzpumwLjoY0UEz56YR97aYpSUc
         1oWGR8FkWx31s4kGTp/ITAGN6OpFi9gV14VBpfHU4g5GBD5wTZ7Xs4aE3bp9Sl/tP0N4
         8imTU8J6I6euEy1DWDUOT8vLaHTiyl86syK2e+2f71FrLKV7fVA3ZRh9ZRmLgcYuqLAY
         pKAaw+Z+RDvR8KlYX4beXCgKx7RZoObSkZHz2unwRKqpS09sETiXkfMUhKNk88vxbcEs
         JcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=8Rh4qRtlG1M2fCtj1gzV79Li1nsKw0n0ks48hQfvtC4=;
        b=axJShDsRCaLglhsCLQI53E60r5WTvgsfAogK/PRnGS0QmCTdMYtCpi+oVMbg6fTAAg
         KEvxy6fD/4MXP90gxdphN9Zf6YOSRSo0BXTbmdT2cU+mV1yoNpk4kRxSPayP16FBRcqI
         UsBFL6zVJhL/EiYVchqX09/9s1JKB+c/xIwH4Dp5NUWarzoUrltYyGvmFpR5yuW6+oqd
         PHVjst5F4BeN8rEz+ISksC/eoVsp6o++zqMe2S06mjY3EeqtOQvluyx0btuzrq4Ppcxj
         w+2z1UF4ayMPs0Cpvw6CsEb3KG/M/+JKDlaMVmq1K3N8z5gJlP/JFcoWHW7OAOiDRGWb
         SaIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=sx70P7Vm;
       spf=pass (google.com: domain of cwahbong@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=cwahbong@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=sx70P7Vm;
       spf=pass (google.com: domain of cwahbong@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=cwahbong@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx49fene9Q5Ai2Kh1/mv/jlgs3FcTIJlNI+jLhNomEWOtHz/mFXHFv7dvp1x0zL4cehD1boG1i3ROKrDkSFTSFFA=
MIME-Version: 1.0
References: <20180416023626.139915-1-cwahbong@google.com> <20180416092444.05ec6434@gandalf.local.home>
 <CAEvWiR--DLM2Tp8-OaZSh4LV9o8x2K47c9=-+VZFoDhedy=nZQ@mail.gmail.com> <20180417102909.GA8057@kroah.com>
In-Reply-To: <20180417102909.GA8057@kroah.com>
From: Ahbong Chang <cwahbong@google.com>
Date: Tue, 17 Apr 2018 11:10:09 +0000
Message-ID: <CAEvWiR9BgFQ1d8L8hgrxazE+SUZT+4kKM4g-+odBh8pdnGvh3A@mail.gmail.com>
Subject: Re: [PATCH] trace: add missing forward declaration
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Todd Poynor <toddpoynor@google.com>, Philippe Ombredanne <pombredanne@nexb.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597868580333311001?=
X-GMAIL-MSGID: =?utf-8?q?1597991468759144511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The new work series are not ready yet. I think this patch does make the
source better so here is the small patch alone.

-- Ahbong


On Tue, Apr 17, 2018 at 6:29 PM Greg Kroah-Hartman <
gregkh@linuxfoundation.org> wrote:

> On Tue, Apr 17, 2018 at 02:18:47AM +0000, Ahbong Chang wrote:
> > It does not fail with any config without this fix. This is for new work.

> Then why not submit it as part of the "new work" patch series?  That's
> how dependancies are normally handled.

> thanks,

> greg k-h
