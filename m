Return-Path: <heikki.krogerus@linux.intel.com>
X-Cyrus-Session-Id: sloti22d1t05-3278546-1521212765-2-11381499299320792129
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='192.55.52.88', Host='mga01.intel.com', Country='US', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: heikki.krogerus@linux.intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521212763; b=eJ9hTWvJSOvWoPIhSHkn/A5MazTpUrwhF2m8IX+iryx9Qyf
    ptM50krGiVbgtl0YyEaXovb0y9GnMAHewAt6UJO4hMZiwXe/ZZEtWh00aHoSrQHM
    JR+4ejQJJMEJF+4yWD/xtZo7xggS7ntcB1CKSDKsVJBtw3q0r8NtUcvXi8TCpw7y
    MTHSAynvSuDicbMCFiBA+lhWbrQ6+hdKBwOBA88/YS735zf92nJSZUy+wPzZh50y
    5TYJXHgJdKHzBFdWU12RJsIbgaIGOq9Tp/RTwT059++Ujw2AzCAodNDsCQsNLT14
    ehl3CXXBTsAgP/WJ0fiRCtpmu2xC8cxrTUdmTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521212763; bh=rE4qGoFE5qdjMKHy1FT0ZrdGG91DusG+bdTnL17F1V4=; b=p
    OCFtrzKrjkqJyWwSeSqSEHGFP+gIiry5sTrWn0wtYXojRH4ssR83kHk+4hny1OAY
    hEZ0g9mWfczJgS7wCzUArnM3XDYXKj5EO0XHnP5QaFBpIu9a5abDFHdIY5vjQC6h
    jE6+z7KOybXbuMkXRePlBHRR+Xxj+Km3Zun8xOGWEJ39fLLAXRRx+Yqs5C0+SQI9
    U48KI3F4ueT9RpfAg/PHv2lbe1Jry5Ra7d56zqCN1Z5aQA0g6uHMSxurdJBy7E34
    AXtDIYhKOEThv8jBZRYKbdUM4RrNAUzPikKkLpmRgvL9MdiqFx3hUWBaQBZpxPeI
    ON80OUv03XPoGNl+jdZqQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.88 (mga01.intel.com);
    spf=none smtp.mailfrom=heikki.krogerus@linux.intel.com smtp.helo=mga01.intel.com;
    x-aligned-from=pass;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=mga01.intel.com x-ptr-lookup=mga01.intel.com;
    x-return-mx=pass smtp.domain=linux.intel.com smtp.result=pass smtp_org.domain=intel.com smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.88 (mga01.intel.com);
    spf=none smtp.mailfrom=heikki.krogerus@linux.intel.com smtp.helo=mga01.intel.com;
    x-aligned-from=pass;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=mga01.intel.com x-ptr-lookup=mga01.intel.com;
    x-return-mx=pass smtp.domain=linux.intel.com smtp.result=pass smtp_org.domain=intel.com smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,316,1517904000";
   d="scan'208";a="38573949"
Date: Fri, 16 Mar 2018 17:05:55 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: ShuFan Lee <leechu729@gmail.com>
Cc: greg@kroah.com, linux@roeck-us.net, shufan_lee@richtek.com,
	cy_huang@richtek.com, jun.li@nxp.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] staging: typec: rt1711h typec chip driver
Message-ID: <20180316150555.GE11689@kuha.fi.intel.com>
References: <1521191569-21221-1-git-send-email-leechu729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521191569-21221-1-git-send-email-leechu729@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi ShuFan,

On Fri, Mar 16, 2018 at 05:12:49PM +0800, ShuFan Lee wrote:
> +static int rt1711h_init_gpio(struct rt1711h_chip *chip)
> +{
> +	int ret;
> +	struct device_node *np = chip->dev->of_node;
> +
> +	ret = of_get_named_gpio(np, "rt,intr_gpio", 0);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "%s get int gpio fail(%d)\n", __func__, ret);
> +		return ret;
> +	}
> +	chip->irq_gpio = ret;
> +
> +	ret = devm_gpio_request_one(chip->dev, chip->irq_gpio, GPIOF_IN,
> +				    dev_name(chip->dev));
> +	if (ret < 0) {
> +		dev_err(chip->dev, "%s request gpio fail(%d)\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	chip->irq = gpio_to_irq(chip->irq_gpio);
> +	if (chip->irq <= 0) {
> +		dev_err(chip->dev, "%s gpio2irq fail(%d)\n", __func__,
> +			chip->irq);
> +		return -EINVAL;
> +	}
> +	return 0;

"rt,intr_gpio" should probable be "rt,intr-gpio". Then this function
can be prepared for all types of platforms:

static int rt1711h_init_gpio(struct rt1711h_chip *chip)
{
        struct gpio_desc *gpio;

        gpio = devm_gpiod_get(chip->dev, "rt,intr", GFP_KERNEL);
        if (IS_ERR(gpio))
                return PTR_ERR(gpio);

        chip->irq = gpiod_to_irq(gpio);
	if (chip->irq < 0)
		return chip->irq;

	return 0;
}


Thanks,

-- 
heikki
