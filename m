Return-Path: <mchehab+samsung@kernel.org>
X-Google-Smtp-Source: AB8JxZrWmxlhxyZpF+78Qs/oo9lZp5esIWYQ97xw4uW/OSMPc4/1WxdVooDdewfEarrU/R2gMxxl
ARC-Seal: i=1; a=rsa-sha256; t=1525878757; cv=none;
        d=google.com; s=arc-20160816;
        b=Nbl3rFIaSrpKK9F6WqnM4lKR3Bq329T3sZtm9n/T5DWbgVp6UlAXgDkyoVhvpXHLyC
         d3nDyVAcDa7lDsatY+H70Acbm+4gGFXK7Ou6sS8gTPrAL+wD9K6YckZkhmehSq5E7/Ih
         HsSTKEZ8YYCEVSq9KWTSXoz7cFXX37JpZdD6Af7Xu68DhrB39Tru5ohbFQAMQ2xdnYwi
         Y8Xz5AD4YPObJ+Ktxwju0nNCRNFvUq+xW6M2cjEiSEjt3O2hKdZ9iMVwu+HCS8xZWQnI
         IYEK0+5Aq5flh5znyfVOtdHnnPJHuOzejHCf+fDMxhYJl8f08kALZ4344IcB+rPr3+lJ
         LIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=MiuNJt5kNv7k7oSvARSQ/FZynPxbh30E2UNuuAAUdvQ=;
        b=k30fBnTpCiHOj66XjIM8iVEODMfpKA705NbqwFin5H2sex30L7NvVWseM4UugOSV7p
         6Hc59sr1+Ygr12kDgIHhz4HjOY/5r+ptm+1IUmSvvQQxSggy2iL7NGRT7UigneV6toHg
         1QjInpkvD9EV5vzTUP6ioZ8dRcmUDHohNtT5H9ZGuyE5KJYm28++Z7BvU8VbLjqjZWsS
         XAC05S2NRI300m9zIqaVjx1SAylZHwWxN4hx/MDLNlrVKfFIDbc5G2XIjLNeATou8RTr
         sEQ0RFAMgZnq61J8E8ODS68N6Z87MOwoE87WcIQQ2WMeTNYJC8iYHaQfp8t2Kyvbqp+Z
         L5Dg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=XWfW3xL6;
       spf=softfail (google.com: domain of transitioning mchehab+samsung@kernel.org does not designate 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=mchehab+samsung@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=XWfW3xL6;
       spf=softfail (google.com: domain of transitioning mchehab+samsung@kernel.org does not designate 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=mchehab+samsung@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 9 May 2018 12:12:09 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 keescook@chromium.org, josh@joshtriplett.org, maco@android.com,
 andy.gross@linaro.org, david.brown@linaro.org, bjorn.andersson@linaro.org,
 teg@jklm.no, wagi@monom.org, hdegoede@redhat.com, andresx7@gmail.com,
 zohar@linux.vnet.ibm.com, kubakici@wp.pl, shuah@kernel.org,
 mfuzzey@parkeon.com, dhowells@redhat.com, pali.rohar@gmail.com,
 tiwai@suse.de, kvalo@codeaurora.org, arend.vanspriel@broadcom.com,
 zajec5@gmail.com, nbroeking@me.com, markivx@codeaurora.org,
 broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
 torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
 jewalt@lgsinnovations.com, oneukum@suse.com, cantabile.desu@gmail.com,
 ast@fb.com, hare@suse.com, jejb@linux.vnet.ibm.com,
 martin.petersen@oracle.com, khc@pm.waw.pl, davem@davemloft.net,
 arve@android.com, tkjos@android.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v6 12/13] Documentation: remove stale firmware API
 reference
Message-ID: <20180509121209.1e332f63@vento.lan>
In-Reply-To: <20180508181247.19431-13-mcgrof@kernel.org>
References: <20180508181247.19431-1-mcgrof@kernel.org>
	<20180508181247.19431-13-mcgrof@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599920606656661836?=
X-GMAIL-MSGID: =?utf-8?q?1599999843643065139?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Tue,  8 May 2018 11:12:46 -0700
"Luis R. Rodriguez" <mcgrof@kernel.org> escreveu:

> It refers to a pending patch, but this was merged eons ago.

Didn't know that such patch was already merged. Great!

Regards,
Mauro

> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  Documentation/dell_rbu.txt | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/dell_rbu.txt b/Documentation/dell_rbu.txt
> index 0fdb6aa2704c..077fdc29a0d0 100644
> --- a/Documentation/dell_rbu.txt
> +++ b/Documentation/dell_rbu.txt
> @@ -121,9 +121,6 @@ read back the image downloaded.
>  
>  .. note::
>  
> -   This driver requires a patch for firmware_class.c which has the modified
> -   request_firmware_nowait function.
> -

>     Also after updating the BIOS image a user mode application needs to execute
>     code which sends the BIOS update request to the BIOS. So on the next reboot
>     the BIOS knows about the new image downloaded and it updates itself.

You should likely remove the "Also" here.

With that,

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Regards,
Mauro
