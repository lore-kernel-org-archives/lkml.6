Return-Path: <julia.lawall@lip6.fr>
X-Google-Smtp-Source: AG47ELt95hh/wTv6/9/Lf7a55j5lhPvq8LIQOifqttpCq9zYpWAEDLHSSyaQcJejJGwUAdCnxT4A
ARC-Seal: i=1; a=rsa-sha256; t=1520062366; cv=none;
        d=google.com; s=arc-20160816;
        b=WvnHC5bM6c5rUfbTZV7dO2jOPZ3mjYQk+9nLeD76OB3vVP1ewWRSy1wEzoDgLBZXw+
         tKNKz0WjHqtN5WjrfPR7knYrRSPiy+x5czUUVVqgIgZWjVgnlUbslBK+Oz3KgeLg00oC
         Frcxwuf7VkTmHq66eIfJ6G9m7eYq16WcysYF9SHrV9GJ6Ci1O6zp8BnhpzoVmLGe9Z/J
         UXIP3aHOcW+I7lHs17O48IHWSa3tRrMgbc22C/PX1iz7EPvZoLSyJb/4qyBYCMMcxlkT
         EGVdMEk2ECtYEos20Je55I6mXojbIsF1+FGqEvT2lzh+6p0a2B6rLkNNMpxRHAQFE8wD
         wmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=l6Z/yJMNl8yecmM1RBGvJkVs/bgCp0aRotisbteUC/A=;
        b=FNdehThneX8htxD4iJ+Filgt2DQf+UU6zPRtckwyDrrhJ+E+Cpz/BHxE4K5Z6NG+DQ
         ajgQWXNyNV9J6hHQRbFCgN3m/8TT9IKdwrlTgOQsTl1pJZ7L+ARCnY4zo+U55Jo90PqR
         K6l3SkeeF5DomLhCgQTsj7l7qnilDvOO8UJNPWW1cqurn4g+gjjl6I3T3oVVYXwoxUUF
         zGR9zvBzJctoUYqWo1YpZCqeXsJn2CFciruCc/lVq9uE4NucTAu9e/bh/PxzBPiEuoSa
         6Fe3d+X3LQICkbnaPxXOIOE3XTuL1XSXJyHeyGxHCMZbqbeUMTQjGZNMRV9rCV6fRwlo
         M6aA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
X-IronPort-AV: E=Sophos;i="5.47,416,1515452400";
   d="scan'208";a="316179593"
Date: Sat, 3 Mar 2018 08:32:45 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
cc: outreachy-kernel@googlegroups.com, Larry.Finger@lwfinger.net,
    florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
    devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2 0/6] staging: rtl8712: fix coding
 style issues
In-Reply-To: <1520055156-8388-1-git-send-email-arushisinghal19971997@gmail.com>
Message-ID: <alpine.DEB.2.20.1803030832091.3191@hadrien>
References: <1520055156-8388-1-git-send-email-arushisinghal19971997@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593863817188293210?=
X-GMAIL-MSGID: =?utf-8?q?1593900916142997643?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Sat, 3 Mar 2018, Arushi Singhal wrote:

> Fix issues found with checkpatch.pl to conform to the Linux
> kernel coding style.

For the series:

Acked-by: Julia Lawall <julia.lawall@lip6.fr>


>
> Changes in v2:
> * From and Signed-off emails were not same in v1.
> * Added detailed commit message
>
> Arushi Singhal (6):
>   staging: rtl8712: Fixed 'tabstop' coding style warning
>   staging: rtl8712: match alignment with open parenthesis
>   staging: rtl8712: Remove multiple blank line(s)
>   staging: rtl8712: Added spaces around '+'
>   staging: rtl8712: Add spaces around '|'
>   staging: rtl8712: remove unnecessary parentheses
>
>  drivers/staging/rtl8712/drv_types.h                |  2 +-
>  drivers/staging/rtl8712/mlme_linux.c               |  2 +-
>  drivers/staging/rtl8712/os_intfs.c                 |  3 +-
>  drivers/staging/rtl8712/recv_linux.c               |  4 +-
>  drivers/staging/rtl8712/rtl8712_bitdef.h           |  1 -
>  drivers/staging/rtl8712/rtl8712_cmd.c              |  8 +--
>  drivers/staging/rtl8712/rtl8712_cmd.h              |  4 +-
>  drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h   |  2 +-
>  drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h   |  2 -
>  drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h |  1 -
>  drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h |  2 -
>  drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h  |  1 -
>  drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h  |  2 -
>  drivers/staging/rtl8712/rtl8712_gp_bitdef.h        |  2 +-
>  drivers/staging/rtl8712/rtl8712_gp_regdef.h        |  1 -
>  drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h |  1 -
>  drivers/staging/rtl8712/rtl8712_led.c              | 70 +++++++++++-----------
>  17 files changed, 48 insertions(+), 60 deletions(-)
>
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1520055156-8388-1-git-send-email-arushisinghal19971997%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
