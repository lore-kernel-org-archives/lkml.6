Return-Path: <jikos@kernel.org>
X-Google-Smtp-Source: AG47ELsN/Cs+3bjbVYcYGRZZKCL3mRshc9QuB7REPv72k654GlPLrlg6ahnY5ujwse29NVqT2jGa
ARC-Seal: i=1; a=rsa-sha256; t=1520433987; cv=none;
        d=google.com; s=arc-20160816;
        b=NF39bK3yrAvMRAumGNpSYuhkw+miJeRz1WOk3wgC4/SGpWInBRTPIqRvpr+2Wsj0Gm
         rM6fno9ggQLd1UCXWR1sIHg8tgXABXUaZdCkM8CBgLWXm3jMV5vOCKwnZGmDI/jJ9lI6
         w+uxnuCNjWKMBafqcyi2McJ5z6wEDE7qhcYS9Yai7KE1v4ceYMeqx5rVMNdDzJTpkdfS
         iLToAMxWOnZDXegEyD+mss5jOPF57ig6YviZCUPhs7+ya4AMY0HXwhZ2zpOXIuEoIjJc
         WFQHEeS897hOWU82P1Or+4eL4EdHuIuilTzwBMkvBZ/Bu83eCWXspz/VwCXITx8Je5L2
         Ycyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=S3km4jM2ogoo+fshVYOtmwyTilXUoy1q47zo5I7CGW0=;
        b=hVpLTsGV94duZVw5Wr4XfIXF+T/hJLTPkZBDBEo+wfpOR1kWKbFn5TVf1IJSDfkmaU
         EOwPfyqbbYpk2X2/dhUG7NLYXVjYYAg1zJY2SXQQRdTLWFwsP8M/nzS3JXAwGIcFs5x0
         kBeVGvrK5Q7jpywjm++PgxkQbW/ouDcKOtG9d17CvvZv1vTOcci3l5YHNMojVumMqy8I
         OvIS5WY4MBH2pG38KekqzttkpRPgwzzkQHmPrg66STtN4gVKKtOObW9TFg/xiqTwRylm
         jEhoZBsO7NoJVy39Do3PXaFspwgITpF+W0W/g6FtA3VvTE6brU6YfYRmzCMLOkXK4hGZ
         tMOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of jikos@kernel.org) smtp.mailfrom=jikos@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of jikos@kernel.org) smtp.mailfrom=jikos@kernel.org
Date: Wed, 7 Mar 2018 15:46:25 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Aishwarya Pant <aishpant@gmail.com>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
    Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>,
    Julia Lawall <julia.lawall@lip6.fr>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] HID: ntrig: document sysfs interface
In-Reply-To: <20180302053017.GA23123@mordor.localdomain>
Message-ID: <nycvar.YFH.7.76.1803071546100.15778@cbobk.fhfr.pm>
References: <20180302053017.GA23123@mordor.localdomain>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593802620168296630?=
X-GMAIL-MSGID: =?utf-8?q?1594290588563583276?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2 Mar 2018, Aishwarya Pant wrote:

> Add sysfs documentation for N-Trig touchscreens under Documentation/ABI.
> Descriptions have been collected from code comments.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
