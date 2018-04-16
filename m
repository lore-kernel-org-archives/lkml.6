Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523917050; cv=none;
        d=google.com; s=arc-20160816;
        b=QM0AKpPNj0IAgsHJefm9rA8WYtBYX5B8aD3EzjS7qdXOZC+5X3j1cNic8/PU5XUsie
         r+aeCdGB4TNpFcQvLt7Hr3jBJGH9KuAZjndaRv2t/fvzF6tNeWE0JexNI388eWZvIaqs
         X0dDYehelhE7A62u7cynGzR/3svjkUsMiVZoEZNhD9fOSYf19YWKvfzOuyLmAuYeqXCA
         4kk90L0k6390P2PWEZVrPzZuZS54QLSMOkX9/KHGjovr9asRDZLzMl69jMHw/4KwL4dK
         s9CxzSwCfPO4BH55SMsaHUrktUTycoaJ/aTn+vd7nFQRO7skPrPOHtj7IGnyp+smp6ue
         qBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=ViP5kcd6tkt/yiapUNXKTrAScVp5Xyi//Q1dewEoPqQ=;
        b=yCoxmbjxn5WahQppO6ee+7rX/VCZ89N+A7MrtgIYx/LFtxJ66A3hon9QtGQjfKElue
         Gy4CJf8iRCiXUdhk6fC5ictNzAjQ1m7/SpZRs6UWck+P6W/YyHkTKZBHRlXVNh3PhyzS
         XPAQJA01oOIAW59f4fzs9MCHnMhr+Ce9JjphAKlfwxowsy1jLC+dYaf2wf7pIIzqmdlg
         X6qmjIgNr6ZC6sAlDRn2jTzWWNygqQmpwIaMO3J90FSr2J7NqXrPv9uhrZYEf3HrKXG6
         hBpS7f8PLLrCxXMMRkRX1WjQwpkmmBqSvlLOcAgmE0ltw63SIauX3sjmeYPpSNh7oWmv
         0TDw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mhAkTy9W;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mhAkTy9W;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/Q8IInwlj3ZUSPNztiybDblIHWelktfz2N5/AolebTFD5FOGWQONfqK8AMbph/0e1ZSNGhfQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@armlinux.org.uk>,
	Brian Norris <computersforpeace@gmail.com>,
	Gregory Fong <gregory.0xf0@gmail.com>,
	Doug Berger <opendmb@gmail.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] ARM: add Broadcom Brahma-B15 main ID definition
Date: Mon, 16 Apr 2018 15:17:27 -0700
Message-Id: <20180416221727.31865-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223210923.544-4-f.fainelli@gmail.com>
References: <20180223210923.544-1-f.fainelli@gmail.com> <20180223210923.544-4-f.fainelli@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593227545564810581?=
X-GMAIL-MSGID: =?utf-8?q?1597942844935460504?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Feb 2018 13:09:22 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Define Broadcom's Brahma-B15 main ID register value, masked with
> ARM_CPU_PART_MASK.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to soc/next, thanks!
--
Florian
