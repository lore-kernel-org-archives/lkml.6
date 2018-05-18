Return-Path: <rogerq@ti.com>
X-Google-Smtp-Source: AB8JxZoO7g5DVYZgtJJofY0zfYKt43BTy7/xCoPf+k9Zw8Tg4gsWAqHD1drQUn2ZuQKn6h2jC02q
ARC-Seal: i=1; a=rsa-sha256; t=1526630334; cv=none;
        d=google.com; s=arc-20160816;
        b=R5btNqlCdHp0v8TPTwgXFhMvVROFMgQO1oIhoGlVF7SUlHqzZom4qzb1kdl1OUXKi/
         V+4QhfY++sBHlaUDbAhP41RalGLv7ooCrg9hRHEayTqxnG7vk8XCJPFFdjgM4WSA4MLv
         vzwvkrUjT5edMITcrWZoBeOIhO/OmH2TV2DW867i7FPkOAz4O1CcYwgTTxQoJ0NV5eTO
         YO/tWrKjTu6AWwlL1/5HhGboDJoS4DLH61bjXk180X9gzJrcGu6xBa9AaaWR5EIcQmml
         VFu/Ui+n7+FZTlVHRUeMglzPS4w7o1m0yVakjnty5yZXUNTFL8SfjXJjJ1xUuNhjQ12t
         C5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:autocrypt:openpgp:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=ChASFdWERHXZbvnk47CDqxczUFXf2WAi/WRS7LcAFPM=;
        b=dJrKkCMZV4vKnxA0youaHHE31jA0M+4XNYJpUS/VbE8ROe1jfczB+dye8bFuqLM37n
         MifJTe5dAcH18n6kiwjRT8WA9tXbTGiRbIeVjZl9UMpOfEQLWcBU2q5S4X2Bti5euEiq
         2LEWEcxjmLwELbyzfVlPz+36/7z77+P9KQp8I5r0egTBLfw6ha780UuPpmfypQ97Dl/1
         ntQvybONIjiRsXokxbGZk625KuUTrNzZNYrS3fLXrUJLh3F4mqPq2xoA8Z5I/BaIof1T
         s/WAQMmtsrji3D6yCPNdpciAV0CwUZUalsTkIGavC67oeiXRwpl+LORbnLJyV+Jg+Qy5
         b1ow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=XOOKxIba;
       spf=pass (google.com: domain of rogerq@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=rogerq@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=XOOKxIba;
       spf=pass (google.com: domain of rogerq@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=rogerq@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [RFC PATCH linux-next] USB: dwc3: dwc3_get_extcon() can be static
To: Andrzej Hajda <a.hajda@samsung.com>,
        kbuild test robot
	<fengguang.wu@intel.com>
CC: <kbuild-all@01.org>, Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <201805180059.3X1bJsDZ%fengguang.wu@intel.com>
 <CGME20180517160655epcas3p2b8e0c7aa08f2138882a84b5e2b7b291a@epcas3p2.samsung.com>
 <20180517160641.GA55289@lkp-ib03>
 <8b363802-50f5-1da0-0879-fe8d38231f5e@samsung.com>
 <50b8c19d-563d-660c-9cf1-134c64062ba8@ti.com>
 <8c0c7001-550f-7b4d-33fd-47b3812d5c14@samsung.com>
From: Roger Quadros <rogerq@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=rogerq@ti.com; prefer-encrypt=mutual; keydata=
 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
 IwrfNkJOLj3CvocMIw==
Message-ID: <f1e9d179-2e80-4492-93d0-4a4bffd5dd9b@ti.com>
Date: Fri, 18 May 2018 10:58:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8c0c7001-550f-7b4d-33fd-47b3812d5c14@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600728031909224122?=
X-GMAIL-MSGID: =?utf-8?q?1600787930027096472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18/05/18 10:47, Andrzej Hajda wrote:
> On 18.05.2018 09:38, Roger Quadros wrote:
>> On 18/05/18 08:39, Andrzej Hajda wrote:
>>> On 17.05.2018 18:06, kbuild test robot wrote:
>>>> Fixes: 5f0b74e54890 ("USB: dwc3: get extcon device by OF graph bindings")
>>>> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
>>> It should be static of course, my bad.
>>>
>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>> I don't think we accept patches from robots, yet :)
> 
> What do you mean by 'we'? In case of whole kernel it is not true:
> 
> $ git log --author='kbuild test robot <fengguang.wu@intel.com>'
> --oneline | wc -l
> 183

OK, then I'm wrong. Should have checked before commenting. Sorry about that.

> 
> Regards
> Andrzej
> 
>>
>>>  --
>>> Regards
>>> Andrzej
>>>
>>>> ---
>>>>  drd.c |    2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
>>>> index 2706824..218371f 100644
>>>> --- a/drivers/usb/dwc3/drd.c
>>>> +++ b/drivers/usb/dwc3/drd.c
>>>> @@ -440,7 +440,7 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
>>>>  	return NOTIFY_DONE;
>>>>  }
>>>>  
>>>> -struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>>>> +static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>>>>  {
>>>>  	struct device *dev = dwc->dev;
>>>>  	struct device_node *np_phy, *np_conn;
>>>>
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
