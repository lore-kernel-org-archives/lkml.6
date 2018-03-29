Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522317774; cv=none;
        d=google.com; s=arc-20160816;
        b=gNp68FQhB3K+18vCZVRWgUs+6QSQPvpJFQAUuLzaKTZeWC3WBWGzeZDYosp7bTHHOg
         PV7WFhiLxjCswu+qyuTKpayVPwxYzqwBIw2v90a4CIZ86ajP0Elv/dxHSpo9PjoqhyGS
         0UUBhT4Km+e+oF8aokum/zEf4rvOsJwo/O7oiysgjsTYSp6p6mgZ9tH2oC2aletdHHOr
         jfHsvntL+n2J1TrS+ElJ6PoANDKmDDDGCwD8sMmktJKloe9+6fXruit1+xUfuHNlsQRl
         Z9yBsXzVOXdb03zjUmkORBsoA0MV1ASUeILbJ72sOrT93kdiH2kdShvNvdEZh6GeXev3
         u1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=wMK3qv4AfPRuuXFAOIamWWMyrVwYS5NWHy2NF0x1z5k=;
        b=qMHMA1HgJLidreyzU5GyjMXiT7VPo/Xyihj78I54nzK6tnkIpArlsrUO8vskv2WwjR
         4qM7so96V46vDWYPt/tiSjSV3Flmfw7x03FUvYmtDN703EmbAqMd8a63kW9FhWZL4874
         xli1bmb1c8IJfePRcPYj5M9kY/dJcgUfagH09wLLSOiZwxNRf15smrt/wXvh9KRqKiQi
         XwzH7+Vj+2ZFi7fAKRZExavXgLgC+fcOxHDY9nENyj8vJwGhvNHeWb8S/ND0frdMYpon
         BzoAeV+53U3XSxRROOj8Ojy+8c+/AHznJU/bEAtCqU5M3vayeiTJ7ADpR5xp1AMo0UAk
         QgEA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kIYhmHzz;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kIYhmHzz;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AIpwx48OxFm598CgjX7GuEn7m/sF9EuWudzkX+8qj3/2hEIzrktRze3hUXztVKykuh3XjxHQ1yhH/g==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Thu, 29 Mar 2018 12:02:55 +0200
From: Johan Hovold <johan@kernel.org>
To: Sanjeev Gupta <ghane0@gmail.com>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/usb: Fix dead links and convert others to
 https
Message-ID: <20180329100255.GA16578@localhost>
References: <20180328160752.17840-1-ghane0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328160752.17840-1-ghane0@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596198252944820308?=
X-GMAIL-MSGID: =?utf-8?q?1596265882353747991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 12:07:52AM +0800, Sanjeev Gupta wrote:
> All links checked, for those dead, I have replaced with copies on
> archive.org.  For some, https is not supported, http has been
> kept.
> 
> The git log says this was last done by Justin P. Mattock in 2010.
> Hi, Justin!

Not sure this belongs in the commit message (and did you forget to CC
Justin?).

> Signed-off-by: Sanjeev Gupta <ghane0@gmail.com>
> ---
>  Documentation/usb/usb-serial.txt | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
  
>    For any questions or problems with this driver, please contact Hugh
>    Blemings at hugh@misc.nu
> @@ -436,7 +437,8 @@ Winchiphead CH341 Driver
>    also implements an IEEE 1284 parallel port, I2C and SPI, but that is not
>    supported by the driver. The protocol was analyzed from the behaviour
>    of the Windows driver, no datasheet is available at present.
> -  The manufacturer's website: http://www.winchiphead.com/.
> +  The manufacturer's website:
> +  https://web.archive.org/web/20170911133726/http://winchiphead.com/ .

AFAICT this link is still working.

Johan
