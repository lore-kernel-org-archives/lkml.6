Return-Path: <hverkuil@xs4all.nl>
X-Google-Smtp-Source: AH8x227+AQVZnrxNVUFGZQMXbzCqmGSREWYo0iQC7Ytj5GgcBMzcPZ2NkMCIDSMe8cae4BEAAG7m
ARC-Seal: i=1; a=rsa-sha256; t=1519653086; cv=none;
        d=google.com; s=arc-20160816;
        b=VinWilcqEWeb4Rz+g9U42h1GzItwq7MO60utad/1SGVVlTZEC9Ol3gvfvZSdSnhr5X
         v3C83Pdtx0zeI34gT4Q/0ASjkJQ2e4Y9H3XDsKjZQVx+k7r0axJnqKRT2cvwK7T2MHIT
         sAgxgCz+gB1XUb7B5aI1kz+gQsasSER6ohVwje9ghy/ddMsitwd3iseB9TtZXC+hI3BU
         taUWvb0WO2BTBujA/tmHgFTDaC5nrwTtbJHrG5YawUkbibYgMCjkIi4x4vtd0RM4XUJx
         3YCXJGzfvdef+Z5T6eYSMqzpvAK+rBWjJb9IAm1wOPn4Ok0awbVVhaM45a7T+gUmpgfv
         6tJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=gLHEPpO9LPEWinvR1Jv0JLOiou7vc+C2Hy5EPDMNxPM=;
        b=MtRk+uzW/ccwJ9K3KN08uBB/ID4aoGbZYRE/mlLS71KsUyuVDP6u9fyK/De3PU5cIT
         fSsh3sDAbA2WthTjNV6Z2eq6ibvWlSvf8e+R9eanum5uEHCQQ9zrHCARJPMEoQDSZ/NQ
         9VHOaHd2ir+A400oM/tnD5ZY4FcA8VHQKJeErFHqkWdyXDoi+/g/WPgNXWD33c5+10h6
         2Ct/W4JCQCvHncm2SRsyjyx+E+sDJm5xbyFk1nfAZrCLjvV93UEI9fOfYTSKnyXIe/BG
         9zQGvkR3Q7XgH88ksK331pyKHXYFoMWt5Kle35VI+1DOywLI50K2GthzAgBb7jCDn1i1
         yRMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hverkuil@xs4all.nl designates 194.109.24.30 as permitted sender) smtp.mailfrom=hverkuil@xs4all.nl
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hverkuil@xs4all.nl designates 194.109.24.30 as permitted sender) smtp.mailfrom=hverkuil@xs4all.nl
Subject: Re: [PATCH v2] Staging: bcm2048: Fix function argument alignment in
 radio-bcm2048.c.
To: Quytelda Kahja <quytelda@tamalin.org>, gregkh@linuxfoundation.org,
 dan.carpenter@oracle.com, hans.verkuil@cisco.com
Cc: linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
References: <20180219072550.hz4vpomsaz2ajrnm@mwanda>
 <20180220065304.8943-1-quytelda@tamalin.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <cb62e915-eb9c-9252-1f0a-cc85c8ea3530@xs4all.nl>
Date: Mon, 26 Feb 2018 14:51:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180220065304.8943-1-quytelda@tamalin.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGOu+HXsM7oFxd/GRnfcEPEcz4qHYlskNb2XS9GnzvoyotRNp3B8+6p3VF222uF5BvtNxZczoiWA04vXZMmK9z/y8yUW5DaVVes6gU7/mr8p82ElghvY
 nxWYrtJijG3UIAHXedfejqwYJprzb2hCOx/ZdOlwyXUmWE5wdNXDewjRaA2kbU6A8JZpxpPEerndtD5S21w7bIdpzwpGFX+MDcWiT4gnZSmiIpy+u/O9T2Qp
 lWv0b7blCArg68JDu1jOK+oyt44VAEPFCsJfde2yT/8Wa7gBbUVTF576tLwYPE0OPNyVJYlSroArwUMOs9eaANl/4KQLynUggHajMMNSDykMtJnXD/5wfUrc
 WBmWRnL9
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592788103867027821?=
X-GMAIL-MSGID: =?utf-8?q?1593471754725947695?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/20/2018 07:53 AM, Quytelda Kahja wrote:
> Fix a coding style problem.

