Return-Path: <mgreer@animalcreek.com>
X-Google-Smtp-Source: AIpwx49OJV3fqYXhOM9r5xWPe+CIgKtSAv+XLoAzQ8LmiUEnlmq4C7wC5cZtySQn7Z1bnEmu3Cw9
ARC-Seal: i=1; a=rsa-sha256; t=1522966783; cv=none;
        d=google.com; s=arc-20160816;
        b=EZ9vRhWDMT2qJuHWzlILoUFAxcYkdo4sThMlUpIsQpXOWNgTKXxNt8UKPgJ1uA9aWH
         h4TnXei2rf6fLM8NXTIS+WktRucrzilwZ0RvSLBqNLE9yUDS/m6ksngRyzGKAjFjaldk
         SAJS0Wl/weUb2GDzbKNnnxL7rpT+E+pMKqkTGjO84b1xugOpONkhUeVcFEVJbkLv5+zb
         DZhlyGDdJXNXSS1l7lm+DG1w3NJNV9XfW2Zg/ntiX+urc7ksi/5eD5Vr4yTO+lEOFJPq
         lTQJQBRl06ksaTBzabSV49+1fu6Z7ug/1YM1BAJ6WyR2ZmxDftfq4Fz141/d99vRU94W
         dNUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=o6SD9NkUWbUNqTymfU6SUYyWOdEDJfYoQ3UidPf+fnw=;
        b=Vzrbjd9RpR58i7YGG7O3L0wA7AjSsXTB4Z99B6HUQ0eH3vbXxXYZvfa7ZK/K/vgIN4
         IovMNnz7j/lm0Nl16P77Fb3JK146YG9he1+Cb4G3euNplzHdrHBm+JkDt8KPr4KXV7xs
         mEVHB/iGE6jdmbuGTgDEPc6gtXXKftn87m7t/h+oMoePLj/KR8wtfXYnY1Y8ZvGxEFBa
         J8kVt9zUyKuXZ5NY90s9PGBCY4KsdduxFVerx7W/wdRhJPAm6/qiDAT+SstUd2HcrlNK
         UjFOF6QnHvg6d3NNRzxwT+sb5ftsc1E1f/jW9x2CQl4JWhV36mvAJL+iOV2X6+yZzk56
         d9qA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=temperror (no key for signature) header.i=@animalcreek.com header.s=mesmtp header.b=X5afWQsA;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Mp2RkrwB;
       spf=neutral (google.com: 66.111.4.29 is neither permitted nor denied by best guess record for domain of mgreer@animalcreek.com) smtp.mailfrom=mgreer@animalcreek.com
Authentication-Results: mx.google.com;
       dkim=temperror (no key for signature) header.i=@animalcreek.com header.s=mesmtp header.b=X5afWQsA;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Mp2RkrwB;
       spf=neutral (google.com: 66.111.4.29 is neither permitted nor denied by best guess record for domain of mgreer@animalcreek.com) smtp.mailfrom=mgreer@animalcreek.com
X-ME-Sender: <xms:_qDGWpJvQldd-fot88hirL6u718_VlQ9jgrg6l3ge2SXFjkm40HmgQ>
Date: Thu, 5 Apr 2018 15:19:41 -0700
From: Mark Greer <mgreer@animalcreek.com>
To: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
Cc: mgreer@animalcreek.com, johan@kernel.org, elder@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Fix warning to limit chars per line
Message-ID: <20180405221941.GA21308@animalcreek.com>
References: <20180403183246.GA23438@stallman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403183246.GA23438@stallman>
Organization: Animal Creek Technologies, Inc.
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596750959468280779?=
X-GMAIL-MSGID: =?utf-8?q?1596946418209740289?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 12:02:46AM +0530, Gaurav Dhingra wrote:
> Wrap comment to fix warning "prefer a maximum 75 chars per line"
> 
> Signed-off-by: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
> ---
>  drivers/staging/greybus/audio_codec.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
> index a1d5440..01838d9 100644
> --- a/drivers/staging/greybus/audio_codec.h
> +++ b/drivers/staging/greybus/audio_codec.h
> @@ -23,7 +23,9 @@ enum {
>  	NUM_CODEC_DAIS,
>  };
>  
> -/* device_type should be same as defined in audio.h (Android media layer) */
> +/* device_type should be same as defined in audio.h
> + * (Android media layer)
> + */
>  enum {
>  	GBAUDIO_DEVICE_NONE                     = 0x0,
>  	/* reserved bits */
> -- 
> 1.9.1

Hi Gaurav.

Thank you for the patch, it looks fine to me.

Reviewed-by: Mark Greer <mgreer@animalcreek.com>
