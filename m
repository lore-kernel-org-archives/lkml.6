Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1527105705; cv=none;
        d=google.com; s=arc-20160816;
        b=QUHUBMKhvfhCXI2/jjTiVlV4C9gUWJYwYA6EXf6qnRnYkcdPxQir83+My+mRvxmEvz
         uM6UBtJRDzil38MvebQHUUZjukUkkhg13DIvjdQ78G0W8AdIf1miMWRCksuGv4l4axOB
         46bsOKx6QaIKXPqhZ4FHCt8daHwEKPozhdAN7Lk6Q5IO+cS+VOcSs+eCE4lN5Hf9iGnP
         2rnKBxO9dIgX+9kPz+NvNeUe+pEI74s94E/ftmsvB+SW3iMn1cnhLwJ+KgyAczTepU4e
         Z4HY+ddku+DszxYi/mz4uu/kZ0VrxMqH+r79R+S1w+zQiRae5lOSwkrKcc13PxgqgBWf
         O6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=c4Cef6ATlJNUVGNzfInP5BA6yyeZjrh4Xw/V3PIOESE=;
        b=WjSg0vqTIho/89/0/YDZtR+N94vj8bHOJm+NAbeChw4fpMXv05aZ8Kq+C4VA3tSDZt
         H1ZH22EfKIH3gMgAIt0T/vns4L86C4Ek1TlYWIcivPwCGJZvYK4Ir5mgr0kCPXf3b9uk
         iJi4t9opBta0iXKh70fYc7wZAUXodVJ5WRC9a6P6icKYLKnA+7/fVZAsH844zX8IRi1s
         qJkgsz69t2A7UKslixl5YA/Sv3E7YlM+EqH+L4KGj0QVdYrsOXW3r4IGEBlp6OBwTayO
         PR/OKoreQRq/oGujGYX82hYTNAofTe7O3ajDN2jlM/kaf7dpHxaTtbqdDgwzIEZauKBw
         bc8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jT1KhwGv;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jT1KhwGv;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrQsEsLFv3nws+fDxDAz6lgmeWv/82IXuj8+4+WEVvlaN9aMRNdMDlmeUsJYkrEMgVcLZoMGg==
Subject: Re: [PATCH 1/2] slimbus: ngd: dt-bindings: Add slim ngd dt bindings
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, sdharia@quicinc.com,
 girishm@quicinc.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Banajit Goswami <bgoswami@codeaurora.org>, devicetree@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>
References: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
 <20180516165118.16551-2-srinivas.kandagatla@linaro.org>
 <20180523164023.GA24671@rob-hp-laptop>
 <4b83b699-59ad-b177-f360-3e76ba847892@linaro.org>
 <CAL_Jsq+YF+EFfqua_GTFU=cwf8oF3HCPCR09MWOoRCJf0-zVnQ@mail.gmail.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9bf83e8b-df06-ead9-1075-8b1a387d6052@linaro.org>
Date: Wed, 23 May 2018 21:01:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+YF+EFfqua_GTFU=cwf8oF3HCPCR09MWOoRCJf0-zVnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600640408468818070?=
X-GMAIL-MSGID: =?utf-8?q?1601286392344024397?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 23/05/18 20:28, Rob Herring wrote:
> On Wed, May 23, 2018 at 1:11 PM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>>
>> On 23/05/18 17:40, Rob Herring wrote:
>>>>
>>>> +
>>>> +- qcom,ngd-id
>>>> +       Usage: required
>>>> +       Value type: <u32>
>>>> +       Definition: ngd instance id in the controller
>>>
>>> Why do you need this?
>>>
>> Please ignore my comment from previous reply.
>>
>> There are more than one instances of ngd in this slim controller.
>> We need this to make sure we are programming the correct one.
> 
> Doesn't the parent-child relationship of devices on the bus provide
> that? 
Thanks for the hint, that sounds like the actual problem here,
If I represent the node with proper parent-child relationship like this, 
it will remove the need of this property and would work perfectly in 
case we want to support multiple ngds in future!

slim@91c0000 {
	compatible = "qcom,msm8996-slim";
	reg = <0x91c0000 0x2C000>;
	interrupts = <0 163 0>;
	dmas = <&slimbam 3>, <&slimbam 4>;
	dma-names = "rx", "tx";
	#address-cells = <1>;
	#size-cells = <1>;
	ngd@1 {
		reg  = <1>;
		#address-cells = <1>;
		#size-cells = <1>;
		codec@1 {
			compatible = "slim217,1a0";
			reg  = <1 0>;
		};	
	};
};



If you mean to provide consistent numbering to userspace, then
> that's not a DT problem (nor one that Linux plans to solve).
> 
No, this is not problem am trying to solve.

>> We also need this instance ID during powering it up using QMI.
> 
> Wouldn't that be a QMI ID?

It is passed as parameter to SLIMBUS_QMI_SELECT_INSTANCE_REQ_V01 request.

thanks,
srini
> 
> Rob
> 
