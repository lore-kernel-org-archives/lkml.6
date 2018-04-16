Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523914652; cv=none;
        d=google.com; s=arc-20160816;
        b=ly+e9zwd51s2U6U1dkSwXuhW6gRhndztb7YjfRKFqNQVX/Y5qYYtd6LHEd4ogcc/9D
         PJveHXihzjJ3XtKIZewAPaj8fqBajxYnawqjFFjEyt1Hs3NJ9N88o6AjyEus49B9g03Q
         QxVzLYI4BT6f4b50CKuReHLEQ/4ihzaqgkSs17JtlYLJ7Ms312W77IhYNZiF8tCOpQhN
         IRd/XqUQcHjtZZSS4StzUfKoDv8BmBmewMmsg6Q+zh/I2iDMw1PD0NwPMxlEceE1FYSh
         r7HKOQLOX1hsaoQyla6PwwgXhxSaAikT0DQjqdO58oTsA4GLnd4LRXloI2de8+A0jeST
         kPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=thzgAcuOSPcn2D66FarmItz2irCXbw0nh4naDns6Nlo=;
        b=PY9QBGNZZMnCEBnYL0nct+aJ+LC+SUqWZjk8HxFDeqjut200csBYYrvlcvlbPBWo0m
         lABxK395p76pzjtQ6M57SPQNk8kgQPhwZ0ejnXzYyf+S8/O9IOWUiDyb+tEr5ze04gw6
         fbZ1WKZ8sGT9LgAc5BmhHm8lJnUXkQZ2sm8xmPW7ZLC3RGOva/qsTEVw9gxl+h84GgeE
         YbJwtxTg7wVfBdF29SdMGf8G7ZDdHuHK3DOpS7l1mSxk6TyadvkfnR9wiLncMsziNtAN
         xKMoAJFfVClE6qtLg7IEnynUsI25WPWcFYxSnBzWEEEP48cldma1whNmZlyIb3N7qWWJ
         BdDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx4+hu1MsS7xjMwlKVpEUaxzQ0QFWGoT0G8ZQb/xsfmJFRHhEi2DFnN9N8dBlAJl5OYzJDAiwiw==
Date: Mon, 16 Apr 2018 16:37:30 -0500
From: Rob Herring <robh@kernel.org>
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
	phil.edworthy@renesas.com, buserror+upstream@gmail.com,
	Mark Rutland <mark.rutland@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Carlo Caione <carlo@endlessm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajendra Nayak <rnayak@codeaurora.org>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Frank Rowand <frank.rowand@sony.com>,
	Juri Lelli <juri.lelli@arm.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 1/3] dt-bindings: cpu: Add Renesas RZ/N1D SMP enable method.
Message-ID: <20180416213730.isfggqngv6zjxahg@rob-hp-laptop>
References: <1523871304-48517-1-git-send-email-michel.pollet@bp.renesas.com>
 <1523871304-48517-3-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523871304-48517-3-git-send-email-michel.pollet@bp.renesas.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597895187404291878?=
X-GMAIL-MSGID: =?utf-8?q?1597940330405074920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 10:34:57AM +0100, Michel Pollet wrote:
> Add a special enable method for second CA8 of the Renesas RZ/N1D
> (R9A06G032).
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
