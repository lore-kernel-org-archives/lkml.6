Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AB8JxZojB3MCgohgkfQz/TgDknsIGge5dtsB7+Wuu5a+aAmbny1xVk4hT9lV1xxYFapeTEaDYm26
ARC-Seal: i=1; a=rsa-sha256; t=1524871080; cv=none;
        d=google.com; s=arc-20160816;
        b=zqTP6qJ9JsJQI8D/7Jmh5cqreYx9ixJDwNK5iYB/5LcTMQh8Nm9fSn7yjYyoBO3DdG
         mG1Y28IXKcZqRBEtbRbpjfMbKtIf5CbK9i0QgdX41/s3CM/kQRSy5TNvUEM77oYGL6EC
         YteNYqAYEOIQl6Nr0lHUjRb8HH+G6HSGGLr5RvHp6FH0FSpsg74lGWZN+CHjr+gx8RdZ
         hDiEhF0X0u3V2uUPU0iCzP74wYQT6YTxyYNYP3e5b5N2GjqFkISV27UTTThV9CuyRXCu
         nd++EdyOMNT8XAFgabFiLEdf8K+f6KqVVbKjXCVjZt6uYzmk43XSBwmO4dVxlcofFI57
         3QzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=oA3mZ/COaDVHG+i+wfLmv/5U7YVGwyXC/rJ16gd0qnk=;
        b=TWu6v00puJgldOB2/etFCldDrQC3mkgA1BJ8F8J2fJMJSh8ahOSnq7kvHn2DOHKhjw
         1dfDslca4/2h4Z6utCx9XNnTAvmdlTU94S0pHBUm9o4sFCgkAVfQpz/SVcSInwsXwoVh
         M5Kgq9O0LNI+IPy5umgG6L379NR2/eRmGDQzOdgXYpc+Old6zD/TZEyglu/bG6LN0RkS
         CfaC44+Q5gkYkPc4IIyWUyF+Pvq+jTicLgedEfxhxcl7frChzd9wLg0HqihbwlOjq/nB
         rTftN8ETkDO5aKbZW+NI+QMX70rkLbFENTzPYQDOG0H9Q1PG9e6f2oc1IeUkUUGJ8lp/
         xzzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Fri, 27 Apr 2018 17:17:58 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] Documentation: driver-api: fix device_connection.rst
 kernel-doc error
Message-ID: <20180427171758.3c5a55be@lwn.net>
In-Reply-To: <4dcdb5c8-1365-9a0a-81be-893b0d1ea731@infradead.org>
References: <4dcdb5c8-1365-9a0a-81be-893b0d1ea731@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598860916051196881?=
X-GMAIL-MSGID: =?utf-8?q?1598943218302783616?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 26 Apr 2018 18:29:41 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Using incorrect :functions: syntax (extra space) causes an odd kernel-doc
> warning, so fix that.
> 
> Documentation/driver-api/device_connection.rst:42: ERROR: Error in "kernel-doc" directive:

Applied, thanks.

jon
