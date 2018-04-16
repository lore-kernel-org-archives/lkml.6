Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523917038; cv=none;
        d=google.com; s=arc-20160816;
        b=YiWSipTETpDlBTviKBD/kYCbX62589cGthfarga4eXUsEYNhH8BW12T9GuYF5Npo0O
         Rs6bhxutelmztfg/IRud4I2UBm5jk9KhEKhGp07KV/ibQdiqOm++KwO6Lq9kTypy05mm
         NPI4hQCN1fhJ2Czes2cZ/lZdOygwR2rDAoz0KvCDpIkMqZ0rDte7Ulj9ayUe5rMzhWka
         8872ewbWSkaQMF5O/rc8MHmKFTMWZ5ZyfG/8vlg0Stzd4rz+TcN7fK9AplG56LSYDDUV
         nS7oiPF85SsEmVS9/JR+pT3UuBRVidx5kuJzuIpFdwxHBcWXrD4L2tiUj0fcyFPg2IFb
         Vu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=sa07YDK+QNTOqdRoc5XwMhxRnSdsVJagGCT44/9DjOQ=;
        b=OiY9S+fxSLVPmk9Xgjgp6yWs8YyP/F2K6zi2oz8AWZHFCTpUfFKPXcDjZWr4Vn14be
         D4kirk7gJyHCiglONNbEeGtsRbCcJlvNd03xEYJ+OjNagSNxhqoWwMTxyisQhvJ64noz
         fjL1XMbSy3/M+EL1yljmR1QjuhQgYMV6hUH5/A4yVGmeQnjkiMjA4L7gustsMFv/R5hN
         P6TjKe71xcpPKncRv1/7+LXWOX1YloNquwe747g0K70tiZNvaQrz3fMyL3L3iIjZXmxM
         TdgyteI1DDx+vCgQM1zMZANxs5qImR0GgSV/FKczXOJBWgVR8erEqyVjSg1USUeWwh6P
         AwuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RmBknx6I;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RmBknx6I;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+YyzkuET54+I+YX1Ta4ZU6eE6KEkuwZPff0UNDAqbop9HMd5LsjwRqtmyD4HkVcJ6dHvjg4g==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org
Cc: Doug Berger <opendmb@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Brian Norris <computersforpeace@gmail.com>,
	Gregory Fong <gregory.0xf0@gmail.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] ARM: Allow this header to be included by assembly files
Date: Mon, 16 Apr 2018 15:17:13 -0700
Message-Id: <20180416221713.31685-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223210923.544-2-f.fainelli@gmail.com>
References: <20180223210923.544-1-f.fainelli@gmail.com> <20180223210923.544-2-f.fainelli@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593227540099720483?=
X-GMAIL-MSGID: =?utf-8?q?1597942831940592138?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Feb 2018 13:09:20 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> The constants defined in this file are equally useful in assembly and C
> source files. The arm64 architecture version of this file allows
> inclusion in both assembly and C source files, so this this commit adds
> that capability to the arm architecture version so that the constants
> don't need to be defined in multiple places.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to soc/next, thanks!
--
Florian