What coding style problem? You should give a short description of
what you are fixing.

> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
> This is the patch without the unnecessary fixes for line length.
> 
>  drivers/staging/media/bcm2048/radio-bcm2048.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/media/bcm2048/radio-bcm2048.c b/drivers/staging/media/bcm2048/radio-bcm2048.c
> index 06d1920150da..f38a4f2acdde 100644
> --- a/drivers/staging/media/bcm2048/radio-bcm2048.c
> +++ b/drivers/staging/media/bcm2048/radio-bcm2048.c
> @@ -1864,7 +1864,7 @@ static int bcm2048_probe(struct bcm2048_device *bdev)
>  		goto unlock;
>  
>  	err = bcm2048_set_fm_search_rssi_threshold(bdev,
> -					BCM2048_DEFAULT_RSSI_THRESHOLD);
> +						   BCM2048_DEFAULT_RSSI_THRESHOLD);
>  	if (err < 0)
>  		goto unlock;
>  

Just drop this change: it will replace one warning (non-aligned) with
another (> 80 cols).

This code is fine as it is.

Regards,

	Hans

> @@ -1942,9 +1942,9 @@ static irqreturn_t bcm2048_handler(int irq, void *dev)
>   */
>  #define property_write(prop, type, mask, check)				\
>  static ssize_t bcm2048_##prop##_write(struct device *dev,		\
> -					struct device_attribute *attr,	\
> -					const char *buf,		\
> -					size_t count)			\
> +				      struct device_attribute *attr,	\
> +				      const char *buf,			\
> +				      size_t count)			\
>  {									\
>  	struct bcm2048_device *bdev = dev_get_drvdata(dev);		\
>  	type value;							\
> @@ -1966,8 +1966,8 @@ static ssize_t bcm2048_##prop##_write(struct device *dev,		\
>  
>  #define property_read(prop, mask)					\
>  static ssize_t bcm2048_##prop##_read(struct device *dev,		\
> -					struct device_attribute *attr,	\
> -					char *buf)			\
> +				     struct device_attribute *attr,	\
> +				     char *buf)				\
>  {									\
>  	struct bcm2048_device *bdev = dev_get_drvdata(dev);		\
>  	int value;							\
> @@ -1985,8 +1985,8 @@ static ssize_t bcm2048_##prop##_read(struct device *dev,		\
>  
>  #define property_signed_read(prop, size, mask)				\
>  static ssize_t bcm2048_##prop##_read(struct device *dev,		\
> -					struct device_attribute *attr,	\
> -					char *buf)			\
> +				     struct device_attribute *attr,	\
> +				     char *buf)				\
>  {									\
>  	struct bcm2048_device *bdev = dev_get_drvdata(dev);		\
>  	size value;							\
> @@ -2005,8 +2005,8 @@ property_read(prop, mask)						\
>  
>  #define property_str_read(prop, size)					\
>  static ssize_t bcm2048_##prop##_read(struct device *dev,		\
> -					struct device_attribute *attr,	\
> -					char *buf)			\
> +				     struct device_attribute *attr,	\
> +				     char *buf)				\
>  {									\
>  	struct bcm2048_device *bdev = dev_get_drvdata(dev);		\
>  	int count;							\
> @@ -2175,7 +2175,7 @@ static int bcm2048_fops_release(struct file *file)
>  }
>  
>  static __poll_t bcm2048_fops_poll(struct file *file,
> -				      struct poll_table_struct *pts)
> +				  struct poll_table_struct *pts)
>  {
>  	struct bcm2048_device *bdev = video_drvdata(file);
>  	__poll_t retval = 0;
> 
