Return-Path: <gauravdhingra.gxyd@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522912652; cv=none;
        d=google.com; s=arc-20160816;
        b=QLRwYH1UURVJIHRfsyFvsExNUgskX+4jb9cw85uFoaiAa+O96Ng3s23qx8sArCjToE
         zUEHxiNsp9BJSehLvkLq1EcbuE5Tm+mk9fSsncLhylwLEi/6/Rtf+LkqMybb0Kb2JQ5m
         Zzh3UCZp/ZobNY0D7OMpmGyRYMUPq09JfGgBCnBnKyKBvVGJuBojbDv6VmkAFOIQ+Y7r
         5k9vTkB8mA1JfNG4o0qDWbI/ufzpzwjXApgfUjKm2cWnqqcLdAgmUBlfRSQgo/LY2SX5
         zihZ27lyvWCmds06qS9mgbDyOUClxx0pFzPEmrZhI24OMEGPFo6lRkRevYDc8dmmKCIR
         qweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :dkim-signature:arc-authentication-results;
        bh=eNaoMGqmbGXwtUpWRqC1+LeiG39FjqllL5PIUyqBmDg=;
        b=sKnU4GUbpld+O3rlt5Pwrn+eCJ0imnccK6jEDsGsvN6lxrIBR6+dmKUmUZttr+zCAr
         P8dXUB9+rveGrQjDKLIbZ8KdJahLY1Dp4Dy295PUqlBlMhfV4gyb880l4muJyM4nqmrG
         4tZArDw2gsJ9uHnZDINzLM498bLUh3RTtCOYnG7V5+16HdhUoqZyk9bMQsFMCRVDg6XH
         O6saKLkqxDGyW3cxcTl1kHry0JYV8NuHGtOPruEFWd/4tR7JVAO472lkYXyplaoJW8/I
         5HBBwzIt1pJmSUjO8vY2HBEiCAAH3Z8ayyml2qW2DiNmCTqOmBvgP72mqv9KLJ+evZj2
         oOEg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Fku+MLHU;
       spf=pass (google.com: domain of gauravdhingra.gxyd@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=gauravdhingra.gxyd@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Fku+MLHU;
       spf=pass (google.com: domain of gauravdhingra.gxyd@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=gauravdhingra.gxyd@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/Qm72ASDTckoAup1ooZLTNt93Va/TJfY59+Rj8Z6XFiXMycnRC2Fpin7ovA/evxL7Cj7LNww==
Subject: Re: [PATCH] staging: greybus: Fix warning to limit chars per line
From: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
To: mgreer@animalcreek.com, johan@kernel.org, elder@kernel.org,
 gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
References: <20180403183246.GA23438@stallman>
Message-ID: <9c77723c-dc3f-2a86-b7f3-be3b751fdfe2@gmail.com>
Date: Thu, 5 Apr 2018 12:47:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403183246.GA23438@stallman>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596750959468280779?=
X-GMAIL-MSGID: =?utf-8?q?1596889656969410321?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Can anyone please review this patchset? Since this is my first patch 
set, so I felt it was okay to make change even in the comment, though 
the patch set fixes the warning. Please let me know in anycase your view 
on the patchset.


On Wednesday 04 April 2018 12:02 AM, Gaurav Dhingra wrote:
> Wrap comment to fix warning "prefer a maximum 75 chars per line"
>
> Signed-off-by: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
> ---
>   drivers/staging/greybus/audio_codec.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
> index a1d5440..01838d9 100644
> --- a/drivers/staging/greybus/audio_codec.h
> +++ b/drivers/staging/greybus/audio_codec.h
> @@ -23,7 +23,9 @@ enum {
>   	NUM_CODEC_DAIS,
>   };
>   
> -/* device_type should be same as defined in audio.h (Android media layer) */
> +/* device_type should be same as defined in audio.h
> + * (Android media layer)
> + */
>   enum {
>   	GBAUDIO_DEVICE_NONE                     = 0x0,
>   	/* reserved bits */

-- 
Gaurav Dhingra
(sent from Thunderbird email client)
