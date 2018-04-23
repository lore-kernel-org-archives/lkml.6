Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx4+gyBqhzHelebsAv1noI/x3NPcnA2iNgs2wPqsOK8DlX0PQh4+Uu9uDBFCbaId2a9G+uV/a
ARC-Seal: i=1; a=rsa-sha256; t=1524469517; cv=none;
        d=google.com; s=arc-20160816;
        b=FobP5gBpVW6VSZZpH71VPHMIx4Pnzf+z87X0x+CfSEN2Kg6/ESZTPdQ8wLDZgfJgRx
         vtxWfAW6LWJJNJPzPI2/N15HoUdugKkHN5ffZpfKW527aOKoko3IniwM9Yo0kigA3UeU
         ZSqir3JuGiH6sgaObEBP6DdibYQskG6GKcnTF0OHmVATTHI5jpU29j/8ziDQvxaxa2sI
         oFYr6Ef6XlvRmJdxWhcgJkY+lmuqDZxboCrFrDzzgawqn3dZs+1PPmQIt52+bq3/cNOq
         YZrL9z679JOBKQQ7oUZ7Gl+l+epouNXxRwkVs/sVrutq/ZC9pp5/+rmbefyaVRznJ7pl
         JlTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=ljVNxXQKNvRxSH7ROgLkqAKgq7hy0fyfTKsXzpcRhgM=;
        b=Lj/1EqxXzJlr1Vdo8A5ewYGrTWCnfgLH+LRiVy3jgTLC+91x5s9vwUI62XEpkPkWPk
         BDDNHrDpVOk17dO9bSzCgrlV418oxWymq9y8ON80/4+tn0a6SPtvev+weGSt+0p9GXRU
         0tu35645jIo41iN7kfZ+xA8Y4aGj4H4Htp4Fmyw/MppO2EjUcVWjhy7ziZF7yleX9eik
         lWZpFwUYkYXSPM/nPWvFoxz8MGEO15ptn0bQDMq9fV6a/MAuSq1DJeEYJSqVd00oh3pw
         uiIKa9bng6va/SV/gkUqyx39silGmVyz6W5IXTvnsHaAD5KOjp8/4ufhKQOVtzbu/FGf
         aK0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Mon, 23 Apr 2018 09:45:10 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Yixun Lan <yixun.lan@amlogic.com>
cc: Philipp Zabel <p.zabel@pengutronix.de>,
    Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
    Neil Armstrong <narmstrong@baylibre.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Kate Stewart <kstewart@linuxfoundation.org>,
    linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: reset: fix invalid SPDX license
 identifier
In-Reply-To: <20180423152907.5113-1-yixun.lan@amlogic.com>
Message-ID: <alpine.DEB.2.21.1804230939350.6136@nanos.tec.linutronix.de>
References: <20180423152907.5113-1-yixun.lan@amlogic.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598521231346509320?=
X-GMAIL-MSGID: =?utf-8?q?1598522148343064132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 23 Apr 2018, Yixun Lan wrote:

> This fix invalid SPDX license indentifier, also move it to
> first top line according to documentation.
> 
> Link: https://lkml.org/lkml/2018/4/22/713

Please do not use lkml.org links. lkml.org is not always usable. Use;

 https://lkml.kernel.org/r/$MESSAGE-ID

instead. So this would be

 https://lkml.kernel.org/r/alpine.DEB.2.21.1804222108120.6136@nanos.tec.linutronix.de

The reason is that kernel.org is very likely there as long as the kernel
exists, but random archives can vanish, change their URL, etc. The above
address is a redirector to the marc archive, but if that vanishes or stops
working the redirector can point to some other working archive.

> Fixes: c16292578ffa ("dt-bindings: reset: Add bindings for the Meson-AXG SoC Reset Controller")
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  include/dt-bindings/reset/amlogic,meson-axg-reset.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/dt-bindings/reset/amlogic,meson-axg-reset.h b/include/dt-bindings/reset/amlogic,meson-axg-reset.h
> index ad6f55dabd6d..4a8e52f68fb7 100644
> --- a/include/dt-bindings/reset/amlogic,meson-axg-reset.h
> +++ b/include/dt-bindings/reset/amlogic,meson-axg-reset.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
