Return-Path: <mchehab+samsung@kernel.org>
X-Google-Smtp-Source: AB8JxZrE7kw0isq36hxHvc2xNJudGjUb/8mgvbTI0YCCri8Q4hDmq4QgnWkZz1u0znEhAIgJVAzj
ARC-Seal: i=1; a=rsa-sha256; t=1525878378; cv=none;
        d=google.com; s=arc-20160816;
        b=uazbD17ghX/hzMo9jeOoBKs33OyKiOvu6OirP72uIHUxRy1QtId6sRic+EWXKrI8MJ
         rQ3ZIy7TWXVuQ8LthIreGdvvCHcHuQg7jHY405DLZVuxZT+6GI84nXZuNIitN7TQIpFF
         ZsWmTGSILgAJJ846VRqy3/yNfFFwbkY/N9uKwxpu/ddRTGb0VcXLhN5kovclp9N+ZDV2
         9sgvbu94IQuEYhYo2l1WxA/TA5vTndquCr5ZX+F4eOIkm2usIDMYPbH6cy77r2axjWIc
         SZ78GsYgepwnz2AMbC83/xAc33vhwzOV7dQHcZik2Frfr5YVyTjPuEIIrhQrmCd01tTo
         6Pmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=mjSPY1uLIyIgTBobYpJZ7rByt1omQpe64epZ0E8/it8=;
        b=1BxDJ9g5wRPf6hmW2cbjIp0MkmTvxfg231dVlb5hUxX1tGVinKhXoowE+SCBNyGxoJ
         CLihJrs4WixIbTkNq1/rVZiZGBYBRq0gsJ6U3smjeBa58kuB1+VXeSHfapr/yo7owG9w
         9mkiNqMrCKJwW8WP26PvMs5nN6Qj9BIOrVBjLIq1q90z7Y3NpKnNRTWnRezzKsvlRmfI
         BumIqGz8FOyQtQw6lxH9YbIG/JnyRd+u8IJJIlmqtP/iP5HQYuIHFJPjAjTRfFdHWMDy
         RfTUq6QKK5QMaz9eLY19cubnCdVv89hGXWo6d64fRT8FzDA61xguKyek/J7DRxw9K0lE
         5z6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=I60ATu3d;
       spf=softfail (google.com: domain of transitioning mchehab+samsung@kernel.org does not designate 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=mchehab+samsung@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=I60ATu3d;
       spf=softfail (google.com: domain of transitioning mchehab+samsung@kernel.org does not designate 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=mchehab+samsung@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 9 May 2018 12:06:12 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Kees Cook
 <keescook@chromium.org>, "Luis R . Rodriguez" <mcgrof@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 04/11] docs: dell_rbu.txt: fix location of
 request_firmware
Message-ID: <20180509120612.6d25580a@vento.lan>
In-Reply-To: <d38353ac67cd5925bcb31bf3ee4daeb433b6e8f5.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
	<d38353ac67cd5925bcb31bf3ee4daeb433b6e8f5.1525870886.git.mchehab+samsung@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599992708616890541?=
X-GMAIL-MSGID: =?utf-8?q?1599999446854272666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Wed,  9 May 2018 10:18:47 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:

> commit 5d6d1ddd2730 ("firmware: move firmware loader into its own directory")
> and other commits renamed the old firmware_class.c file and split it
> into separate files, but documentation was not changed accordingly,
> causing Sphinx errors.
> 
> Fixes for other files were already applied but dell_rbu.txt remains
> pointing to the old location.
> 
> Fixes: 5d6d1ddd2730 ("firmware: move firmware loader into its own directory")
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/dell_rbu.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/dell_rbu.txt b/Documentation/dell_rbu.txt
> index 0fdb6aa2704c..befeff80e7ec 100644
> --- a/Documentation/dell_rbu.txt
> +++ b/Documentation/dell_rbu.txt
> @@ -121,8 +121,8 @@ read back the image downloaded.
>  
>  .. note::
>  
> -   This driver requires a patch for firmware_class.c which has the modified
> -   request_firmware_nowait function.
> +   This driver requires a patch for drivers/base/firmware_loader/main.c
> +   which has the modified request_firmware_nowait() function.

Please ignore this one. Luis send a patch updating it just removing this
comment, as it is outdated.

Regards,
Mauro
