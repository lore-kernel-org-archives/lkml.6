Return-Path: <jan.kiszka@siemens.com>
X-Google-Smtp-Source: AIpwx493M++y/OP75zsTi1LZiep92aKFD3OQVHT2gG5z3Dg7U45XznGnAFUDD7q6gLkDjzEN/jAr
ARC-Seal: i=1; a=rsa-sha256; t=1524466345; cv=none;
        d=google.com; s=arc-20160816;
        b=aXA3J6lLERP/BDgQ9mNaQBWc+vdiozdUQuoq7vO84aZz+6HmXw/b67GbwrDAfrIIDO
         7Hc0StTAlfcURF6kbRhuhj5dzTGmyzpxnub1eM4ZqUw0Th+/7TP9GW4TuvjlYt938GJ+
         jvtasatUJXuIJGyu5f7TJ/0y4f4QBD1omYmlPEeetL/uUhslglvf8tgeUi0v1XGGJmq9
         fTzhdvU/LM+m3JX4xNauVWOIv3zkSERuWUlbzmd01s0zCvuKF2ZA+5YPzZdf+9Tu6ZHE
         Hmow1TxspJyg/D5lIwMO7nhuqfU+BrqYXYhOHRfb2lMB6gAa4dXZb3ppy7cdr52lOUyj
         a5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:openpgp:from:references:cc:to:subject
         :arc-authentication-results;
        bh=R9dIe6OWRP9qj136eCHAnYAP7rnTur5HeYQgCwWHK0c=;
        b=GdlV7o8pAHvFgKV2XC+Z6DH+vnwcp/doRmXMzSI8rgDJ550eE5b+GgjFUwsplgH9l4
         53p/tceHO5XCYGcUf8OvF4JnTud/6HdvM7VGg93MZZn0/E9DB18jwqizEOfKFbbnSyTW
         Ta+AYobQXxjtVDzRh0ELzkrF2KhJwrntcBnLx7MfsCkjWQMIwD1Ll13+dloRMvm3aILO
         j2BTm3UAr6Qx3n4VvfrnNdznQgCEBPpR+JlH6PepYzahh2xECU9BcnCOYp7ianz9I7c6
         WUtSgZ76LMEjvazwiuWwvFHvhnKnRBbWvhwhqAess8Xjdopj6U4WgPugbbtYt8e43aIf
         HpKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jan.kiszka@siemens.com designates 192.35.17.28 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jan.kiszka@siemens.com designates 192.35.17.28 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com
Subject: Re: [patch 1/9] x86/jailhouse: Fix incorrect SPDX identifier
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20180422220208.772527041@linutronix.de>
 <20180422220832.815346488@linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Openpgp: preference=signencrypt
Message-ID: <d5b626d3-ebfe-b63d-86e0-9a396169ee5d@siemens.com>
Date: Mon, 23 Apr 2018 08:52:19 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20180422220832.815346488@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486095183282307?=
X-GMAIL-MSGID: =?utf-8?q?1598518822796289659?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-23 00:02, Thomas Gleixner wrote:
> GPL2.0 is not a valid SPDX identiier. Replace it with GPL-2.0.
> 
> Fixes: 4a362601baa6 ("x86/jailhouse: Add infrastructure for running in non-root cell")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/x86/include/asm/jailhouse_para.h |    2 +-
>  arch/x86/kernel/jailhouse.c           |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/include/asm/jailhouse_para.h
> +++ b/arch/x86/include/asm/jailhouse_para.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 */
>  
>  /*
>   * Jailhouse paravirt detection
> --- a/arch/x86/kernel/jailhouse.c
> +++ b/arch/x86/kernel/jailhouse.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL2.0
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Jailhouse paravirt_ops implementation
>   *
> 
> 

Acked-by: Jan Kiszka <jan.kiszka@siemens.com>

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
