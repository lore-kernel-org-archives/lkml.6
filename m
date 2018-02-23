Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AH8x224CDOUtSIe0DFax+D8c8faY0nmhmF4SEJ3vdvhcceAaK79bCRlVlZp6vuFYLY6I2yzyd/7J
ARC-Seal: i=1; a=rsa-sha256; t=1519399129; cv=none;
        d=google.com; s=arc-20160816;
        b=IL1buDtoYJewRbeooC7AAHuOvCL7K8l+ZkCfA8UUwFsgczBCXzfxpQSgHZrH6y2UBx
         u1Blb+loLs57X5h/P6oqKjW1uhKz5pYP/gLzPUeks9Fqi7SaMKQwkFPQtZfn1PjYfqk1
         ixDlDSc7AGmsR3uGql4ztOGsTHvBvOD40qrmYqtiewOYCtX86V7WKA037UyLLrgYiVx/
         DYMj8GVXwIj3mNsubxRsgRShayGjnay46xrxhjyvjZRpRxunnE4XqzU2/LYpHCnFQMZR
         oSpfU8lV0DC66FFLzD4fiRfjETwdiEAOuDtvDJSztCc5LsWn5RuDewpsK1sakj6Ffipx
         56FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=kNwHT6nO1RsNQrqym/0l5gfONifMT34KRtCawKQgcMo=;
        b=YFwCQIsS58zgQzlEUy5MP2oKu/ZU53TGpQHKWzZ0MMJp0iBRJSSgSk+VUN//oN2vgM
         VYDHeTE9kfA2m/EM4cCViqEetE9bZfYJccQ7tnZe8pCxYWsd1jchP6OfpdUlep4vjlzV
         tYN1LkDKVsb/CQaWuSYrW8gf7SuKXRSjy+rBoMY2EmtbGdVNauall7UvXpwNxYLIsqnW
         C6r1QjFO8HiyMC3tbDITfOwyVZLMh2505nJB0lTkB0uEE1Y0Nb3nEyNoXkzUuOUkgNF/
         cugc1fuyYxUYZrb9+X103EjyTmNvipX6RknFnzb9WDgEQEbc21JfwYDUo2yq7Z55LiFI
         6nhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Fri, 23 Feb 2018 08:18:48 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH
 <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v5] Documentation/ABI: update infiniband sysfs
 interfaces
Message-ID: <20180223081848.5c974009@lwn.net>
In-Reply-To: <20180210074104.GA3160@mordor.localdomain>
References: <20180210074104.GA3160@mordor.localdomain>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591998650635035491?=
X-GMAIL-MSGID: =?utf-8?q?1593205462134281093?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 10 Feb 2018 13:11:04 +0530
Aishwarya Pant <aishpant@gmail.com> wrote:

> Add documentation for core and hardware specific infiniband interfaces.
> The descriptions have been collected from git commit logs, reading
> through code and data sheets. Some drivers have incomplete doc and are
> annotated with the comment '[to be documented]'.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> Reviewed-by: Hal Rosenstock <hal@mellanox.com>

Applied to the docs tree, thanks.

jon
